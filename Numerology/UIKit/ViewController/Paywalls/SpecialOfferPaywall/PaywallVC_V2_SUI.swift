//
//  PaywallVC_V2_SUI.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.01.2025.
//

import SwiftUI

struct PaywallVC_V2_SUI: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> PaywallVC_V2 {
        return PaywallVC_V2(onboardingIsCompleted: true)
    }
    
    func updateUIViewController(_ uiViewController: PaywallVC_V2, context: Context) {}
}

// #Preview - Crash ???
