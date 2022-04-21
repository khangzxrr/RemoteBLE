//
//  SettingView.swift
//  RemoteBLE
//
//  Created by Mac on 19/04/2022.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var peripheralModel : PeripheralModel
    
    @StateObject var settingModel = SettingViewModel()
    
    
    var body: some View {
        VStack {
   
            List {
                Picker("setting:resolution", selection: $peripheralModel.selectedResolution) {
                    ForEach(Resolution.resValue, id: \.self) { reso in
                        Text(reso)
                    }
                }.onChange(of: peripheralModel.selectedResolution) { selectedRes in
                    peripheralModel.sendingToSettingCharacter(Resolution.GenerateSettingCommand(selectedResolution: peripheralModel.selectedResolution))
                }
            
                
                Picker("setting:fps", selection: $peripheralModel.selectedFps) {
                    ForEach(Fps.fpsValue, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: peripheralModel.selectedFps) { selecFps in
                    print("sending fps")
                    peripheralModel.sendingToSettingCharacter(Fps.GenerateSettingCommand(selected: peripheralModel.selectedFps))
                }
                
                Picker("setting:lens", selection: $peripheralModel.selectedLens) {
                    ForEach(Lens.lensValue, id: \.self) { 
                        Text($0)
                    }
                }.onChange(of: peripheralModel.selectedLens) { selectedLen in
                    peripheralModel.sendingToSettingCharacter(Lens.GenerateSettingCommand(selected: selectedLen))
                }
                
                Picker("setting:hypersmooth", selection: $peripheralModel.selectedHypersmooth) {
                    ForEach(Hypersmooth.hypersmoothValue, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: peripheralModel.selectedHypersmooth) { selectedHyper in
                    peripheralModel.sendingToSettingCharacter(Hypersmooth.GenerateSettingCommand(selected: selectedHyper))
                }
                
                Group {
            
                    Picker("setting:shutterspeed", selection: $peripheralModel.selectedShutterSpeed) {
                        ForEach(ShutterSpeed.shutterspeedValue, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedShutterSpeed) { selected in
                        peripheralModel.sendingToSettingCharacter(ShutterSpeed.GenerateSettingCommand(selected: selected))
                    }
                    
                    
                    Picker("setting:ev", selection: $peripheralModel.selectedEV) {
                        ForEach(EV.evValue, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedEV) { selected in
                        peripheralModel.sendingToSettingCharacter(EV.GenerateSettingCommand(selected: selected))
                    }
                    
                    Picker("setting:whitebalance", selection: $peripheralModel.selectedWhiteBalance) {
                        ForEach(WhiteBalance.wbValue, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedWhiteBalance) { selected in
                        peripheralModel.sendingToSettingCharacter(WhiteBalance.GenerateSettingCommand(selected: selected))
                    }
                    
                    Picker("setting:isomin", selection: $peripheralModel.selectedIsoMin) {
                        ForEach(IsoMin.isoValue, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedIsoMin) { selected in
                        peripheralModel.sendingToSettingCharacter(IsoMin.GenerateSettingCommand(selected: selected))
                    }
                    
                    Picker("setting:isomax", selection: $peripheralModel.selectedIsoMax) {
                        ForEach(IsoMax.isoValue, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedIsoMax) { selected in
                        peripheralModel.sendingToSettingCharacter(IsoMax.GenerateSettingCommand(selected: selected))
                    }
                    
                    Picker("setting:sharpness", selection: $peripheralModel.selectedSharpness) {
                        ForEach(Sharpness.sharpnessValue, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedSharpness) { selected in
                        peripheralModel.sendingToSettingCharacter(Sharpness.GenerateSettingCommand(selected: selected))
                    }
                    
                    Picker("setting:gocolor", selection: $peripheralModel.selectedGoColor) {
                        ForEach(GoColor.gocolorValue, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedGoColor) { selected in
                        peripheralModel.sendingToSettingCharacter(GoColor.GenerateSettingCommand(selected: selected))
                    }
                }
            }
            
        }
        .navigationTitle("setting:title")
        .onAppear(){
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(peripheralModel: PeripheralModel())
    }
}
