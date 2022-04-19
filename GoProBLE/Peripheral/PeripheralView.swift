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
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(bleConnection.errorMessage).bold().onTapGesture {
                        bleConnection.reconnecting()
                    }
                }
                
                
                //This navigation link will bring back ScanningView when error happen
                NavigationLink(destination: BLEScanningView().navigationBarBackButtonHidden(true),
                               isActive: $periModel.navigatingBackToScanning){}
                    .hidden()
                
                
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
                    
                    Spacer()
                    
                }.blur(radius: periModel.successDiscoveredCharacteristic ? 0 : 20)
               
            }
            .navigationTitle("")
  
    }
    
}
    

