//
//  TrackingEvents.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.04.2025.
//

import Foundation
import RevenueCat
//
import FirebaseAnalytics
import AppTrackingTransparency
import AdSupport
//
import FBSDKCoreKit



final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    func requestATTForFacebook() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        myPrint("✅ ATT Authorized")
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
                        myPrint("IDFA: \(idfa)")
                    case .denied: myPrint("❌ ATT Denied")
                    case .notDetermined:
                        myPrint("⏳ ATT Not Determined")
                        self.requestATTForFacebook()
                    case .restricted: myPrint("⚠️ ATT Restricted")
                    @unknown default: myPrint("🌀 ATT Unknown status")
                    }
                }
            }
        }
    }
    
    
//    func analyticsStars(_ productID: String?) {
//        guard let productID else { return }
//        switch productID {
//        case IAP_IDs.stars5:
//        case IAP_IDs.stars15:
////            self.userRef?.setData(["totalTokens": FieldValue.increment(Int64(15))], merge: true)
//        case IAP_IDs.stars25:
////            self.userRef?.setData(["totalTokens": FieldValue.increment(Int64(25))], merge: true)
//        default: break
//        }
//    }
    
    
}

// MARK: - Firebase analytics
extension AnalyticsManager {
    
    func trackPurchase_FIB(product: StoreProduct, transaction: StoreTransaction?, customerInfo: CustomerInfo?, error: PublicError?, userCancelled: Bool) {
        guard
            let _ = transaction,
            let _ = customerInfo,
                error == nil,
            !userCancelled
        else { return }

        Analytics.logEvent(AnalyticsEventPurchase, parameters: [
            AnalyticsParameterItemID: product.productIdentifier,
            AnalyticsParameterValue: product.price,
            AnalyticsParameterCurrency: product.currencyCode ?? "N/A",
        ])
    }
    
//    func logPurchase(eventName: String, coins: Int, price: Double, currency: String) {
//        // не видит
////        Analytics.logEvent(eventName, parameters: [
////            "coins_amount": coins,
////            "price": price,
////            "currency": currency
////        ])
//    }
    
    func logConsumablePurchase_FIB(productID: String) {
        switch productID {
        case IAP_IDs.stars5:
            Analytics.logEvent("Purchase_5_Stars", parameters: [ "coins_amount": 5 ])
        case IAP_IDs.stars15:
            Analytics.logEvent("Purchase_15_Stars", parameters: [ "coins_amount": 15 ])
        case IAP_IDs.stars25:
            Analytics.logEvent("Purchase_25_Stars", parameters: [ "coins_amount": 25 ])
        default: break
        }
    }
    
    func userAskAstrologer_FIB() {
        Analytics.logEvent("user_ask_astrologer", parameters: [:])
    }
    
    
//    func testEVENTs() {
//        print("testEVENTs")
//        Analytics.logEvent("MY_TEST_EVENT", parameters: [ "coins_amount": 1 ])
//        AppEvents.shared.logEvent(.init("MY_TEST_EVENT"), parameters: [ .init("coins_amount") : 0 ])
//        
//        
//        // V2
//        Analytics.logEvent("my_test_event", parameters: [
//           "coins_amount": 1 as NSNumber
//         ])
//        AppEvents.shared.logEvent(
//            AppEvents.Name("my_test_event_2"),
//            parameters: [
//                AppEvents.ParameterName("coins_amount"): 1
//            ]
//        )
//    }
    
}

// MARK: - Facebook analytics
extension AnalyticsManager {
    //    func trackPurchase_FB(price: Double, currency: String) {
    //        AppEvents.shared.logPurchase(amount: price, currency: currency)
    //    }
    
//    func logFacebookPurchase(eventName: String, coins: Int, price: Double, currency: String) {
////        AppEvents.shared.logPurchase(
////            amount: price,
////            currency: currency,
////            parameters: [.init("coins_amount") : "\(coins)"]
////        )
//        
//        AppEvents.shared.logEvent(.init(eventName), parameters: [
//            .init("coins_amount") : coins,
//            .init("price") : price,
//            .init("currency") : currency
//        ])
//    }
    func userAskAstrologer_Facebook() {
        AppEvents.shared.logEvent(AppEvents.Name("user_ask_astrologer"))
    }
    
    func logConsumablePurchase_Facebook(productID: String) {
        switch productID {
        case IAP_IDs.stars5:
            AppEvents.shared.logEvent(AppEvents.Name("Purchase_5_Stars"))
        case IAP_IDs.stars15:
            AppEvents.shared.logEvent(AppEvents.Name("Purchase_15_Stars"))
        case IAP_IDs.stars25:
            AppEvents.shared.logEvent(AppEvents.Name("Purchase_25_Stars"))
        default: break
        }
    }
    
}
