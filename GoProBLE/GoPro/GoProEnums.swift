//
//  GoProEnums.swift
//  GoProBLE
//
//  Created by Mac on 13/03/2022.
//

import Foundation


enum SDCard {
    case Ok
    case Full
    case Removed
    case FormatError
    case Busy
    case Swapped
    case Unknown
}

public enum Mode {
    case Timelapse
    case Video
    case Photo
}
