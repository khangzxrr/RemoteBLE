//
//  GoProDataParser.swift
//  GoProBLE
//
//  Created by Mac on 13/03/2022.
//

import Foundation

class GoProDataParser {
    
    public static func parse_ValueLength_Data(_ statusBytesArray: inout [UInt8]) -> (valueLength: Int, data: Data) {
        let valueLength : UInt8 = statusBytesArray[1]
        
        statusBytesArray.removeFirst(2) //remove status ID, value length
        
        let bytesLength = Int(valueLength)
        
        let value = statusBytesArray.prefix(bytesLength) //get bytes equal to value length
        
        let valueDataConverted = Data(value)
        
        print("Value length: ", bytesLength)
        print("Data: ", valueDataConverted.hexEncodedString())
        
        return (bytesLength, valueDataConverted)
    }
    
    public static func parse_CameraIsBusy(_ statusBytesArray: inout [UInt8]) -> Bool {
        statusBytesArray.removeFirst()
        statusBytesArray.removeFirst()
        
        return statusBytesArray.removeFirst() == 0 ? false : true
    }
    
    public static func parseBatteryPercent(_ statusBytesArray: inout [UInt8]) -> Int {
        let parsedResult = parse_ValueLength_Data(&statusBytesArray)
        
        let valueInt8 = parsedResult.data.withUnsafeBytes { pointer in
            return pointer.load(as: Int8.self)
        }
        
        statusBytesArray.removeFirst(parsedResult.valueLength) //remove value bytes
        
        return Int(valueInt8)
    }
    
    public static func parseTotalVideosInSDCard(_ statusBytesArray: inout [UInt8]) -> Int {
        let parsedResult = parse_ValueLength_Data(&statusBytesArray)
        
        let valueInt32 = UInt32(parsedResult.data.hexEncodedString(), radix: 16)
        
        statusBytesArray.removeFirst(parsedResult.valueLength) //remove value bytes
        
        return Int(valueInt32!)
    }
    
    
    public static func parseSDCardStatus(_ statusBytesArray: inout [UInt8]) -> SDCard{
        let parsedResult = parse_ValueLength_Data(&statusBytesArray)
        
        let valueInt8 = parsedResult.data.withUnsafeBytes { pointer in
            return pointer.load(as: Int8.self)
        }
        
        statusBytesArray.removeFirst(parsedResult.valueLength) //remove value bytes
    
        
        switch valueInt8 {
        case 0:
            return SDCard.Ok
        case 1:
            return SDCard.Full
        case 2:
            return SDCard.Removed
        case 3:
            return SDCard.FormatError
        case 4:
            return SDCard.Busy
        case 8:
            return SDCard.Swapped
        default:
            return SDCard.Unknown
        }
        
    }
}
