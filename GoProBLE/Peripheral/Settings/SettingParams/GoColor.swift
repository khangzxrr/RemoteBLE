//
//  GoColor.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class GoColor : Setting {
    
    
    public static let ID : UInt8 = 0x74
    
    public static let gocolor = BiDictionary(array: [
        "Flat" : 0x01,
        "GoPro" : 0x00
    ])
    
    static func parse(code: UInt8) -> String {
        return gocolor.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, gocolor.forward[selected]!]
        
        return Data(hexValue)
    }
}
