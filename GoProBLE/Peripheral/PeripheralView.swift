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
                        Spacer()
                        Button("peripheral:puttosleep") {
                            periModel.putToSleep()
                        }
                    }.padding()
                    
                    HStack {
                        Text(periModel.currentDate, style: .date).bold()
                    }
                    HStack {
                        Text("peripheral:totalvideos")
                        Text(periModel.totalVideos).bold()
                    }
                    HStack{
                        Text("peripheral:batterylevel")
                        Text(periModel.batteryDisplay).bold()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(periModel.batteryBackground)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    )
                    .foregroundColor(.white)
                    .transition(.slide)
                    
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
                        Button("Timelapse")  {
                            periModel.setMode(.Timelapse)
                        }
                        .padding()
                        .background(periModel.currentMode == .Timelapse ? Color.blue : Color.clear)
                        .cornerRadius(30)
                        .foregroundColor(periModel.currentMode == .Timelapse ? Color.white : Color.black)
                        
                        Button("Video") {
                            periModel.setMode(.Video)
                        }
                        .padding()
                        .background(periModel.currentMode == .Video ? Color.blue : Color.clear)
                        .cornerRadius(30)
                        .foregroundColor(periModel.currentMode == .Video ? Color.white : Color.black)
                        
                        Button("Photo") {
                            periModel.setMode(.Photo)
                        }
                        .padding()
                        .background(periModel.currentMode == .Photo ? Color.blue : Color.clear)
                        .cornerRadius(30)
                        .foregroundColor(periModel.currentMode == .Photo ? Color.white : Color.black)
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        NavigationLink("peripheral:setting", destination: SettingView())
                            .opacity(periModel.currentMode == .Video ? 1 : 0)
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
    

