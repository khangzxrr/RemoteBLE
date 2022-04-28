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
    
    private static var SetVideoModeHex : [UInt8] = [0x04, 0x3E, 0x02, 0x03, 0xE8]
    public static var SetVideoMode = Data(SetVideoModeHex)
    
    private static var SetPhotoModeHex : [UInt8] = [0x04, 0x3E, 0x02, 0x03, 0xE9]
    public static var SetPhotoMode = Data(SetPhotoModeHex)
    
    private static var SetTimelapseModeHex : [UInt8] = [0x04, 0x3E, 0x02, 0x03, 0xEA]
    public static var SetTimelapseMode = Data(SetTimelapseModeHex)
    
    private static var PutToSleepHex : [UInt8] = [0x01, 0x05]
    public static var PutToSleep = Data(PutToSleepHex)
    
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
    //0x08 = is camera buysy
    //0x60 = current mode
    //0x23 = total mins left
    private static var GetAllStatusHex : [UInt8] = [0x06, 0x53, 0x46, 0x27, 0x08, 0x60, 0x23 ]
    public static var GetAllStatus = Data(GetAllStatusHex)
    
    
}
