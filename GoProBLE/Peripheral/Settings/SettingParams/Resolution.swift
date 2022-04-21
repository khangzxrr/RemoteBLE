//
//  Resolution.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class Resolution {
    public static let ID : UInt8 = 0x02
    
    
    
    
    public static var resTocode : [String: UInt8] = [
        "1080p":0x09,
        "2.7K": 0x04,
        "4K": 0x01,
        "5K": 0x18
    ]
    
    public static let resValue = resTocode.keys.sorted()
    
    public static var codeToRes : [UInt8 : String] = [
        0x09: "1080p",
        0x04: "2.7K",
        0x01: "4K",
        0x18: "5K"
    ]
    
    public static func GenerateSettingCommand(selectedResolution : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, resTocode[selectedResolution]!]
        
        return Data(hexValue)
    }
}
