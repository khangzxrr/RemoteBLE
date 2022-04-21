import Foundation
import UIKit
import CoreBluetooth
import SwiftUI

open class BLEConnection: NSObject, CBCentralManagerDelegate, ObservableObject {
    
    private var centralManager: CBCentralManager! = nil
    
    @Published var scannedBLEDevices: [CBPeripheral] = []

    @Published var isShowErrorMessage = false
    @Published var errorMessage = ""

    var periModel: PeripheralModel! = PeripheralModel()
    
    //periModel is delegate of CBPeripheral
    //which used to perform gopro action
    var currentPeripheral: CBPeripheral! = nil
    
    //When BLE get timeout exception may cause by gopro turn on too slow
    //this variable use to identicate we already retry to connect or not
    private var retriedToConnect = false
    
    func startCentralManager() {
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        print("Central Manager State: \(self.centralManager.state)")
        
    }
    
    
    func clearAndRescan(){
        scannedBLEDevices.removeAll()
        centralManager.stopScan()
        
    }
    
    
    private func showError(_ message: String){
        self.isShowErrorMessage = true
        self.errorMessage = message
    }
    
    // Handles BT Turning On/Off
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        scannedBLEDevices = [] //remove old peripherals
        
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
            centralManager.scanForPeripherals(withServices: nil)
            break
        default:
            self.showError("Bluetooth is unknown")
            break
        }
        
    }
    
    public func connect(){
        print("connecting...")
        
        //MUST CLEAR Scanned devices or the next time you connect another device
        //BLE will hang, not sure why but this is the fix
        scannedBLEDevices = []
        
        
        periModel.clearDelegate()
        periModel.resetStates()
        centralManager.connect(currentPeripheral, options: nil)
    }
    
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        
        periModel.initPeripheral(peri: currentPeripheral, bleConnection: self)
        
        errorMessage = ""
    }
    
    
    public func reconnecting() {
        
        centralManager.connect(currentPeripheral)
        errorMessage = NSLocalizedString("peripheral:reconnecting", comment:  "reconnecting message")
    }
    
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        errorMessage = NSLocalizedString("peripheral:disconnected", comment:  "disconnected message")
        
        retriedToConnect = false
        
        currentPeripheral = peripheral
    }
    

    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("failed to connect")
        if !retriedToConnect {
            print("retry connect")
            reconnecting()
            retriedToConnect = true
        } else {
            showError("Fail to connect peripheral")
            retriedToConnect = false
            print(error!)
        }
        
        
    }
    
    func setSelectedPeripheral(_ peripheral: CBPeripheral){
        currentPeripheral = peripheral
    }
    
    private func isScannedListContainPeripheralByName(peripheral: CBPeripheral) -> Bool {
        for peri in scannedBLEDevices {
            if peri.name!.elementsEqual(peripheral.name!) {
                return true
            }
        }
        
        return false
    }
    
    // Handles the result of the scan
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //print("Peripheral Name: \(String(describing: peripheral.name))  RSSI: \(String(RSSI.doubleValue))")
        
        if peripheral.name != nil && !isScannedListContainPeripheralByName(peripheral: peripheral) && peripheral.name!.lowercased().contains("gopro")
            
        {
            self.scannedBLEDevices.append(peripheral)
        }
        
    }
}
