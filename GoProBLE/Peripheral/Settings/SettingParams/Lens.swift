//
//  Lens.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation


class Lens : Setting {
    
    public static let ID : UInt8 = 0x79
    
    public static let lens = BiDictionary(array: [
        "Narrow": 0x02,
        "Linear": 0x04,
        "Linear+Horizon leveling": 0x08,
        "Wide": 0x00,
        "Superview": 0x03
    ])
    
    //Findout while cannot set superview
    static func parse(code: UInt8) -> String {
        return lens.backward[code]!
    }
    
    public static func GenerateSettingCommand(_ selected : String) -> Data{
        let hexValue : [UInt8] = [0x03, ID, 0x01, lens.forward[selected]!]
        
        return Data(hexValue)
    }
}
