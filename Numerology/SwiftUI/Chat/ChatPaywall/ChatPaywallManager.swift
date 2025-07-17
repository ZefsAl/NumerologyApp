//
//  ChatPaywallManager.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.06.2025.
//

import Foundation
import SwiftUI
import RevenueCat
import Alamofire

class ChatPaywallManager: ObservableObject {
 
    @Published var products: [StoreProduct] = []
    @Published var selected_product: String = IAP_IDs.stars25
    
    init() {
        self.getProducts()
    }
    
    private func getProducts() {
        Purchases.shared.getProducts([IAP_IDs.stars5,IAP_IDs.stars15,IAP_IDs.stars25]) { data in
            // v1
            self.products = data.sorted {
                let one = Int($0.productIdentifier.filter { val in val.isNumber })
                let two = Int($1.productIdentifier.filter { val in val.isNumber })
                if let one, let two { return one < two } else { return false }
            }
        }
    }
    
    func purchaseProduct(onCompletion: @escaping (String?) -> Void) {
        guard let product = (self.products.first { $0.productIdentifier == self.selected_product }) else { return }
        Purchases.shared.purchase(product: product) { transaction, customerInfo, error, userCancelled in
            guard !userCancelled else { onCompletion(nil); return }
            myPrint("✅ Purchase completed for product:",transaction?.productIdentifier)
            onCompletion(transaction?.productIdentifier)
            
            
            let eventName = product.productIdentifier
            let coins = ChatPaywallManager.getProductAmount(product)
            let price = NSDecimalNumber(decimal: product.price).doubleValue
            let currency = product.currencyCode ?? "?"
            // Log
            AnalyticsManager.shared.logConsumablePurchase_FIB(productID: product.productIdentifier)
            AnalyticsManager.shared.logConsumablePurchase_Facebook(productID: product.productIdentifier)
        }
    }
    
}


extension StoreProduct {
    func toCellItem() -> ChatPaywallItem {
        let productAmount = ChatPaywallManager.getProductAmount(self)
        return ChatPaywallItem(
            productID: self.productIdentifier,
            decorAmount: ChatPaywallManager.getDecorAmount(productAmount),
            productAmount: productAmount,
            discount: ChatPaywallManager.getDiscountText(productAmount),
            price: self.localizedPriceString
        )
    }
}

extension ChatPaywallManager {
    
    static func getProductAmount(_ product: StoreProduct) -> Int {
        return Int(product.productIdentifier.filter { val in val.isNumber }) ?? 0
    }
    
    static func getDecorAmount(_ productAmount: Int) -> Int {
        return switch productAmount {
        case 5: 2
        case 15: 3
        case 25: 4
        default: 0
        }
    }
    
    static func getDiscountText(_ productAmount: Int) -> String {
        return switch productAmount {
        case 5: "BEST OFF"
        case 15: "SAVE 12%"
        case 25: "SAVE 32%"
        default: ""
        }
    }
}
    
struct ChatPaywallItem: Identifiable {
    let id = UUID()
    let productID: String
    let decorAmount: Int
    let productAmount: Int
    let discount: String
    let price: String
}
