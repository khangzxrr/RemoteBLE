//
//  PeripheralModel.swift
//  GoProBLE
//
//  Created by Mac on 04/03/2022.
//

import Foundation
import CoreBluetooth
import SwiftUI

public class PeripheralModel: NSObject, CBPeripheralDelegate, ObservableObject  {
    private var peripheral: CBPeripheral! = nil
    
    var goPro : GoPro! = nil
    
    @Published var isRecording = false
    
    
    @Published var batteryDisplay = "%"
    @Published var batteryBackground = Color.green
    
    @Published var totalVideos = "0"
    @Published var currentDate = Date()
    
    @Published var presentBleError = false
    @Published var navigatingBackToScanning = false
    
    func initPeripheral(peri: CBPeripheral){
        self.peripheral = peri
        
        goPro = GoPro()
        
        self.peripheral.delegate = self
        
        peripheral.discoverServices(nil)
        
        print("discover services...")
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(peripheral.services!)
        
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
        
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("discovered characteristic!!")
        print(service.characteristics!)
        
        for characteristic in service.characteristics! {
            
            switch characteristic.uuid{
                
            case GoProCharacteristics.Command:
                goPro.CommandCharacteristic = characteristic
                break
                
            case GoProCharacteristics.CommandResponse:
                peripheral.setNotifyValue(true, for: characteristic)
                break
                
            case GoProCharacteristics.Status:
                goPro.StatusCharacteristic = characteristic
                break
            case GoProCharacteristics.StatusResponse:
                goPro.StatusResponseCharacteristic = characteristic
                
                peripheral.setNotifyValue(true, for: characteristic)
                
                updateGoProData()
                
                break
                
            default:
                break
            }
            
        }
        
        
    }
    
    public func updateGoProData(){
        peripheral.writeValue(GoProCommand.GetAllStatus, for: goPro.StatusCharacteristic, type: .withResponse) //Get all status
        peripheral.writeValue(GoProCommand.CurrentDateData(), for: goPro.CommandCharacteristic, type: .withResponse) //set current date
        
    }
    
    public func recording(){
        if goPro.CommandCharacteristic == nil {
            presentBleError = true
            return
        }
        
        peripheral.writeValue(GoProCommand.StartShutter, for: goPro.CommandCharacteristic, type: .withResponse)
    }
    
    public func stoppingRecord(){
        peripheral.writeValue(GoProCommand.StopShutter, for: goPro.CommandCharacteristic, type: .withResponse)
    }
    
    
    private func processUpdatedData(_ statusBytesOriginal: Data) {
        
        var statusBytesArray = [UInt8](statusBytesOriginal)
        
        
        while statusBytesArray.count != 0 {

            switch statusBytesArray[0] {
                
            case 0x08:
                print("Is busy")
                isRecording = GoProDataParser.parse_CameraIsBusy(&statusBytesArray)
                break
                
            case 0x21:
                print("Primary storage status")
                print(GoProDataParser.parseSDCardStatus(&statusBytesArray))
                break
            
                
            case 0x27:
                print("Total videos in SD card")
                print()
                let totalVideosInCard = GoProDataParser.parseTotalVideosInSDCard(&statusBytesArray)
                
                totalVideos = String(totalVideosInCard)
                
                break
                
            case 0x46:
                print("Battery percent")
                print()
                let batteryPercent = GoProDataParser.parseBatteryPercent(&statusBytesArray)
                
                if batteryPercent > 80 {
                    batteryBackground = Color.blue
                } else if batteryPercent > 30{
                    batteryBackground = Color.orange
                } else {
                    batteryBackground = Color.red
                }
                
             
                
                batteryDisplay = String(batteryPercent) + " %"
                
                
                break
                
            default:
                break
            }
            
            
            
            
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Updated value!")
        
        if characteristic == goPro.StatusResponseCharacteristic {
            print("status response received!")
            var bytesArray = characteristic.value!
            
            print(bytesArray.hexEncodedString())
            
            bytesArray.removeFirst() //remove the length
            
            if bytesArray.first == 0x53 { //status update
                bytesArray.removeFirst(2) //0x53 00 00
                processUpdatedData(bytesArray)
            } else if bytesArray.first == 0x93 { //push status update
                bytesArray.removeFirst(2)
                processUpdatedData(bytesArray)
            }
            
          
        }
    }
    
}
