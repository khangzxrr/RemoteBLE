//
//  Fps.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class Fps {
    public static let ID : UInt8 = 0x03
    
    public static let fpsToCode : [String: UInt8] = [
        "24" : 0x0A,
        "30" : 0x08,
        "60" : 0x05,
        "120" : 0x01,
        "240" : 0x00
    ]
    
    public static let fps: [UInt8: String] = [
        0x0A: "24",
        0x08: "30",
        0x05: "60",
        0x01: "120",
        0x00: "240"
    ]
    
    public static let fpsValue = fpsToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, fpsToCode[selected]!]
        
        return Data(hexValue)
    }
}
