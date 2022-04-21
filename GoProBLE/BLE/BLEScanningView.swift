//
//  ContentView.swift
//  GoProBLE
//
//  Created by Mac on 27/02/2022.
//

import SwiftUI
import CoreBluetooth


struct BLEScanningView: View {
    //StateObject is the owner of the object, other views use this shared object
    @StateObject var bleConnection = BLEConnection()
    
    @State var selectedPeripheral = false
    @State var animatedList = false
    
    var body: some View {
        
        NavigationLink("",
                       destination: PeripheralView(periModel: bleConnection.periModel, bleConnection: bleConnection),
                       isActive: $selectedPeripheral)
            .hidden()
                       
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text("blescanning:waiting").opacity(bleConnection.scannedBLEDevices.count > 0 ? 0 : 1)
                    .padding()
                
                Spacer()
                
                Button("blescanning:clearandrescan") {
                    bleConnection.scannedBLEDevices.removeAll()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(40)
            }
            
           
            List(bleConnection.scannedBLEDevices, id: \.identifier) { scannedBLEDevice in
                
                Button(scannedBLEDevice.name!){
                    bleConnection.setSelectedPeripheral(scannedBLEDevice)
                    
                    bleConnection.connect()
                    
                    selectedPeripheral = true //active flag to navigate to PeripheralView
                }
            }
            .animation(.easeOut(duration: 2), value: animatedList)
            
            .navigationBarTitle("blescanning:title")
            .onAppear(perform: {
                print("hi")
                bleConnection.startCentralManager()
            })
        }
        
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BLEScanningView()
    }
}
