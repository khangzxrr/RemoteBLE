//
//  ShutterSpeed.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation
class ShutterSpeed : Setting {
   
    
    public static let ID : UInt8 = 0x91
    
    public static let shutters = BiDictionary(array: [
        "Auto" : 0x00,
        "1/24" : 0x03,
        "1/30" : 0x05,
        "1/48" : 0x06,
        "1/60" : 0x08,
        "1/96" : 0x0B,
        "1/120" : 0x0D,
        "1/192" : 0x10,
        "1/240" : 0x12,
        "1/384" : 0x19,
        "1/480" : 0x16,
        "1/960" : 0x17,
        "1/1920" : 0x18,
        "1/3840" : 0x1F
    ])
    
    static func parse(code: UInt8) -> String {
        return shutters.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, shutters.forward[selected]!]
        
        return Data(hexValue)
    }
}
