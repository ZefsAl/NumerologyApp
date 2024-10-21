//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 06.09.2024.
//

import SwiftUI
// MARK: - PremiumTextView_SUI
struct PremiumTextView_SUI: View {
    
    @ObservedObject var sharedText: PremiumTextManager
    
    private let viewMargin = EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
    private let cardMargin = EdgeInsets(top: 16,leading: 16,bottom: 16,trailing: 16)
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
                .background(BackgroundClearView())
            Text(sharedText.getPremiumText(.premium) ?? "Error")
                .font(Font((textFont) as CTFont))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .blur(radius: sharedText.isPremium ? 3 : 0) // 5
                .background(BackgroundClearView())
        }
    }
}




struct PremiumTextView_SUI_Previews: PreviewProvider {
    static var previews: some View {
        PremiumTextView_SUI(sharedText: PremiumTextManager())
            .previewLayout(.sizeThatFits)
    }
}

