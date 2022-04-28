//
//  PeripheralActionProtocol.swift
//  RemoteBLE
//
//  Created by Mac on 27/04/2022.
//

import Foundation

public protocol PeripheralActions {
    func sendingToSettingCharacter(_ data: Data)
    func sendingToStatusCharacter(_ data: Data)
    func sendingCommand(_ data: Data)
}
