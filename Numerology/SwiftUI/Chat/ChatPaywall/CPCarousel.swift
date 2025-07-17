//
//  CPCarousel.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.06.2025.
//

import SwiftUI
import ACarousel

struct CPCarousel: View {
    
    @State var selection: Int = 0
    
    var body: some View {
        ACarousel(
            userReview_dataSource,
            index: self.$selection,
            spacing: 0,
            headspace: 45,
            sidesScaling: 0.8,
            isWrap: true,
            autoScroll: .active(12),
            offsetAnimation: .smooth(duration: 0.3)
        ) { item in
            UserReviewView(model: item)
        }
        .frame(height: 135,alignment: .top)
        .background(.red)
    }
}

#Preview {
    CPCarousel()
}
