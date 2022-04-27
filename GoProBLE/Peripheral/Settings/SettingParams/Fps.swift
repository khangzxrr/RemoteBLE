//
//  Fps.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

class Fps : Setting{
    
    
    public static let ID : UInt8 = 0x03
    
    public static let fps = BiDictionary(array: [
        "24" : 0x0A,
        "30" : 0x08,
        "60" : 0x05,
        "120" : 0x01,
        "240" : 0x00
    ])
    
    static func parse(code: UInt8) -> String {
        return fps.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, fps.forward[selected]!]
        
        return Data(hexValue)
    }
}
