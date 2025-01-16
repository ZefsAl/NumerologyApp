//
//  SpecialOfferPaywall_SUI.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.01.2025.
//

import SwiftUI

struct SpecialOfferPaywall_SUI: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SpecialOfferPaywall {
        let vc = SpecialOfferPaywall(type: .standart, isNavBarHidden: false)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SpecialOfferPaywall, context: Context) {}
}

#Preview {
    SpecialOfferPaywall_SUI()
}
