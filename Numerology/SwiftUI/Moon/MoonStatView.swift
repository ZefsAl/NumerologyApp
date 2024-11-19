//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 08.11.2024.
//

import SwiftUI

struct MoonStatView: View {
    
    
    var footnote: String
    var imageName: String? = nil
    var firstTitle: String? = nil
    var secondTitle: String? = nil
    var caption: String? = nil
    var alignment: HorizontalAlignment = .leading
    
    
    
    
    //
    private let footnoteFont = DesignSystem.SourceSerifProFont.footnote_Sb_13!
    private let titleFont = DesignSystem.SourceSerifProFont.title_h2!
    private let caption3Font = DesignSystem.SourceSerifProFont.caption3!
    
    var body: some View {
        VStack(alignment: self.alignment, spacing: 0) {
            Text(footnote)
                .font(Font((self.footnoteFont) as CTFont))
                .foregroundStyle(Color(uiColor: DesignSystem.MoonColors.grayText))
            //
            HStack(alignment: .center, spacing: 4) {
                if let imege = self.imageName {
                    Image(imege)
//                        .rotationEffect(.degrees(270))
                        .resizable(resizingMode: .stretch)
                        .frame(width: 30, height: 30, alignment: .leading)
                        .offset(x: -3, y: 0)
                    
                }
                if let firstTitle, firstTitle != "" {
                    Text(firstTitle)
                        .font(Font((self.titleFont) as CTFont))
                }
                if let secondTitle, secondTitle != "" {
                    arrowImage
                    Text(secondTitle)
                        .font(Font((self.titleFont) as CTFont))
                }
                
            }
            //
            
            if let caption {
                Text(caption)
                    .font(Font((self.caption3Font) as CTFont))
                    .foregroundStyle(Color(uiColor: DesignSystem.MoonColors.grayText))
            }
            
            
        }
    }
    
//    private var arrowImage: Text {
//        Text(secondTitle)
//            .font(Font((self.titleFont) as CTFont))
//    }
    
    private var arrowImage: some View {
        Image("Arrow")
            .frame(width: 19, height: 19, alignment: .center)
    }
}

#Preview {
    MoonStatView(
        footnote: "Rise:",
        imageName: "cancer",
        firstTitle: "14",
        secondTitle: "15",
        caption: "09 / 12"
    )
//    MoonStatView(
//        footnote: "Rise:",
//        imageTitle: "cancer",
//        caption: "Cancer"
//    )
}

