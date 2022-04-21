//
//  HyperSmooth.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class Hypersmooth {
    public static let ID : UInt8 = 0x87
    
    public static let hypersmooth : [UInt8 : String] = [
        0x02: "High",
        0x01: "On",
        0x00: "Off",
        0x03: "Boost"
    ]
    
    public static let hypersmoothToCode : [String : UInt8] = [
        "On" : 0x01,
        "High": 0x02,
        "Off" : 0x00,
        "Boost" : 0x03
    ]
    
    public static let hypersmoothValue = hypersmoothToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, hypersmoothToCode[selected]!]
        
        return Data(hexValue)
    }
}
