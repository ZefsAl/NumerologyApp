//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 03.11.2024.
//

import SwiftUI

struct MoonView: View {
    
    @StateObject var moonManager = MoonCalendarViewModel()
    
    // Moon animation
    @State private var tabSelection = 0
    @State private var imageCurrentX: CGFloat = -UIScreen.main.bounds.width
    @State private var currentScale: CGFloat = 0
    @State private var currentOpacity: CGFloat = 0
    private static let duration = 0.5
    private let moonAnimation: Animation = .smooth(duration: MoonView.duration)
    
    struct BiteCircle: Shape {
        func path(in rect: CGRect) -> Path {
            let offset = rect.maxX - 26
            let crect = CGRect(origin: .zero, size: CGSize(width: 26, height: 26)).offsetBy(dx: offset, dy: offset)
            
            var path = Rectangle().path(in: rect)
            path.addPath(Circle().path(in: crect))
            return path
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                // Calendar
                ZStack {
                    CalendarSmall_SUI(currentSelectedDate: self.$moonManager.currentCalendarDate)
                        .frame(height: 350)
                        .offset(x: 0, y: 100)
                }
                .frame(height: 140)
                .clipShape(Rectangle())
                .padding(.horizontal)
                .onChange(of: self.moonManager.currentCalendarDate) { value in
                    withAnimation(.snappy(duration: 0.3)) {
                        self.moonManager.setMoonPhaseData()
                    }
                    moonManager.calculateMoon()
                    self.calendarAction()
                }
                // Moon
                Image(self.moonManager.moonPhaseImage)
                    .resizable(resizingMode: .stretch)
                    .frame(width: 228, height: 228, alignment: .center)
                    .transition(.scale.combined(with: .opacity))
                    .opacity(currentOpacity)
                    .scaleEffect(self.currentScale)
                    .offset(x: self.imageCurrentX)
                self.card {
                    firstPage()
                    secondPage()
                }
            }
        }
        // Scroll View
        .background(
            Image("MoonBG_v3")
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea(.all)
        )
        .task {
            self.calendarAction()
        }
    }
    
    // MARK: - Action
    func calendarAction() {
        // animate when same moon image
        //  очень жесткий костыль для анимации !
        // + есть баг анимации при быстром переключении анимация срезается
        if self.moonManager.previousMoonPhaseImage == self.moonManager.moonPhaseImage {
            self.moonBounce()
        } else {
            self.moonMovement()
        }
        self.moonManager.previousMoonPhaseImage = self.moonManager.moonPhaseImage
    }
    
    // MARK: - Animation
    func moonBounce() {
        //  1. Decrease
        withAnimation(.bouncy(duration: MoonView.duration, extraBounce: 0.1)) {
            currentScale = 0.8
        }
        // 2.
        DispatchQueue.main.asyncAfter(deadline: .now() + MoonView.duration) {
            withAnimation(.bouncy(duration: MoonView.duration, extraBounce: 0.4)) {
                currentScale = 1
            }
        }
    }
    
    // MARK: - Animation
    // Есть баг анимации
    func moonMovement() {
        // appear
        if imageCurrentX == -UIScreen.main.bounds.width {
            withAnimation(self.moonAnimation) {
                currentOpacity = 1
                imageCurrentX = 0
                currentScale = 1
            }
        }
        
        // out
        else if imageCurrentX == 0 {
            // out
            withAnimation(self.moonAnimation) {
                currentOpacity = 0
                currentScale = 0.3
                imageCurrentX = UIScreen.main.bounds.width
            }
            // wait - first position
            DispatchQueue.main.asyncAfter(deadline: .now() + MoonView.duration) {
                currentScale = 0.3
                imageCurrentX = -UIScreen.main.bounds.width
            }
            // appear
            DispatchQueue.main.asyncAfter(deadline: .now() + MoonView.duration) {
                withAnimation(self.moonAnimation) {
                    imageCurrentX = 0
                    currentScale = 1
                    currentOpacity = 1
                }
            }
        }
    }
    
    // MARK: - Content Page 1
    @ViewBuilder func firstPage() -> some View {
        VStack(alignment: .center, spacing: 16) {
            HStack(alignment: .center) {
                // Age
                MoonStatView(
                    footnote: "Moon day:",
                    titles: self.moonManager.moonModels.compactMap { String($0.age) },
                    caption: self.moonManager.phase
                )
                Spacer()
                // Trajectory
                MoonStatView(
                    footnote: "Trajectory:",
                    imageName: self.moonManager.trajectoryImage,
                    caption: self.moonManager.trajectory,
                    alignment: .trailing
                )
            }
            // Sign
            HStack(alignment: .center) {
                MoonStatView(
                    footnote: "Sign:",
                    imageName: self.moonManager.moonSignImage,
                    caption: self.moonManager.moonSign
                )
                Spacer()
                // Moon Set / Rise
                MoonStatView(
                    footnote: "Rise:",
                    firstTitle: self.moonManager.moonRiseTime,
                    caption: self.moonManager.moonRise
                )
                arrowImage
                MoonStatView(
                    footnote: "Set - Rise:",
                    firstTitle: self.moonManager.moonSetTime,
                    caption: self.moonManager.moonSet
                )
                arrowImage
                MoonStatView(
                    footnote: "Set:",
                    firstTitle: self.moonManager.nextSetTime,
                    caption: self.moonManager.nextSet
                )
            }
            RegularAccordion_SUI(
                accordionTitle: self.$moonManager.firstAccordionTitle,
                mainInfo: self.$moonManager.firstInfo,
                minTextContainer: 40
            )
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .padding(.bottom,28)
    }
    
    // MARK: - Content Page 2
    @ViewBuilder
    func secondPage() -> some View {
        VStack(alignment: .center, spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(self.moonManager.chipsDataModels.enumerated()), id: \.offset) { offset, model in
                        ChipsButton(
                            title: model.title,
                            iconName: model.iconName,
                            tintColor: model.HEX,
                            selectedString: self.$moonManager.currentChips)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 1)
                .padding(.bottom, 8)
            }
            
            PremiumAccordion_SUI(
                accordionTitle: self.$moonManager.secondAccordionTitle,
                mainInfo: self.$moonManager.secondInfo,
                minTextContainer: 100
            )
            .padding(.horizontal, 20)
            .onChange(of: self.moonManager.currentChips) { newValue in
                if let model = self.moonManager.currentModel {
                    self.moonManager.switchChips(model: model)
                }
            }
        }
        .padding(.bottom,20)
    }
    
    // MARK: - Card
    @ViewBuilder
    func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack {
            content()
        }
        .background(
            RoundedRectangle(cornerRadius: DesignSystem.maxCornerRadius)
                .strokeBorder(Color.gray, lineWidth: DesignSystem.borderWidth)
                .background(Color(DesignSystem.MoonColors.darkTint).opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.maxCornerRadius))
        )
        .padding(18)
    }
    
    private var arrowImage: some View {
        Image("Arrow")
            .frame(width: 19, height: 19, alignment: .center)
    }
}

#Preview {
    MoonView()
}

