//
//  Wind.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation
class Wind {
    public static let ID : UInt8 = 0x95
    public static let wind : [UInt8 : String] = [
        0x00: "Off",
        0x04: "On",
        0x02: "Auto"
    ]
    
    public static let windToCode : [String : UInt8] = [
        "Off" : 0x00,
        "On" : 0x04,
        "Auto" : 0x02
    ]
    
    public static let windValue = windToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, windToCode[selected]!]
        
        return Data(hexValue)
    }
}
