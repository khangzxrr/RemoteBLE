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
            VStack(alignment: .center, spacing: 15.0){
                NavigationLink(destination: BLEScanningView().navigationBarBackButtonHidden(true), isActive: $accept){
                }
                .hidden()
                
                Text("authentication:introduction")
                    .padding(.top, 20)
                    //.padding(.leading, 20)
                    .padding(.horizontal, 20)

                Link("authentication:facebook", destination: URL(string: "fb://profile/meracle.vn")!).padding()
                
                Button {
                    accept = true
                } label: {
                    Label("authentication:accept", systemImage: "checkmark.circle.fill")
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(30)
                .foregroundColor(.white)
                
                Spacer()
                
            }
            .navigationTitle("authentication:title")
            .navigationBarTitleDisplayMode(.large)
            .onAppear() {
                let defaults = UserDefaults.standard
                if defaults.object(forKey: "FirstTime") == nil {
                    defaults.set("No", forKey: "FirstTime")
                    return
                } else {
                    accept = true
                }
            }
           
        }
        
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
