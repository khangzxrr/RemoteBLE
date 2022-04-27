//
//  EV.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation


class EV : Setting{
    
    
    public static let ID : UInt8 = 0x76
    
    public static let ev = BiDictionary(array: [
        "+2.0" : 0x00,
        "+1.5" : 0x01,
        "+1" : 0x02,
        "+0.5" :0x03,
        "0": 0x04,
        "-0.5": 0x05,
        "-1": 0x06,
        "-1.5": 0x07,
        "-2.0": 0x08
    ])
    
    static func parse(code: UInt8) -> String {
        return ev.backward[code]!
    }
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, ev.forward[selected]!]
        
        return Data(hexValue)
    }
}
