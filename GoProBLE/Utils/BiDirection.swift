//
//  BiDirection.swift
//  RemoteBLE
//
//  Created by Mac on 27/04/2022.
//

import Foundation



class BiDictionary {
    
    public var forward : Dictionary<String, UInt8> = [:]
    public var backward : Dictionary<UInt8, String> = [:]
    
    public var displayValues : Array<String> = []
    
    private func generateBackward(){
        for value in forward.values {
            for key in forward.keys {
                if forward[key] == value {
                    backward[value] = key
                    break
                }
            }
        }
    }
    
    private func generateForward(){
        for key in backward.values {
            for value in backward.keys {
                if backward[value] == key {
                    forward[key] = value
                    break
                }
            }
        }
    }
    
    private func generateDisplayValues() {
        displayValues = Array(forward.keys)
    }
    
    public init(array : Dictionary<UInt8, String>){
        backward = array
        generateForward()
        
        generateDisplayValues()
    }
    
    public init(array : Dictionary<String, UInt8>){
        forward = array
        generateBackward()
        
        generateDisplayValues()
    }
    
    
}
