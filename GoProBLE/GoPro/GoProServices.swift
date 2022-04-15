//
//  GoProServices.swift
//  GoProBLE
//
//  Created by Mac on 01/03/2022.
//

import Foundation
import CoreBluetooth

class GoProServices {
    public static var BatteryService = CBUUID.init(string: "0000180f-0000-1000-8000-00805f9b34fb")
    public static var InfoService = CBUUID.init(string: "0000180a-0000-1000-8000-00805f9b34fb")
    public static var ControlService = CBUUID.init(string: "0000fea6-0000-1000-8000-00805f9b34fb")
    public static var AllServices = [BatteryService, ControlService]
}
