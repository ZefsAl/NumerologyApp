//
//  StoreKitManager.swift
//  Numerology
//
//  Created by Serj on 16.08.2023.
//

import Foundation
import StoreKit

// MARK: Store Kit 1
class StoreKitManager: NSObject {
    
    static let shared = StoreKitManager()
    
    
    //    "Monthly_test_9.99_id"
    
    //    "Month_9.99",
    //    "Year_29.99"
    
    private let productIDs: Set<String> = [
        "Month_9.99",
        "Year_29.99"
    ]
    
    private var productRequest: SKProductsRequest?
    
    private var products: [String: SKProduct]?
    
    // MARK: Request
    private func requestProducts() {
        
        // MARK: 1
        productRequest?.cancel()
        let productRequest = SKProductsRequest(productIdentifiers: productIDs)
        productRequest.delegate = self
        productRequest.start()
        self.productRequest = productRequest
        
        SKPaymentQueue.default().add(self)
        
    }
    
    // MARK: initialize
    func initialize()  {
        requestProducts()
    }
    
    func purchaseProduct(productId: String) {
        
        // 2. Проверяем массив
        guard let product = products?[productId] else { return }
        
        // 3. Передаем в очередь
        
        if SKPaymentQueue.canMakePayments() {
            
            print("Sending the Payment Request to Apple")
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
        
    }
    
//    func finishTransaction(_ transaction: SKPaymentTransaction) -> Bool {
//        let productId = transaction.payment.productIdentifier
//        print("Product \(productId) successfully purchased")
//        return true
//    }
    
    public func restorePurchases() {
      SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}



// MARK: Delegate SKProductsRequest
extension StoreKitManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        guard !response.products.isEmpty else { print("Found 0 products"); return }
        
        var products = [String: SKProduct]()
        for skProduct in response.products {
            print("Found product: \(skProduct.productIdentifier)")
            products[skProduct.productIdentifier] = skProduct
        }
        self.products = products
        
        // Test
        //        for product in response.products {
        //            print("Found product: \(product.productIdentifier)")
        //            print(product.isFamilyShareable)
        //            print(product.localizedTitle)
        //            print(product.price.decimalValue)
        //        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load products with error:\n \(error)")
    }
}

// MARK: Delegate SKProductsRequest
extension StoreKitManager: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            case .purchased:
                complete(transaction: transaction)
                print("purchased")
                break
            case .failed:
                fail(transaction: transaction)
                print("failed")
                break
            case .restored:
//                restore(transaction: transaction)
                SKPaymentQueue.default().restoreCompletedTransactions()
                print("restored")
                break
            case .deferred:
                print("deferred")
                break
            case .purchasing:
                print("purchasing")
                break
            default:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        
        print("restore... \(productIdentifier)")
        deliverPurchaseNotificationFor(identifier: productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {

        if let transactionError = transaction.error as NSError?,
           let localizedDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(localizedDescription)")
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificationFor(identifier: String?) {
        guard let identifier = identifier else { return }
        
        //    purchasedProductIdentifiers.insert(identifier)
        //    UserDefaults.standard.set(true, forKey: identifier)
        //    NotificationCenter.default.post(name: .IAPHelperPurchaseNotification, object: identifier)
    }
}
