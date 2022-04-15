//
//  ContentView.swift
//  GoProBLE
//
//  Created by Mac on 27/02/2022.
//

import SwiftUI
import CoreBluetooth

import Auth0

struct BLEScanningView: View {
    //StateObject is the owner of the object, other views use this shared object
    @StateObject var bleConnection = BLEConnection()
    
    @State var animatedList = false
    
    var body: some View {
        VStack {
            HStack{
                Text("Please wait...1 2 3....").opacity($bleConnection.scannedBLEDevices.count > 0 ? 0 : 1)
                
                Spacer()
                
                Button("Clear and rescan") {
                    bleConnection.scannedBLEDevices.removeAll()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(40)
            }
            
           
            List(bleConnection.scannedBLEDevices, id: \.identifier) { scannedBLEDevice in
                NavigationLink(scannedBLEDevice.name!, destination: PeripheralView(peripheral: scannedBLEDevice).environmentObject(bleConnection).navigationBarBackButtonHidden(true)
                )
            }
            .animation(.easeOut(duration: 2), value: animatedList)
            
            .navigationBarTitle("BLE Devices")
            .onAppear(perform: {
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
