//
//  StoreKit2Manager.swift
//  Numerology
//
//  Created by Serj on 18.08.2023.
//

import Foundation
import StoreKit



// MARK: Store Kit 2
@available(iOS 15.0, *)
class StoreKit2Manager {
    
    static let shared = StoreKit2Manager()
    
    private let productIDs: Set<String> = [
        "Month_9.99",
        "Year_29.99"
    ]
    
    func requestProducts(completion: @escaping ([Product]) -> Void) async {
        
        do {
            let arrProducts = try await Product.products(for: productIDs)
            completion(arrProducts)
        } catch {
            print("Error requestProducts")
        }
    }
    
    
}
