//
//  GoProCommand.swift
//  GoProBLE
//
//  Created by Mac on 01/03/2022.
//
import Foundation
import CoreBluetooth
class GoProCommand {
    private static var  StartShutterHex : [UInt8] = [0x03, 0x01, 0x01, 0x01]
    public static var StartShutter = Data(StartShutterHex)
    
    private static var StopShutterHex : [UInt8] = [0x03, 0x01, 0x01, 0x00]
    public static var StopShutter = Data(StopShutterHex)
    
    private static func GenerateCurrentDateHex() -> [UInt8] {
        let date = Date()
        
        let components = date.get(.year, .day, .month, .hour, .minute, .second)
        
        //0x09 = length
        //0x0D = command ID
        //0x07 = parameter length
        var dateCommand : [UInt8] = [0x09, 0x0D, 0x07, 0x07, 0xE6, 0x01, 0x02, 0x03, 0x04, 0x05]
        
        if //let year = components.year,
           let month = components.month,
           let day = components.day,
           let hour = components.hour,
           let minue = components.minute,
           let second = components.second {
            
            dateCommand[5] = UInt8(month)
            dateCommand[6] = UInt8(day)
            dateCommand[7] = UInt8(hour)
            dateCommand[8] = UInt8(minue)
            dateCommand[9] = UInt8(second)
        }
                                    
        
        return dateCommand
    }
    public static func CurrentDateData() -> Data {
        return Data(GenerateCurrentDateHex())
    }
    //0x46 = Battery percent
    //0x21 = sd card status
    //0x27 = total videos
    private static var GetAllStatusHex : [UInt8] = [0x05, 0x53, 0x46, 0x21, 0x27, 0x08]
    public static var GetAllStatus = Data(GetAllStatusHex)
    
}
