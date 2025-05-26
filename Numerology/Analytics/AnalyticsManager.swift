//
//  TrackingEvents.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.04.2025.
//

import Foundation
import RevenueCat
import FirebaseAnalytics
import AppTrackingTransparency
import AdSupport
import FBSDKCoreKit


final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    
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
    
//    func trackPurchase_FB(price: Double, currency: String) {
//        AppEvents.shared.logPurchase(amount: price, currency: currency)
//    }
    
    func requestATTForFacebook() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("✅ ATT Authorized")
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
                        print("IDFA: \(idfa)")
                        
                    case .denied:
                        print("❌ ATT Denied")
                        
                    case .notDetermined:
                        print("⏳ ATT Not Determined")
                        self.requestATTForFacebook()
                    case .restricted:
                        print("⚠️ ATT Restricted")
                    @unknown default:
                        print("🌀 ATT Unknown status")
                    }
                }
            }
        }
    }
}
