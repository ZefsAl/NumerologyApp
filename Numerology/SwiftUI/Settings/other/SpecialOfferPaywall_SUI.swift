//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.10.2024.
//

import SwiftUI

struct SpecialOfferPaywall_SUI: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SpecialOfferPaywall {
        let vc = SpecialOfferPaywall(type: .standart, isNavBarHidden: false)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SpecialOfferPaywall, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

