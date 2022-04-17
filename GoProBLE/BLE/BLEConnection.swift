import Foundation
import UIKit
import CoreBluetooth
import SwiftUI

open class BLEConnection: NSObject, CBCentralManagerDelegate, ObservableObject {
    private var centralManager: CBCentralManager! = nil
    
    @Published var scannedBLEDevices: [CBPeripheral] = []

    @Published var isShowErrorMessage = false
    @Published var errorMessage = ""

    @Published var successConnect = false

    
    var periModel: PeripheralModel? =  nil
    
    var currentPeripheral: CBPeripheral! = nil
    
    //When BLE get timeout exception may cause by gopro turn on too slow
    //this variable use to identicate we already retry to connect or not
    private var retriedToConnect = false
    
    func startCentralManager() {
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        print("Central Manager State: \(self.centralManager.state)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.centralManagerDidUpdateState(self.centralManager)
        }
    }
    
    func stopScanning(){
        centralManager.stopScan()
    }
    
    func clearAndRescan(){
        scannedBLEDevices.removeAll()
        
        centralManager.stopScan()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.centralManagerDidUpdateState(self.centralManager)
        }
        
    }
    
    
    private func showError(_ message: String){
        self.isShowErrorMessage = true
        self.errorMessage = message
    }
    // Handles BT Turning On/Off
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
        case .unsupported:
            self.showError("Bluetooth is unsupported")
            break
        case .unauthorized:
            self.showError("Bluetooth is not allowed")
            break
        case .unknown:
            self.showError("Bluetooth is unknown")
            break
        case .resetting:
            self.showError("Bluetooth is resetting")
            break
        case .poweredOff:
            self.showError("Bluetooth is turned off")
            break
        case .poweredOn:
            print("Central scanning")
            self.centralManager.scanForPeripherals(withServices: nil)
            break
        default:
            self.showError("Bluetooth is unknown")
            break
        }
        
        if(central.state != CBManagerState.poweredOn)
        {
            // In a real app, you'd deal with all the states correctly
            return;
        }
    }
    
    public func connect(_ peripheral: CBPeripheral,  _ periModel : PeripheralModel){
        centralManager.connect(peripheral, options: nil)
        self.periModel = periModel
        
        //update current peripheral
        currentPeripheral = peripheral
    }
    
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        periModel!.initPeripheral(peri: peripheral)
        
        
        successConnect = true
        errorMessage = ""
    }
    
    
    public func reconnecting() {
        
        if currentPeripheral != nil {
            centralManager.connect(currentPeripheral, options: nil)
            errorMessage = "Reconnecting..."
        }
        
    }
    
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        errorMessage = "Disconnected... Tap to reconnect"
        
        currentPeripheral = peripheral
        successConnect = false
    }
    
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
        if !retriedToConnect {
            print("retry connect")
            reconnecting()
            retriedToConnect = true
        } else {
            showError("Fail to connect peripheral")
            print(error)
        }
        
        
    }
    
    // Handles the result of the scan
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //print("Peripheral Name: \(String(describing: peripheral.name))  RSSI: \(String(RSSI.doubleValue))")
        
        if peripheral.name != nil && !scannedBLEDevices.contains(peripheral){
            self.scannedBLEDevices.append(peripheral)
        }
        
    }
}
