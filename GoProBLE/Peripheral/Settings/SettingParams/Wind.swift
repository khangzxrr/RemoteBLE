//
//  Wind.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation
class Wind : Setting{
    
    
    public static let ID : UInt8 = 0x95
    public static let wind = BiDictionary(array: [
        "Off" : 0x00,
        "On" : 0x04,
        "Auto" : 0x02
    ])
    
    static func parse(code: UInt8) -> String {
        return wind.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, wind.forward[selected]!]
        
        return Data(hexValue)
    }
}
