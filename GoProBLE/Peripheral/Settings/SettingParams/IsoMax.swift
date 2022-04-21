//
//  IsoMax.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class IsoMax {
    public static let ID : UInt8 = 0x0D
    
    public static let isomax : [UInt8: String] = [
        0x08: "100",
        0x07: "200",
        0x02: "400",
        0x04: "800",
        0x01: "1600",
        0x03: "3200",
        0x00: "6400"
    ]
    
    public static let isoToCode : [String : UInt8] = [
        "100" : 0x08,
        "200" : 0x07,
        "400" : 0x02,
        "800" : 0x04,
        "1600" :0x01,
        "3200" : 0x03,
        "6400" : 0x00
    ]
    
    public static let isoValue = isoToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, isoToCode[selected]!]
        
        return Data(hexValue)
    }
}
