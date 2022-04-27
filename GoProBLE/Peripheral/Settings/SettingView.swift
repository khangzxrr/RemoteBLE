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
            Text("setting:warning")
            List {
                Picker("setting:resolution", selection: $peripheralModel.selectedResolution) {
                    ForEach(Resolution.resolutions.displayValues, id: \.self) { reso in
                        Text(reso)
                    }
                }
                .padding()
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: peripheralModel.selectedResolution) { selectedRes in
                    
                    peripheralModel.sendingToSettingCharacter(Resolution.GenerateSettingCommand( peripheralModel.selectedResolution))
                }
            
                
                Picker("setting:fps", selection: $peripheralModel.selectedFps) {
                    ForEach(Fps.fps.displayValues, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: peripheralModel.selectedFps) { selecFps in
                    print("sending fps")
                    peripheralModel.sendingToSettingCharacter(Fps.GenerateSettingCommand(peripheralModel.selectedFps))
                }
                
                Picker("setting:lens", selection: $peripheralModel.selectedLens) {
                    ForEach(Lens.lens.displayValues, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: peripheralModel.selectedLens) { selectedLen in
                    peripheralModel.sendingToSettingCharacter(Lens.GenerateSettingCommand(selectedLen))
                }
                
                Picker("setting:hypersmooth", selection: $peripheralModel.selectedHypersmooth) {
                    ForEach(Hypersmooth.hypersmooths.displayValues, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: peripheralModel.selectedHypersmooth) { selectedHyper in
                    peripheralModel.sendingToSettingCharacter(Hypersmooth.GenerateSettingCommand( selectedHyper))
                }
                
                Group {
            
                    Picker("setting:shutterspeed", selection: $peripheralModel.selectedShutterSpeed) {
                        ForEach(ShutterSpeed.shutters.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedShutterSpeed) { selected in
                        peripheralModel.sendingToSettingCharacter(ShutterSpeed.GenerateSettingCommand( selected))
                    }
                    
                    
                    Picker("setting:ev", selection: $peripheralModel.selectedEV) {
                        ForEach(EV.ev.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedEV) { selected in
                        peripheralModel.sendingToSettingCharacter(EV.GenerateSettingCommand(selected))
                    }
                    
                    Picker("setting:whitebalance", selection: $peripheralModel.selectedWhiteBalance) {
                        ForEach(WhiteBalance.whitebalance.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedWhiteBalance) { selected in
                        peripheralModel.sendingToSettingCharacter(WhiteBalance.GenerateSettingCommand(selected))
                    }
                    
                    Picker("setting:isomin", selection: $peripheralModel.selectedIsoMin) {
                        ForEach(IsoMin.isomin.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedIsoMin) { selected in
                        peripheralModel.sendingToSettingCharacter(IsoMin.GenerateSettingCommand( selected))
                    }
                    
                    Picker("setting:isomax", selection: $peripheralModel.selectedIsoMax) {
                        ForEach(IsoMax.isomax
                            .displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedIsoMax) { selected in
                        peripheralModel.sendingToSettingCharacter(IsoMax.GenerateSettingCommand(selected))
                    }
                    
                    Picker("setting:sharpness", selection: $peripheralModel.selectedSharpness) {
                        ForEach(Sharpness.sharpness.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedSharpness) { selected in
                        peripheralModel.sendingToSettingCharacter(Sharpness.GenerateSettingCommand( selected))
                    }
                    
                    Picker("setting:gocolor", selection: $peripheralModel.selectedGoColor) {
                        ForEach(GoColor.gocolor.displayValues, id: \.self) {
                            Text($0)
                        }
                    }.onChange(of: peripheralModel.selectedGoColor) { selected in
                        peripheralModel.sendingToSettingCharacter(GoColor.GenerateSettingCommand( selected))
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
