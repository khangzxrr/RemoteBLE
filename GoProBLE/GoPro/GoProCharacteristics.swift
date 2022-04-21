//
//  File.swift
//  GoProBLE
//
//  Created by Mac on 01/03/2022.
//

import Foundation
import CoreBluetooth

class GoProCharacteristics{
    public static var BatteryLevel = CBUUID.init(string: "00002a19-0000-1000-8000-00805f9b34fb")
    
    public static var SerialNumberString = CBUUID.init(string: "Serial Number String")
    
    public static var Command = CBUUID.init(string: "B5F90072-AA8D-11E3-9046-0002A5D5C51B")
    public static var CommandResponse = CBUUID.init(string: "B5F90073-AA8D-11E3-9046-0002A5D5C51B")
    
    public static var Setting = CBUUID.init(string: "B5F90074-AA8D-11E3-9046-0002A5D5C51B")
    public static var SettingResponse = CBUUID.init(string: "B5F90075-AA8D-11E3-9046-0002A5D5C51B")
    
    public static var Status = CBUUID.init(string: "B5F90076-AA8D-11E3-9046-0002A5D5C51B")
    public static var StatusResponse = CBUUID.init(string: "B5F90077-AA8D-11E3-9046-0002A5D5C51B")
    
    
    
}


