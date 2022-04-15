//
//  PeripheralView.swift
//  GoProBLE
//
//  Created by Mac on 28/02/2022.
//

import SwiftUI
import CoreBluetooth

struct PeripheralView: View {
    
    let peripheral: CBPeripheral?
    
    @EnvironmentObject var bleConnection : BLEConnection
    
    //The rule is this: whichever view is the first to create your object must use @StateObject, to tell SwiftUI it is the owner of the data and is responsible for keeping it alive. All other views must use @ObservedObject, to tell SwiftUI they want to watch the object for changes but don’t own it directly
    @StateObject var periModel = PeripheralModel()
    
    
    @State var busyButtonColorChange = true
    
    var body: some View {
   
        NavigationView {
            VStack(alignment: .center, spacing: 20){
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(bleConnection.errorMessage).bold().onTapGesture {
                        bleConnection.reconnecting()
                    }
                }
                
                VStack{
                    HStack {
                        Text(periModel.currentDate, style: .date).bold()
                    }
                    HStack {
                        Text("Total videos in SD card: ")
                        Text(periModel.totalVideos).bold()
                    }
                    HStack{
                        Text("Battery Level:")
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
                        Button(!periModel.isRecording ? "Rec" : "Stop"){
                            print("record")
                            if !periModel.isRecording {
                                periModel.recording()
                                
                            } else {
                                periModel.stoppingRecord()
                            }

                        }
                        .buttonStyle(ShutterButton())
                        
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
                    
                }.blur(radius: bleConnection.successConnect ? 0 : 20)
               
            }
          
          
            
            .navigationTitle(peripheral!.name!)
            
        }
        //must place navigation setting next to navigationview
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(true)
        .onAppear(perform: {
            bleConnection.connect(peripheral!, periModel)
        })
    }
}

struct PeripheralView_Previews: PreviewProvider {
    @State static var peri : CBPeripheral? = nil
    static var previews: some View {
        
        PeripheralView(peripheral: peri!)
    }
}
