//
//  PageTitile.swift
//  Numerology
//
//  Created by Serj_M1Pro on 04.06.2025.
//

import SwiftUI

struct PageTitile: View {
    
    @State var title: String
    
    var body: some View {
        // Title
        Text(self.title)
            .font(DS.CinzelFont.title_h1!.asCTFont())
            .foregroundStyle(Color(DS.Horoscope.lightTextColor))
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    PageTitile(title: "Select an expert\nfor chat")
}
