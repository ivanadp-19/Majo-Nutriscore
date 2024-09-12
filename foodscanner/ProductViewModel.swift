//
//  ProductViewModel.swift
//  foodscanner
//
//  Created by felipe ivan on 10/09/24.
//

import Foundation
import SwiftUI
import Combine
// MARK: - Model
struct ProductResponse: Codable {
    let productName: String
    let nutrientLevels: NutrientLevels
    let productQuantity: String
    let ingredients: String
    let nutriScore: String

    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case nutrientLevels = "nutrient_levels"
        case productQuantity = "product_quantity"
        case ingredients
        case nutriScore = "nutri_score"
    }
}

struct NutrientLevels: Codable {
    let sugars, saturatedFat, fat, salt: String

    enum CodingKeys: String, CodingKey {
        case sugars
        case saturatedFat = "saturated-fat"
        case fat, salt
    }
}

// MARK: - ViewModel
class ProductViewModel: ObservableObject {
    @Published var productInfo: ProductResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProduct(code: String) {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://hola-production.up.railway.app/?param=\(code)") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] product in
                self?.productInfo = product
            }
            .store(in: &cancellables)
    }
}
