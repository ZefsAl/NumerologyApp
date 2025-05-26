//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.05.2025.
//

import SwiftUI

struct HoroscopeBG: View {
    
    var opacity: Double = 0.2
    
    var body: some View {
        
        
        GeometryReader { geo in
            Image("bgHoroscope2")
                .resizable(resizingMode: .stretch)
                .scaledToFill()
                .opacity(self.opacity)
                .zIndex(1)
            Color(.hexColor("202039")).zIndex(0)
                .frame(width: geo.size.width, height: geo.size.height)
        }
        .edgesIgnoringSafeArea(.all)
        

    }
}

#Preview {
    HoroscopeBG()
}
