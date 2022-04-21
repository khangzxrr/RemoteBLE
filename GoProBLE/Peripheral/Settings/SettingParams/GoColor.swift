//
//  GoColor.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class GoColor {
    public static let ID : UInt8 = 0x74
    
    public static let gocolor : [UInt8 : String] = [
        0x01: "Flat",
        0x00: "GoPro"
    ]
    
    public static let gocolorToCode : [String : UInt8] = [
        "Flat" : 0x01,
        "GoPro" : 0x00
    ]
    
    public static let gocolorValue = gocolorToCode.keys.sorted()
    
    public static func GenerateSettingCommand(selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, gocolorToCode[selected]!]
        
        return Data(hexValue)
    }
}
