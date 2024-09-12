//
//  CameraView.swift
//  foodscanner
//
//  Created by felipe ivan on 09/09/24.
//

import SwiftUI
import CodeScanner

struct CameraView: View {
    var body: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson") { response in
            switch response {
            case .success(let result):
                print("Found code: \(result.string)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    CameraView()
}
