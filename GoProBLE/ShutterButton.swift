//
//  ShutterButton.swift
//  GoProBLE
//
//  Created by Mac on 10/03/2022.
//

import Foundation
import SwiftUI


struct ShutterButton : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 50))
            .padding()
            .frame(width: 150, height: 150, alignment: .center)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
    }
}


struct BusyButton : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .padding()
            .frame(width: 20, height: 20, alignment: .center)
            .background(Color.white)
            .foregroundColor(Color.white)
            .clipShape(Circle())
    }
}

