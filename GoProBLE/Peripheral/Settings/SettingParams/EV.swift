//
//  EV.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation


class EV {
    public static let ID : UInt8 = 0x76
    
    public static let ev : [UInt8: String] = [
        0x00: "+2.0",
        0x01: "+1.5",
        0x02: "+1",
        0x03: "+0.5",
        0x04: "0",
        0x05: "-0.5",
        0x06: "-1",
        0x07: "-1.5",
        0x08: "-2.0"
    ]
    
    public static let evToCode : [String:UInt8] = [
        "+2.0" : 0x00,
        "+1.5" : 0x01,
        "+1" : 0x02,
        "+0.5" :0x03,
        "0": 0x04,
        "-0.5": 0x05,
        "-1": 0x06,
        "-1.5": 0x07,
        "-2.0": 0x08
    ]
    
    public static let evValue = evToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, evToCode[selected]!]
        
        return Data(hexValue)
    }
}
