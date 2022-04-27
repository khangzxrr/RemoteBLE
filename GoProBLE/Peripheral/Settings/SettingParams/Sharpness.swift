//
//  Sharpness.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation
class Sharpness : Setting {
    
    
    public static let ID : UInt8 = 0x75
    
    public static let sharpness = BiDictionary(array: [
        "Low" : 0x02,
        "Medium" : 0x01,
        "High": 0x00
    ])
    
    static func parse(code: UInt8) -> String {
        return sharpness.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, sharpness.forward[selected]!]
        
        return Data(hexValue)
    }
}
