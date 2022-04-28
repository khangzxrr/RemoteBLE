//
//  PeripheralView.swift
//  GoProBLE
//
//  Created by Mac on 28/02/2022.
//

import SwiftUI
import CoreBluetooth

struct PeripheralView: View {
    
    //The rule is this: whichever view is the first to create your object must use @StateObject, to tell SwiftUI it is the owner of the data and is responsible for keeping it alive. All other views must use @ObservedObject, to tell SwiftUI they want to watch the object for changes but don’t own it directly
    @ObservedObject var periModel : PeripheralModel
    @ObservedObject var bleConnection : BLEConnection
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var busyButtonColorChange = true
    
    var body: some View {
        
        
            VStack(alignment: .center, spacing: 20){
                
                Text(bleConnection.errorMessage).bold().foregroundColor(.red).onTapGesture {
                    bleConnection.reconnecting()
                    //Reconnecting issue: When disconnect too long then connect back, it will hang without throw any exception
                    
                }
                .alert(isPresented: $periModel.presentBleError) {
                    Alert(
                        title: Text("peripheral:bluetootherror"),
                        message: Text("peripheral:bluetootherrordescription"),
                        dismissButton: .default(Text("peripheral:accepterror")) {
                            periModel.navigatingBackToScanning = true
                        }
                    )
                }
               
                VStack{
                    HStack {
                        Label(periModel.batteryDisplay, systemImage: "battery.75")
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(periModel.batteryBackground)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            periModel.putToSleep()
                        } label: {
                            Label("peripheral:puttosleep", systemImage: "sleep.circle.fill")
                        }
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                    }.padding()
                    
                    HStack {
                        Text(periModel.currentDate, style: .date).bold()
                    }
                    HStack {
                        Text("peripheral:totalvideos")
                        Text(periModel.timeleft + " (" + String(periModel.totalVideos) + " videos)").bold()
                    }
                    
                    HStack(alignment: .center, spacing: 20){
                        Button(!periModel.isRecording ? "peripheral:rec" : "peripheral:stop"){
                            
                            if !periModel.isRecording {
                                periModel.recording()
                                
                            } else {
                                periModel.stoppingRecord()
                            }

                        }
                        .buttonStyle(ShutterButton())
                        .disabled(!periModel.successDiscoveredCharacteristic)
                        
                        //Blinking button
                        Button(""){
                            
                        }
                        .buttonStyle(BusyButton())
                        .colorMultiply(busyButtonColorChange ? Color.red : Color.gray)
                        .onChange(of: periModel.isRecording){ isRecording in
                            if isRecording {
                                withAnimation(.easeOut(duration: 1).repeatForever(autoreverses: true)) {
                                    busyButtonColorChange.toggle()
                                }
                            } else {
                                withAnimation(.easeOut(duration: 1)) {
                                    busyButtonColorChange.toggle()
                                }
                            }
                        }
                       
                    }
                    
                    HStack(alignment: .center, spacing: 30) {
                        Button  {
                            periModel.setMode(.Timelapse)
                            
                        } label: {
                            Label("Lapse", systemImage: "timelapse")
                        }
                        .padding()
                        .background(periModel.currentMode == .Timelapse ? Color.blue : Color.white)
                        .cornerRadius(30)
                        .foregroundColor(periModel.currentMode == .Timelapse ? Color.white : Color.black)
                        
                        Button {
                            periModel.setMode(.Video)
                        } label: {
                            Label("Video", systemImage: "video.fill")
                        }
                        .padding()
                        .background(periModel.currentMode == .Video ? Color.blue : Color.white)
                        .cornerRadius(30)
                        .foregroundColor(periModel.currentMode == .Video ? Color.white : Color.black)
                        
                        Button {
                            periModel.setMode(.Photo)
                        } label: {
                            Label("Photo", systemImage: "photo")
                        }
                        .padding()
                        .background(periModel.currentMode == .Photo ? Color.blue : Color.white)
                        .cornerRadius(30)
                        .foregroundColor(periModel.currentMode == .Photo ? Color.white : Color.black)
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        NavigationLink("peripheral:setting", destination: SettingView(settingModel: periModel.settingModel))
                            .opacity(periModel.currentMode == .Video ? 1 : 0)
                            .disabled(periModel.currentMode != .Video)
                    }
                    .padding(30)
                    
                    Spacer()
                    
                    NavigationLink(destination: BLEScanningView().navigationBarBackButtonHidden(true),
                                   isActive: $periModel.navigatingBackToScanning){}
                        .hidden()
                    
                }.blur(radius: periModel.successDiscoveredCharacteristic ? 0 : 20)
               
            }
            .navigationTitle(bleConnection.currentPeripheral.name!)
            .onAppear() {
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false
                
            }
    }
    
}
    

