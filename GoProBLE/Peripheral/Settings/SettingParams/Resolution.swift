//
//  Resolution.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class Resolution : Setting {
    
    public static let ID : UInt8 = 0x02

    public static var resolutions : BiDictionary = BiDictionary(array: [
        "1080p":0x09,
        "2.7K": 0x04,
        "4K": 0x01,
        "5K": 0x18
    ])
    
    //public static var resTocode : [String: UInt8] =
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, resolutions.forward[selected]!]
        
        return Data(hexValue)
    }
    
    static func parse(code: UInt8) -> String {
        return resolutions.backward[code]!
    }
}
