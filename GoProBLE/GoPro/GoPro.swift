//
//  GoPro.swift
//  GoProBLE
//
//  Created by Mac on 01/03/2022.
//

import CoreBluetooth

class GoPro{
    public var BatteryLevelCharacteristic: CBCharacteristic! = nil
    public var SerialNumberStringCharacteristic: CBCharacteristic! = nil
    
    public var CommandCharacteristic: CBCharacteristic! = nil
    public var CommandResponseCharacteristic: CBCharacteristic! = nil
    
    public var StatusCharacteristic: CBCharacteristic! = nil
    public var StatusResponseCharacteristic: CBCharacteristic! = nil
    
    public var SettingCharacteristic: CBCharacteristic! = nil
    public var SettingResponseCharacteristic: CBCharacteristic! = nil
}
