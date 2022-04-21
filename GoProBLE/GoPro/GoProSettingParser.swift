//
//  GoProSettingParser.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

extension GoProDataParser {
    
    
    public static func ParseResolution(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        print(statusByteArray)
        return Resolution.codeToRes[statusByteArray.removeFirst()]!
    }
    
    public static func ParseFps(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return Fps.fps[statusByteArray.removeFirst()]!
    }
    
    public static func ParseLens(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return Lens.lens[statusByteArray.removeFirst()]!
    }
    
    public static func ParseHypersmooth(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return Hypersmooth.hypersmooth[statusByteArray.removeFirst()]!
    }
    
    public static func ParseShutterSpeed(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return ShutterSpeed.shutterspeed[statusByteArray.removeFirst()]!
    }
    
    public static func ParseEV(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return EV.ev[statusByteArray.removeFirst()]!
    }
    
    public static func ParseWhiteBalance(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return WhiteBalance.wb[statusByteArray.removeFirst()]!
    }
    
    public static func ParseISO(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return IsoMin.isomin[statusByteArray.removeFirst()]!
    }
    
    public static func ParseSharpness(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return Sharpness.sharpness[statusByteArray.removeFirst()]!
    }
   
    public static func ParseColor(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return GoColor.gocolor[statusByteArray.removeFirst()]!
    }
    
    public static func ParseWind(_ statusByteArray: inout [UInt8]) -> String {
        statusByteArray.removeFirst(2) //remove ID and length
        
        return Wind.wind[statusByteArray.removeFirst()]!
    }
}
