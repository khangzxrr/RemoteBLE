//
//  HyperSmooth.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class Hypersmooth : Setting {
    
    
    public static let ID : UInt8 = 0x87
    
    public static let hypersmooths = BiDictionary(array: [
        "On" : 0x01,
        "High": 0x02,
        "Off" : 0x00,
        "Boost" : 0x03
    ])
    
    static func parse(code: UInt8) -> String {
        return hypersmooths.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, hypersmooths.forward[selected]!]
        
        return Data(hexValue)
    }
}
