//
//  SelectExpertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.05.2025.
//

import SwiftUI
import ACarousel
//import BigUIPaging

struct SelectExpertView: View {
    @StateObject var vm = ExpertViewModel()
    @State var selection: Int = 1
    @State var isPresented: Bool = false
    
    
    var body: some View {
        ScrollView(.vertical) {
                VStack(spacing: 0) {
                    // Title
                    Text("Select an expert\nfor chat")
                        .font(DS.CinzelFont.title_h1!.asCTFont())
                        .foregroundStyle(Color(DS.Horoscope.lightTextColor))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    
                    // Experts
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
                    .frame(height: 500,alignment: .top)
                    //            .background(Color.red)
                    .overlay {
                        ZStack(alignment: .bottom) {
//                            PageIndicator(selection: self.$selection, total: ExpertViewModel().expertsList.count)
//                                .pageIndicatorColor(Color(.gray))
//                                .pageIndicatorCurrentColor(Color(DS.Horoscope.lightTextColor))
//                                .allowsContinuousInteraction(true)
//                                .pageIndicatorBackgroundStyle(.minimal)
//                                .preferredColorScheme(.dark)
//                                .allowsTightening(false) // хз не работает
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .offset(y: 6)
                        
                    }
                    .onChange(of: self.selection) { newValue in
                        print("⚠️selection🔴INDEX", newValue)
                    }
                    
                    
                    VStack(spacing: 6) {
                        // Header
                        self.starsHeader()
                        // Button CTA
                        Button {
//                            withoutTransaction {
                                self.isPresented = true
//                            }
                            
                        } label: {
                            HStack(spacing: 6) {
                                Text("Ask Lisa Now")
                                    .foregroundStyle(.white)
                                    .font(DS.SourceSerifProFont.title_h2!.asCTFont())
                                Image("SendArrow")
                            }
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                            .background(Color(DS.PaywallTint.primaryPaywall))
                            .cornerRadius(DS.maxCornerRadius)
                            .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background{ HoroscopeBG() }
            .fullScreenCover(isPresented: self.$isPresented) {
//                ZStack {
//                    Color.clear
//                    if isPresented {
                ChatView(
                    expertModel: ExpertViewModel().expertsList[0],
                    closeAction: { self.isPresented = false }
                )
//                        .transition(.scale.animation(.easeInOut))
//                        .onAppear { isPresented = true }
//                        .onDisappear { isPresented = false }
//                    }
//                        .transaction { transaction in
//                            transaction.disablesAnimations = true
//                        }
//                }
//                .transition(.scale.animation(.easeInOut))
//                .background {
//                    BackgroundClearView_v2()
//                }
            }
//            .transaction { transaction in
//                transaction.disablesAnimations = true
//            }
    }
    
    @ViewBuilder func h_Content(proxy: GeometryProxy) -> some View {
        let spacing = (proxy.size.width - 300)/2
        HStack(spacing: spacing) {
            ForEach(Array(ExpertViewModel().expertsList.enumerated()), id: \.offset) { id in
                ExpertCard(
                    model: id.element,
                    frameSize: CGSize(width: 300, height: 440)
                )
                .scaleEffect(self.selection == id.offset ? 0.8 : 1, anchor: .center)
            }
        }
    }
    
    // MARK: - stars Header
    @ViewBuilder func starsHeader() -> some View {
        HStack {
            Text("Your Stars:")
                .font(DS.SourceSerifProFont.title_h3!.asCTFont())
                .foregroundStyle(Color(DS.Horoscope.lightTextColor))
            Spacer()
            StarsAmountVeiw(sizetype: .large, stars: .constant(10))
        }
        .padding(.horizontal)
    }
}

#Preview {
    SelectExpertView()
}

struct Some_TESTPREVIEW123: View {
    var body: some View {
        Text("Hello, World!")
    }
}
