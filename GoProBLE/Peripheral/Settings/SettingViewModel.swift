//
//  SettingViewModel.swift
//  RemoteBLE
//
//  Created by Mac on 20/04/2022.
//

import Foundation
import CoreBluetooth

class SettingViewModel : ObservableObject {
    private var periModel : PeripheralModel?
    
    
    public func setPeripheralModel(_ peripheralModel : PeripheralModel){
        periModel = peripheralModel
    }
    
 
}
