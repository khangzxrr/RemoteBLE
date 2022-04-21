//
//  Sharpness.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation
class Sharpness {
    public static let ID : UInt8 = 0x75
    
    public static let sharpness : [UInt8 : String] = [
        0x02: "Low",
        0x01: "Medium",
        0x00: "High"
    ]
    public static let sharpnessToCode : [String : UInt8] = [
        "Low" : 0x02,
        "Medium" : 0x01,
        "High": 0x00
    ]
    
    public static let sharpnessValue = sharpnessToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, sharpnessToCode[selected]!]
        
        return Data(hexValue)
    }
}
