import SwiftUI
import SwiftData
import CodeScanner

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var scannedCode: String?
    @State private var showingResult = false

    var body: some View {
        ZStack {
            
            CodeScannerView(codeTypes: [.ean13], scanMode: .continuous) { response in
                switch response {
                case .success(let result):
                    print("Found code: \(result.string)")
                    scannedCode = result.string
                    showingResult = true
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
                .ignoresSafeArea()
            .sheet(isPresented: $showingResult) {
                if let code = scannedCode {
                                   ProductInfoView(productCode: code)
                               } else {
                                   ProductInfoView(productCode: "")
                               }
                               
        }
            TopCameraView()
        }
    }
}

struct ResultView: View {
    let scannedCode: String
    
    var body: some View {
        VStack {
            Text("Scanned Code:")
            Text(scannedCode)
                .font(.largeTitle)
            // Add more views here to display product information
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
