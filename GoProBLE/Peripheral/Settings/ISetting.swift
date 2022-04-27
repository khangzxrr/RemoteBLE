//
//  ISetting.swift
//  RemoteBLE
//
//  Created by Mac on 27/04/2022.
//

import Foundation

protocol Setting {
    static var ID : UInt8 { get }
    static func parse(code : UInt8) -> String
    static func GenerateSettingCommand(_ selected : String) -> Data
}
