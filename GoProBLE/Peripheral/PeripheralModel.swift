//
//  PeripheralModel.swift
//  GoProBLE
//
//  Created by Mac on 04/03/2022.
//

import Foundation
import CoreBluetooth
import SwiftUI

public class PeripheralModel: NSObject, CBPeripheralDelegate, ObservableObject, PeripheralActions  {
    public var peripheral: CBPeripheral! = nil
    
    public var settingModel = SettingViewModel()
    
    private var bleConnection : BLEConnection! = nil
    
    var goPro : GoPro! = nil
    
    @Published var currentMode = Mode.Video
    
    @Published var isRecording = false
    
    @Published var batteryDisplay = "%"
    @Published var batteryBackground = Color.green
    @Published var batteryIcon = "battery.100"
    
    @Published var totalVideos = "0"
    @Published var timeleft = "0H:0M"
    
    @Published var currentDate = Date()
    
    @Published var presentBleError = false
    @Published var navigatingBackToScanning = false
    
    @Published var successDiscoveredCharacteristic = false
    
    private var tempData : TempDataContainer! = nil
    
    
    func resetStates() {
        successDiscoveredCharacteristic = false
        presentBleError = false
        navigatingBackToScanning = false
    }
    
    func initPeripheral(peri: CBPeripheral, bleConnection : BLEConnection){
        
        //reference to bleConnection class to perform connect, reconnect
        self.bleConnection = bleConnection
        
        
        self.peripheral = peri
        
        goPro = GoPro()
        
        settingModel.setPeripheralAction(peripheralActions: self)
        
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
        
        for characteristic in service.characteristics! {
            
            switch characteristic.uuid{
                
            case GoProCharacteristics.Command:
                goPro.CommandCharacteristic = characteristic
                break
                
            case GoProCharacteristics.Setting:
                print("setting registed")
                goPro.SettingCharacteristic = characteristic
                break
                
            case GoProCharacteristics.SettingResponse:
                print("setting response registed")
                goPro.SettingResponseCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
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
        
        successDiscoveredCharacteristic = true
        
        
    }
    
    public func updateGoProData(){
        peripheral.writeValue(GoProCommand.GetAllStatus, for: goPro.StatusCharacteristic, type: .withResponse) //Get all status
        peripheral.writeValue(GoProCommand.CurrentDateData(), for: goPro.CommandCharacteristic, type: .withResponse) //set current date
        
        self.sendingToStatusCharacter(SettingCommands.GetAllSetting)
    }
    
    //for safety purpose
    //remove delegate may release memory or reduce freeze bluetooth function
    public func clearDelegate() {
        if peripheral != nil {
            peripheral.delegate = nil
        }
    }
    
    public func checkingPeripheralStateBeforePerformAction() {
        if goPro.CommandCharacteristic == nil {
            presentBleError = true
            return
        }
        
        if peripheral.state == .disconnected {
            successDiscoveredCharacteristic = false
            bleConnection.reconnecting()
        }
    }
    
    public func sendingToSettingCharacter(_ data: Data) {
        peripheral.writeValue(data, for: goPro.SettingCharacteristic, type: .withResponse)
        
        
    }
    public func sendingToStatusCharacter(_ data: Data) {
        peripheral.writeValue(data, for: goPro.StatusCharacteristic, type: .withResponse)
    }
    
    public func sendingCommand(_ data: Data){
        checkingPeripheralStateBeforePerformAction()
        peripheral.writeValue(data, for: goPro.CommandCharacteristic, type: .withResponse)
    }
    
    public func recording(){
        sendingCommand(GoProCommand.StartShutter)
        
        if currentMode == .Timelapse {
            isRecording = true //manual, because timelapse doesnt send busy command
        }
    }
    
    public func stoppingRecord(){
        sendingCommand(GoProCommand.StopShutter)
        if currentMode == .Timelapse {
            isRecording = false
        }
    }
    
    public func putToSleep(){
        sendingCommand(GoProCommand.PutToSleep)
        successDiscoveredCharacteristic = false
    }
    
    public func setMode(_ mode : Mode){
        currentMode = mode
        
        switch mode {
        case .Photo:
            sendingCommand(GoProCommand.SetPhotoMode)
            break
        case .Video:
            sendingCommand(GoProCommand.SetVideoMode)
            break
        case .Timelapse:
            sendingCommand(GoProCommand.SetTimelapseMode)
            break
        }
    }
    
    //trigger to update setting
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic == goPro.SettingCharacteristic {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("written to setting characteristic")
                self.sendingToStatusCharacter(SettingCommands.GetAllSetting)
            }
            
            
        }
    }
    
    private func parsingCameraFunctionState(_ statusBytesArray: inout [UInt8]) throws {
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
            print("Update total videos in card")
            let totalVideosInCard = GoProDataParser.parseTotalVideosInSDCard(&statusBytesArray)
            
            totalVideos = String(totalVideosInCard)
            
            break
            
        case 0x46:
            print("Battery percent updated")
            let batteryPercent = GoProDataParser.parseBatteryPercent(&statusBytesArray)
            
            if batteryPercent > 70 {
                batteryBackground = Color.green
                batteryIcon = "battery.100"
            } else if batteryPercent > 50{
                batteryBackground = Color.blue
                batteryIcon = "battery.75"
            } else if batteryPercent > 35 {
                batteryBackground = Color.orange
                batteryIcon = "battery.50"
            } else {
                batteryBackground = Color.red
                batteryIcon = "battery.25"
            }
            
            batteryDisplay = String(batteryPercent) + " %"
            break
        case 0x60:
            print("Current mode")
            
            let modeID = GoProDataParser.parseCurrentMode(&statusBytesArray)
            currentMode = modeID
            
            print(modeID)
            break
        case 0x23:
            print("Total minues left")
            
            let minsStringConverted = GoProDataParser.parseMinLeft(&statusBytesArray)
            timeleft = minsStringConverted
            
            break
        default:
            break
        }
    }
    
    private func processUpdatedData(_ statusBytesOriginal: Data) {
        
        var statusBytesArray = [UInt8](statusBytesOriginal)
        
        print("bytes: ", statusBytesOriginal.hexEncodedString())
        
        do {
            while statusBytesArray.count != 0 {
                try parsingCameraFunctionState(&statusBytesArray)
                
                if statusBytesArray.count > 0 {
                    try settingModel.parsingCameraSettings(&statusBytesArray)
                }
            }
        } catch {
            print("Catched exception ")
        }
        
        
        
        
        
        
    }
    
    public func trimUnnessecsaryByteAndUpdateData(_ originalBytes: Data) {
        var bytesArray = originalBytes
        
        if bytesArray.first == 0x52 { //setting update
            bytesArray.removeFirst(2)
            processUpdatedData(bytesArray)
            
            return
        }
        if bytesArray.first == 0x92 { //setting push update
            bytesArray.removeFirst(2)
            processUpdatedData(bytesArray)
            
            return
        }
        
        if bytesArray.first == 0x53 { //status update
            bytesArray.removeFirst(2) //0x53 00 00
            //print("bytes: ", bytesArray.hexEncodedString())
            processUpdatedData(bytesArray)
        } else if bytesArray.first == 0x93 { //push status update
            bytesArray.removeFirst(2)
            processUpdatedData(bytesArray)
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        //I dont support other mode than Video yet
        if currentMode != .Video {
            return
        }
        
        
        if characteristic == goPro.StatusResponseCharacteristic {
            var bytesArray = characteristic.value!
            
            print(bytesArray.hexEncodedString())
            
            //0x20 mean data does not fit in one package
            //so it split into multiple package
            //we will listen then concat it as one and put it to processUpdateData function as normal
            if bytesArray.first! == 0x20 {
                bytesArray.removeFirst() //remove 0x20 identicator
                let expectedLength = Int(bytesArray.removeFirst())

                tempData = TempDataContainer(byteArray: bytesArray,
                                             expectedLength: expectedLength,
                                             removedBytesLength: 0)

                return
            }

            if bytesArray.first! >= 0x80 && bytesArray.first! <= 0x8F {
                bytesArray.removeFirst() //remove 0x80...0x8F continue package identicator

                tempData.byteArray.append(contentsOf: bytesArray)

            } else { //not continous package

                bytesArray.removeFirst() //remove the length
                trimUnnessecsaryByteAndUpdateData(bytesArray)
            }

            if tempData != nil {
                //if enough data
                if tempData.byteArray.count  == tempData.expectedLength {
                    trimUnnessecsaryByteAndUpdateData(tempData.byteArray)

                    tempData = nil
                }
            }

            
            
            
        }
    }
    
}
