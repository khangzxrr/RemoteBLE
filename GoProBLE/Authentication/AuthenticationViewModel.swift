//
//  AuthenticationController.swift
//  RemoteBLE
//
//  Created by Mac on 15/04/2022.
//


import CoreData


class AuthenticationViewModel : ObservableObject {
    let container = NSPersistentContainer(name: "UserModel")
    
    @Published var isLogged = false
    @Published var user : UserModel?
    
    
    
}
