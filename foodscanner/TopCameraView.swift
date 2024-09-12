//
//  TopCameraView.swift
//  foodscanner
//
//  Created by felipe ivan on 10/09/24.
//

import SwiftUI

struct TopCameraView: View {
    var body: some View {
            ZStack {
                 // Background for camera view
           
                VStack {
               
                    Text("Escanea algun producto \n para ver su información").foregroundStyle(.white)
                    Spacer()
                 
                }
                
                Image(systemName: "viewfinder.rectangular")
                    .font(.system(size: 200).weight(.ultraLight))
                    .foregroundStyle(.white)
                 
            }
    }
}

#Preview {
    TopCameraView()
}
