//
//  GoProSettingParser.swift
//  RemoteBLE
//
//  Created by Mac on 21/04/2022.
//

import Foundation

extension GoProDataParser {
    
    public static func ParseSetting(_ statusByteArray: inout [UInt8], setting : Setting.Type) -> String? {
        statusByteArray.removeFirst(2) //remove ID, length
        
        let code = statusByteArray.removeFirst() //get code
       
        return setting.parse(code: code)
    }
    
    
    
   

}
