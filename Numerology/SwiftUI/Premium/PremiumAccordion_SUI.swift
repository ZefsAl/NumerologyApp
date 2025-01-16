//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.01.2025.
//

import SwiftUI


class PremiumAccordion_SUI_VM: ObservableObject {
    
    @Published var accordionTitle: String = ""
    
    @ObservedObject var sharedData = PremiumTextManager()
    let premiumBadgeManager = PremiumManager()
    
    init() {
        self.premiumBadgeManager.setPremiumBadgeObserver(observer: self, action: #selector(self.notificationAllowPremiumContent(notification:)))
        self.sharedData.isPremium = !PremiumManager.isUserPremium()
    }
    
    @objc private func notificationAllowPremiumContent(notification: Notification) {
        guard let premiumState = notification.object as? Bool else { return }
        self.sharedData.isPremium = !premiumState
    }
 
}


struct PremiumAccordion_SUI: View {
    
    @StateObject private var vm = PremiumAccordion_SUI_VM()

    // init
    @Binding var accordionTitle: String
    @Binding var mainInfo: String
    
    var minTextContainer: Double = 40
    var vSpacing: Double = 10
    
    // Private
    @State private var showPaywall: Bool = false
    
    private let titleFont = DesignSystem.SourceSerifProFont.title_h3!
    private let subtitleFont = DesignSystem.SourceSerifProFont.subtitle!
    @State private var isDisclosed: Bool = false
    @State private var textSize: CGSize = .zero
    @State private var toggleIcon: Bool = false
    
    var body: some View  {
        
        VStack(spacing: self.vSpacing) {
            Button {
                guard !self.vm.sharedData.isPremium else {
                    print("❌ Show Paywall")
                    self.showPaywall = true
                    return
                }
                print("✅ Show Content")
                withoutTransaction {
                    self.toggleIcon.toggle()
                }
                withAnimation(.spring) {
                    self.isDisclosed.toggle()
                }
            } label: {
                Text(self.accordionTitle)
                    .font(Font((self.titleFont) as CTFont))
                    .lineLimit(1)
                Spacer()
                Image(systemName: self.toggleIcon ? "chevron.up.circle" : "chevron.down.circle")
                    .font(.system(size: 19, weight: .regular))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24, alignment: .top)
            }
            .foregroundStyle(.white)
            // Content
            PremiumTextView_SUI(sharedText: self.vm.sharedData)
                .frame(
                    height: self.isDisclosed ? .none : 100,
                    alignment: .top
                )
        }
        .fullScreenCover(isPresented: self.$showPaywall) {
            // Preview crash ???
            PaywallVC_V2_SUI().ignoresSafeArea()
        }
        .onAppear {
            self.vm.sharedData.data = self.mainInfo
        }
        .onChange(of: self.mainInfo) { newValue in
            self.vm.sharedData.data = newValue
        }
        
    }
}




struct PremiumAccordion_SUI_TESTPREVIEW: View {
    
    @State var accordionTitle: String = "Button"
    @State var mainInfo: String = "Symbol of the 13th Lunar Day - Snake biting its tailSymbol: ring; wheel; snake biting its tail Stones: Opal The 13th lunar day is like a continuation of the 12th lunar day. Do not give up on the things you start. There is enough energy to complete what you start. Today you could be compared to a wheel rolling down a mountain. Do not be frightened, do not slow down. Good luck is near. In terms of energy, on the thirteenth lunar day we refresh our energy reserve, renew our vitality. In general, you should treat this day with proper attention and seriousness. 13th lunar day, quite mystical and mysterious: a door between heaven and earth is opened, you can comprehend the unknown."
    
    var body: some View {
        VStack {
            PremiumAccordion_SUI(
                accordionTitle: $accordionTitle,
                mainInfo: $mainInfo,
                minTextContainer: 40,
                vSpacing: 12
            )
            .background(Color(DesignSystem.Numerology.shadowColor))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.mainInfo = "Почему нет хорошей альтернативы этому или аметисту, которая была бы предельно простой? Что-то вроде iPadOS, когда включен менеджер сцены. Это все, что мне нужно на моем Mac. Менеджеры окон — это либо те, которые делают то же самое дерьмо, как прямоугольник и магнит, либо слишком сложные, как Yabai."
            }
        }
    }
}

#Preview {
    PremiumAccordion_SUI_TESTPREVIEW()
}



