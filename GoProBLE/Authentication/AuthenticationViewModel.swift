//
//  AuthenticationController.swift
//  RemoteBLE
//
//  Created by Mac on 15/04/2022.
//

import Auth0
import JWTDecode

import CoreData


class AuthenticationViewModel : ObservableObject {
    let container = NSPersistentContainer(name: "UserModel")
    
    @Published var isLogged = false
    @Published var user : UserModel?
    
    init() {
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    
        loadUser()
    }
    
    func loadUser(){
        let userFetchRequest = UserModel.fetchRequest()
        do {
            
            user  = try container.viewContext.fetch(userFetchRequest).first
            
            if user != nil {
                print(user!)
                isLogged = true
            }
            
            
        } catch {
            print("Could not load data: \(error.localizedDescription)")
        }
    }
    
    func parsingJWTcredentials(_ credentials : Credentials){
        if user != nil {
            return
        }
        
        print("Obtained credentials: \(credentials)")
        guard let jwt = try? decode(jwt: credentials.idToken),
              let name = jwt.claim(name: "name").string,
              let pictureURL = jwt.claim(name: "picture").string else { return }
        print("Name: \(name)")
        print("Picture URL: \(pictureURL)")

        let user = UserModel(context: container.viewContext)
        
        do {
            let url = URL(string: pictureURL)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            user.name = name
            user.picture = data!
            
            try container.viewContext.save()
        } catch {
            print("Coud not save data \(error.localizedDescription)")
        }
        
        loadUser()
        
    }
    
    func login() {
        Auth0
            .webAuth()
            .start { result in
                
                switch result {
                case .success(let credentials):
                    self.parsingJWTcredentials(credentials)

                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
    
}
