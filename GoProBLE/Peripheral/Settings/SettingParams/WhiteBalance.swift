//
//  WhiteBalance.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class WhiteBalance : Setting{
    
    
    public static let ID : UInt8 = 0x73
    
    public static let whitebalance = BiDictionary(array: [
        "6500K" : 0x03,
        "5500K": 0x02,
        "5000K": 0x0C,
        "4500K": 0x0B,
        "Auto": 0x00,
        "Native": 0x04,
        "4000K": 0x05,
        "3200K": 0x0A,
        "2800K": 0x09,
        "2300K": 0x08
    ])
    
    static func parse(code: UInt8) -> String {
        return whitebalance.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, whitebalance.forward[selected]!]
        
        return Data(hexValue)
    }
}
