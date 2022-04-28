//
//  SettingViewModel.swift
//  RemoteBLE
//
//  Created by Mac on 20/04/2022.
//

import Foundation
import CoreBluetooth

public class SettingViewModel : ObservableObject {
    //================ Setting =======================
    @Published var selectedResolution : String = Resolution.resolutions.displayValues.first!
    @Published var selectedFps = Fps.fps.displayValues.first!
    
    @Published var selectedLens = Lens.lens.displayValues.first!
    //4k - 30 fps gopro 9, if we set superview but 60 fps => it will fallback to wise
    
    @Published var selectedHypersmooth = Hypersmooth.hypersmooths.displayValues.first!
    @Published var selectedShutterSpeed = ShutterSpeed.shutters.displayValues.first!
    @Published var selectedEV = EV.ev.displayValues.first!
    @Published var selectedWhiteBalance = WhiteBalance.whitebalance.displayValues.first!
    @Published var selectedIsoMin = IsoMin.isomin.displayValues.first!
    @Published var selectedIsoMax = IsoMax.isomax.displayValues.first!
    @Published var selectedSharpness = Sharpness.sharpness.displayValues.first!
    @Published var selectedGoColor = GoColor.gocolor.displayValues.first!
    @Published var selectedWind = Wind.wind.displayValues.first!
    @Published var selectedGps = Gps.gps.displayValues.first!

    private var periAction : PeripheralActions? = nil
    
    public func setPeripheralAction(peripheralActions : PeripheralActions) {
        self.periAction = peripheralActions
    }
    
    public func sendingToSettingCharacter(_ data: Data) {
        guard let periAction = periAction else {
            print("periAction is not initiated")
            return
        }

        periAction.sendingToSettingCharacter(data)
    }
    
    
    public func parsingCameraSettings(_ statusBytesArray: inout [UInt8]) throws {
        switch statusBytesArray[0] {
        case Resolution.ID:
            print("Resolution ")
            selectedResolution = GoProDataParser.ParseSetting(&statusBytesArray, setting: Resolution.self)!
            
            break
            
        case Fps.ID:
            print("Fps: ")
            selectedFps = GoProDataParser.ParseSetting(&statusBytesArray, setting: Fps.self)!
            
            break
            
        case Lens.ID:
            print("Lens:")
            selectedLens = GoProDataParser.ParseSetting(&statusBytesArray, setting: Lens.self)!
            
            break
            
        case Hypersmooth.ID:
            print("Hypersmooth:")
            selectedHypersmooth = GoProDataParser.ParseSetting(&statusBytesArray, setting: Hypersmooth.self)!
            
            break
            
        case ShutterSpeed.ID:
            print("ShutterSpeed:")
            selectedShutterSpeed = GoProDataParser.ParseSetting(&statusBytesArray, setting: ShutterSpeed.self)!
            
            break
            
        case EV.ID:
            print("EV:")
            selectedEV = GoProDataParser.ParseSetting(&statusBytesArray, setting: EV.self)!
            break
            
        case WhiteBalance.ID:
            print("Whitebalance:")
            selectedWhiteBalance = GoProDataParser.ParseSetting(&statusBytesArray, setting: WhiteBalance.self)!
            
            break
            
        case IsoMin.ID:
            print("ISO min: ")
            selectedIsoMin = GoProDataParser.ParseSetting(&statusBytesArray, setting: IsoMin.self)!
            
            break
            
        case IsoMax.ID:
            print("ISO max: ")
            selectedIsoMax = GoProDataParser.ParseSetting(&statusBytesArray, setting: IsoMax.self)!
            break
            
        case Sharpness.ID:
            print("Sharpness: ")
            selectedSharpness = GoProDataParser.ParseSetting(&statusBytesArray, setting: Sharpness.self)!
            break
            
        case GoColor.ID:
            print("Color: ")
            selectedGoColor = GoProDataParser.ParseSetting(&statusBytesArray, setting: GoColor.self)!
            break
            
        case Wind.ID:
            print("Wind: ")
            selectedWind = GoProDataParser.ParseSetting(&statusBytesArray, setting: Wind.self)!
            break
            
        case Gps.ID:
            print("GPS")
            selectedGps = GoProDataParser.ParseSetting(&statusBytesArray, setting: Gps.self)!
            break
        default:
            break
        }
    }
    
 
}
