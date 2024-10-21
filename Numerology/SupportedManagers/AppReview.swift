//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.10.2024.
//

import StoreKit

class AppReview {
    // MARK: - request Review
    static func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
