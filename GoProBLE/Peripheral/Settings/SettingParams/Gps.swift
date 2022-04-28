//
//  Gps.swift
//  RemoteBLE
//
//  Created by Mac on 27/04/2022.
//

import Foundation

class Gps : Setting {
    static var ID: UInt8 = 0x53
    
    static let gps = BiDictionary(array: [
        "On": 0x01,
        "Off": 0x00
    ])
    
    static func parse(code: UInt8) -> String {
        return gps.backward[code]!
    }
    
    static func GenerateSettingCommand(_ selected: String) -> Data {
        let hexValue : [UInt8] = [0x03, ID, 0x01, gps.forward[selected]!]
        
        return Data(hexValue)
    }
    
    
}
