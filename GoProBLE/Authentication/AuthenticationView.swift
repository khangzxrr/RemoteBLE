//
//  AuthenticationView.swift
//  RemoteBLE
//
//  Created by Mac on 15/04/2022.
//

import SwiftUI


struct AuthenticationView: View {
    
    @State var accept = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 2.0){
                NavigationLink(destination: BLEScanningView().navigationBarBackButtonHidden(true), isActive: $accept){
                }
                .hidden()
                
                Text("Hi, before you can continue. \nif you encounter any bugs\nplease contact me via\n")
                    .padding(.top, 20)

                
                Link("Click here > Facebook: Võ Ngọc Khang", destination: URL(string: "fb://profile/meracle.vn")!).padding()
                
                
                Button("Accept and continue") {
                    accept = true
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
                .foregroundColor(.white)
                
                Spacer()
                
            }
            .navigationTitle("Authentication")
            .navigationBarTitleDisplayMode(.large)
           
           
        }
        
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
