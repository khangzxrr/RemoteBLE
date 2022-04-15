//
//  ContentView.swift
//  GoProBLE
//
//  Created by Mac on 27/02/2022.
//

import SwiftUI
import CoreBluetooth

struct BlesView: View {
    //StateObject is the owner of the object, other views use this shared object
    @StateObject var bleConnection = BLEConnection()
    
    @State var animatedList = false
    
    var body: some View {
        
        NavigationView {
            
            List(bleConnection.scannedBLEDevices, id: \.identifier) { scannedBLEDevice in
                NavigationLink(scannedBLEDevice.name!, destination: PeripheralView(peripheral: scannedBLEDevice))
            }
            .animation(.easeOut(duration: 2), value: animatedList)
            .toolbar {
                Button("Clear and rescan") {
                    bleConnection.scannedBLEDevices.removeAll()
                }
            }
            .navigationBarTitle("BLE Devices")
            .onAppear(perform: {
                bleConnection.startCentralManager()
            })
       
        }.environmentObject(bleConnection)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlesView()
    }
}
