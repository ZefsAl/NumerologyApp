//
//  StarsAmountVeiw.swift
//  Numerology
//
//  Created by Serj_M1Pro on 14.05.2025.
//

import SwiftUI

struct StarsAmountVeiw: View {
    enum Sizetype { case large, mini }
    
    let sizetype: Sizetype
    @Binding var stars: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Image("DesignedStar")
                .resizable(resizingMode: .stretch)
                .frame(maxWidth: self.ratioFrame(), maxHeight: self.ratioFrame(), alignment: .center)
            Text("\(self.stars)")
                .font(self.starFont())
                .frame(maxWidth: self.ratioFrame(), maxHeight: self.ratioFrame(), alignment: .center)
                .foregroundStyle(Color(DS.Horoscope.lightTextColor))
        }
    }
    
    private func ratioFrame() -> CGFloat {
        switch self.sizetype {
        case .large: 22
        case .mini: 14
        }
    }
    
    private func starFont() -> Font {
        switch self.sizetype {
        case .large: DS.SourceSerifProFont.stars_large!.asCTFont()
        case .mini: DS.SourceSerifProFont.stars_mini!.asCTFont()
        }
    }
}

#Preview {
    VStack {
        StarsAmountVeiw(sizetype: .mini, stars: .constant(10))
        StarsAmountVeiw(sizetype: .large, stars: .constant(10))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    .background(.black)
}
