//
//  WhiteBalance.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class WhiteBalance {
    public static let ID : UInt8 = 0x73
    
    public static let wbToCode : [String: UInt8] = [
        "6500K" : 0x03,
        "5500K": 0x02,
        "5000K": 0x0C,
        "4500K": 0x0B,
        "Auto": 0x00,
        "Native": 0x04,
        "4000K": 0x05,
        "3200K": 0x0A,
        "2800K": 0x09,
        "2300K": 0x08
    ]
    
    public static let wb : [UInt8 : String] = [
        0x03: "6500K",
        0x02: "5500K",
        0x0C: "5000K",
        0x0B: "4500K",
        0x00: "Auto",
        0x04: "Native",
        0x05: "4000K",
        0x0A: "3200K",
        0x09: "2800K",
        0x08: "2300K"
    ]
    
    public static let wbValue = wbToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, wbToCode[selected]!]
        
        return Data(hexValue)
    }
}
