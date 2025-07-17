//
//  SelectExpertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.05.2025.
//

import SwiftUI
import Lottie

struct LottieBackgroundView: View {
    
    var body: some View {
        VStack {
            LottieView(animation: .named("ChatPaywall"))
                .configure(\.contentMode, to: .scaleAspectFill)
                .looping()
                .scaleEffect(self.getScaleFactor())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea(.all)
        .background(Color.orange)
        .onAppear {
            myPrint(DeviceMenager.device)
            myPrint(UIScreen.main.nativeBounds.height)
        }
    }
     
    private func getScaleFactor() -> CGFloat {
        switch DeviceMenager.device {
        case .iPhone_Se2_3Gen_8_7_6S: 1.1
        case .iPhone8Plus_7Plus_6Plus: 1.1
        case .iPhone_Mini_12_13: 1.1
        case .iPhone_X_XS_11Pro: 1.1
        case .iPhone_XR_11: 1.1
        case .iPhone_12_13_14: 1.1
        case .iPhone_XSMax_11ProMax: 1.1
        case .iPhone_12ProMax_13ProMax: 1.1
        case .iPhone_15_15Pro_16: 1.1
        case .iPhone_16Pro: 1.12
        case .iPhone_16ProMax: 1.23
        case .iPhone_15Plus_15ProMax_16Plus: 1.2
        case .iPads_12_9: 1
        case .iPads_11_10_9: 1
        case .iPads10_5: 1
        case .iPads9_7_mini7_9: 1
        case .unknown: 1.1
        }
    }
    
}

#Preview {
    LottieBackgroundView()
}


































