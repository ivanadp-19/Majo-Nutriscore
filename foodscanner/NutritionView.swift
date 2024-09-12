import SwiftUI


struct ProductInfoView: View {
    @StateObject private var viewModel = ProductViewModel()
    let productCode: String
   
    func translateNutrientLevel(_ level: String) -> String {
           switch level.lowercased() {
           case "high":
               return "Alto"
           case "low":
               return "Bajo"
           case "moderate":
               return "Moderado"
           default:
               print(level)
               return level
           }
       }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if viewModel.errorMessage != nil {
                    Text("Hubo un error obteniendo esta información")
                        .foregroundColor(.red)
                } else if let product = viewModel.productInfo {
                    Text(product.productName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                    if(product.nutrientLevels.sugars == "" && product.nutrientLevels.saturatedFat == "" &&
                       product.nutrientLevels.fat == "" &&
                       product.nutrientLevels.salt == ""){
                        Text("No hay información nutricional del producto por el momento")
                        
                    }else{
                        VStack(alignment: .leading, spacing: 10) {
                            Text("INFORMACIÓN DEL PRODUCTO")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                InfoRow(title: "Valores Nutricionales", value: "").bold()
                                Divider()
                                InfoRow(title: "Azucares", value: translateNutrientLevel(product.nutrientLevels.sugars))
                                Divider()
                                InfoRow(title: "Grasas Saturadas", value: translateNutrientLevel(product.nutrientLevels.saturatedFat))
                                Divider()
                                InfoRow(title: "Grasas", value: translateNutrientLevel(product.nutrientLevels.fat))
                                Divider()
                                InfoRow(title: "Sodio", value: translateNutrientLevel(product.nutrientLevels.salt))
                                Divider()
                                InfoRow(title: "Cantidad de producto", value: product.productQuantity)
                            }
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(color: Color.secondary.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    
//                    Button(action: {
//                        // Action for viewing ingredients
//                    }) {
//                        HStack {
//                            Text("Ingredients")
//                            Spacer()
//                            Text("View All")
//                            Image(systemName: "chevron.right")
//                        }
//                        .padding()
//                        .background(Color.orange)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                    }
                    if(product.nutriScore.capitalized == "A"){
                        VStack {
                            Text("Nutri-Score")
                                .font(.headline)
                            Text("😁")
                                .font(.system(size: 60, weight: .bold))
//                            Text("points of 100")
//                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    if(product.nutriScore.capitalized == "B"){
                        VStack {
                            Text("Nutri-Score")
                                .font(.headline)
                            Text("😀")
                                .font(.system(size: 60, weight: .bold))
//                            Text("points of 100")
//                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    if(product.nutriScore.capitalized == "C"){
                        VStack {
                            Text("Nutri-Score")
                                .font(.headline)
                            Text("🙂")
                                .font(.system(size: 60, weight: .bold))
//                            Text("points of 100")
//                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    if(product.nutriScore.capitalized == "D"){
                        VStack {
                            Text("Nutri-Score")
                                .font(.headline)
                            Text("🤨")
                                .font(.system(size: 60, weight: .bold))
//                            Text("points of 100")
//                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    if(product.nutriScore.capitalized == "E"){
                        VStack {
                            Text("Nutri-Score")
                                .font(.headline)
                            Text("☹️")
                                .font(.system(size: 60, weight: .bold))
//                            Text("points of 100")
//                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                }
            }
            .padding()
        }
        .navigationBarTitle("Scanner", displayMode: .inline)
        .onAppear {
            viewModel.fetchProduct(code: productCode)
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

struct ProductInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductInfoView(productCode: "3159470000120")
        }
    }
}
