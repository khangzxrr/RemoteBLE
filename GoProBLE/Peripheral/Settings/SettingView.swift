//
//  SettingView.swift
//  RemoteBLE
//
//  Created by Mac on 19/04/2022.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var settingModel : SettingViewModel
    
    var body: some View {
        VStack {
            Text("setting:warning")
            List {
                
                Picker("setting:resolution", selection: $settingModel.selectedResolution) {
                    ForEach(Resolution.resolutions.displayValues, id: \.self) { reso in
                        Text(reso)
                    }
                }
                .padding()
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: settingModel.selectedResolution) { selectedRes in
                    
                    settingModel.sendingToSettingCharacter(Resolution.GenerateSettingCommand( settingModel.selectedResolution))
                }
                
                Picker("setting:fps", selection: $settingModel.selectedFps) {
                    ForEach(Fps.fps.displayValues, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: settingModel.selectedFps) { selecFps in
                    print("sending fps")
                    settingModel.sendingToSettingCharacter(Fps.GenerateSettingCommand(settingModel.selectedFps))
                }
                
                Picker("setting:lens", selection: $settingModel.selectedLens) {
                    ForEach(Lens.lens.displayValues, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: settingModel.selectedLens) { selectedLen in
                    settingModel.sendingToSettingCharacter(Lens.GenerateSettingCommand(selectedLen))
                }
                
                Picker("setting:hypersmooth", selection: $settingModel.selectedHypersmooth) {
                    ForEach(Hypersmooth.hypersmooths.displayValues, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: settingModel.selectedHypersmooth) { selectedHyper in
                    settingModel.sendingToSettingCharacter(Hypersmooth.GenerateSettingCommand( selectedHyper))
                }
                
                Group {
            
                    //Add filter function to get correct shutter stops
                    Picker("setting:shutterspeed", selection: $settingModel.selectedShutterSpeed) {
                        ForEach(ShutterSpeed.shutters.displayValues.filter {
                                    if $0 == "Auto" {
                                        return true
                                    }
                            
                                    let splittedShutter = $0.split(separator: "/")
                            
                                    return (Int(splittedShutter[1])! % Int(settingModel.selectedFps)! == 0) &&
                                            (Int(splittedShutter[1])! / Int(settingModel.selectedFps)! <= 16)
                                },
                                id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedShutterSpeed) { selected in
                        settingModel.sendingToSettingCharacter(ShutterSpeed.GenerateSettingCommand( selected))
                    }
                    
                    //
                    Picker("setting:ev", selection: $settingModel.selectedEV) {
                        ForEach(EV.ev.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedEV) { selected in
                        settingModel.sendingToSettingCharacter(EV.GenerateSettingCommand(selected))
                    }.disabled(settingModel.selectedShutterSpeed != "Auto")
                    
                    Picker("setting:whitebalance", selection: $settingModel.selectedWhiteBalance) {
                        ForEach(WhiteBalance.whitebalance.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedWhiteBalance) { selected in
                        settingModel.sendingToSettingCharacter(WhiteBalance.GenerateSettingCommand(selected))
                    }
                    
                    Picker("setting:isomin", selection: $settingModel.selectedIsoMin) {
                        ForEach(IsoMin.isomin.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedIsoMin) { selected in
                        settingModel.sendingToSettingCharacter(IsoMin.GenerateSettingCommand( selected))
                    }
                    
                    Picker("setting:isomax", selection: $settingModel.selectedIsoMax) {
                        ForEach(IsoMax.isomax
                            .displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedIsoMax) { selected in
                        settingModel.sendingToSettingCharacter(IsoMax.GenerateSettingCommand(selected))
                    }
                    
                    Picker("setting:sharpness", selection: $settingModel.selectedSharpness) {
                        ForEach(Sharpness.sharpness.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedSharpness) { selected in
                        settingModel.sendingToSettingCharacter(Sharpness.GenerateSettingCommand( selected))
                    }
                    
                    Picker("setting:gocolor", selection: $settingModel.selectedGoColor) {
                        ForEach(GoColor.gocolor.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedGoColor) { selected in
                        settingModel.sendingToSettingCharacter(GoColor.GenerateSettingCommand( selected))
                    }
                    
                    Picker("setting:gps", selection: $settingModel.selectedGps) {
                        ForEach(Gps.gps.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: settingModel.selectedGps) { selected in
                        print("sending gps")
                        settingModel.sendingToSettingCharacter(Gps.GenerateSettingCommand(selected))
                    }
                }
            }
            
        }
        .navigationTitle("setting:title")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(settingModel: SettingViewModel())
    }
}
