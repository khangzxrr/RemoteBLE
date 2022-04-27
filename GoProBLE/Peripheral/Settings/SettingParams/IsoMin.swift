//
//  IsoMin.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class IsoMin : Setting{
    
    
    public static let ID : UInt8 = 0x66
    
    public static let isomin = BiDictionary(array: [
        "100" : 0x08,
        "200" : 0x07,
        "400" : 0x02,
        "800" : 0x04,
        "1600" :0x01,
        "3200" : 0x03,
        "6400" : 0x00
    ])
    
    static func parse(code: UInt8) -> String {
        return isomin.backward[code]!
    }
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, isomin.forward[selected]!]
        
        return Data(hexValue)
    }
}
