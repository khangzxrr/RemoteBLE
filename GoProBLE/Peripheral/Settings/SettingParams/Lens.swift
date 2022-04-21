//
//  Lens.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation


class Lens {
    public static let ID : UInt8 = 0x79
    
    public static let lensValue = lensToCode.keys.sorted()
    
    public static let lens: [UInt8: String] = [
        0x02: "Narrow",
        0x04: "Linear",
        0x08: "Linear+Horizon leveling",
        0x00: "Wide",
        0x03: "Superview"
    ]
    
    public static let lensToCode : [String: UInt8] = [
        "Narrow": 0x02,
        "Linear": 0x04,
        "Linear+Horizon leveling": 0x08,
        "Wide": 0x00,
        "Superview": 0x03
    ]
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, lensToCode[selected]!]
        
        return Data(hexValue)
    }
}
