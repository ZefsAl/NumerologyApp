//
//  ACarousel_TEST.swift
//  Numerology
//
//  Created by Serj_M1Pro on 14.05.2025.
//

import SwiftUI
import ACarousel

// Заменено
// 1.  @ObservedObject viewModel на @StateObject т.к Binding каждый раз вызывает init что приводит к переотрисовке!
// 2. Ratio scaleEffect
// 3 . Возможность изменить анимацию
// 4. Анимация для карточки
    
struct ACarousel_TEST: View {
    @State var selection: Int = 1
    
    var body: some View {
        VStack {
            ACarousel(
                ExpertViewModel().expertsList,
                index: self.$selection,
                spacing: 0,
                headspace: 45,
                sidesScaling: 0.8,
                isWrap: false,
                autoScroll: .active(0),
                offsetAnimation: .smooth(duration: 0.3)
            ) { item in
                ExpertCard(
                    model: item,
                    frameSize: CGSize(width: 300, height: 440)
                )
            }
            .frame(height: 500)
            .onChange(of: self.selection) { newValue in
                print("⚠️selection🔴INDEX", newValue)
            }
        }
    }
}

#Preview {
    ACarousel_TEST()
}



