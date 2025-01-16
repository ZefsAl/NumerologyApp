//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 06.09.2024.
//

import SwiftUI

struct PremiumTextView_SUI: View {
    
    @ObservedObject var sharedText: PremiumTextManager
    
    // Style
    let primaryColor = DesignSystem.Horoscope.primaryColor
    let bgColor = DesignSystem.Horoscope.backgroundColor
    let textFont = DesignSystem.SourceSerifProFont.subtitle!
    
    // MARK: - body
    var body: some View {
        VStack(spacing: 8) {
            Text(sharedText.getPremiumText(.free) ?? "Error")
                .font(Font((textFont) as CTFont))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(BackgroundClearView_v1())
            Text(sharedText.getPremiumText(.premium) ?? "Error")
                .font(Font((textFont) as CTFont))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .blur(radius: sharedText.isPremium ? 3 : 0) // 5
                .background(BackgroundClearView_v1())
        }
    }
}


struct PremiumTextView_SUI_TestPreviews: View {
    
    let textManager: PremiumTextManager = PremiumTextManager()
    
    var body: some View {
        PremiumTextView_SUI(sharedText: self.textManager)
            .previewLayout(.sizeThatFits)
            .onAppear {
                self.textManager.isPremium = true
                self.textManager.data = "Symbol of the 13th Lunar Day - Snake biting its tailSymbol: ring; wheel; snake biting its tail Stones: Opal The 13th lunar day is like a continuation of the 12th lunar day. Do not give up on the things you start. There is enough energy to complete what you start. Today you could be compared to a wheel rolling down a mountain. Do not be frightened, do not slow down. Good luck is near. In terms of energy, on the thirteenth lunar day we refresh our energy reserve, renew our vitality. In general, you should treat this day with proper attention and seriousness. 13th lunar day, quite mystical and mysterious: a door between heaven and earth is opened, you can comprehend the unknown."
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.black)
    }
}

#Preview {
    PremiumTextView_SUI_TestPreviews()
}
