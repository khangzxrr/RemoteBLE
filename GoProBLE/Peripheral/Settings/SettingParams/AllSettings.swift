//
//  AllSettings.swift
//  RemoteBLE
//
//  Created by Mac on 27/04/2022.
//

import Foundation

class AllSettings {
    public static var settings : [UInt8 : Setting.Type] = [
        Resolution.ID: Resolution.self,
        Fps.ID: Fps.self,
        Lens.ID: Lens.self,
        Hypersmooth.ID: Hypersmooth.self,
        ShutterSpeed.ID: ShutterSpeed.self,
        EV.ID: EV.self,
        WhiteBalance.ID: WhiteBalance.self,
        IsoMin.ID: IsoMin.self,
        IsoMax.ID: IsoMax.self,
        Sharpness.ID: Sharpness.self,
        GoColor.ID: GoColor.self,
        Wind.ID: Wind.self
    ]
}
