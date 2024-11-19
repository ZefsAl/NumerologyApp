//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 03.11.2024.
//

import SwiftUI

struct MoonView: View {
    
    @StateObject var moonManager = MoonCalendarManager()
    
//    @State var currentSelectedDate: Date? = nil
//    let calendarSmall = CalendarSmall_SUI(currentSelectedDate: $currentSelectedDate)
    
    @State var accordionTitle: String = "Trends"
    @State var mainInfo: String = "Symbol of the 13th Lunar Day - Snake biting its tailSymbol: ring; wheel; snake biting its tail Stones: Opal The 13th lunar day is like a continuation of the 12th lunar day. Do not give up on the things you start. There is enough energy to complete what you start. Today you could be compared to a wheel rolling down a mountain. Do not be frightened, do not slow down. Good luck is near. In terms of energy, on the thirteenth lunar day we refresh our energy reserve, renew our vitality. In general, you should treat this day with proper attention and seriousness. 13th lunar day, quite mystical and mysterious: a door between heaven and earth is opened, you can comprehend the unknown."
    
    
    @State private var tabSelection = 0
    
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 24) {
                // calendar
                ZStack() {
                    GeometryReader { proxy in
                        CalendarSmall_SUI(currentSelectedDate: self.$moonManager.currentSelectedDate)
                            .frame(height: 350)
                            .offset(x: 0, y: 0)
                    }
                    .frame(height: 140)
                }
                .padding(.horizontal)
                .onChange(of: self.moonManager.currentSelectedDate) { value in
                    withAnimation(.snappy(duration: 0.3)) {
                        self.moonManager.getMinModel()
                    }
                    moonManager.calculateMoon()
                }
                
                
                // Moon
                Image(self.moonManager.moonPhaseImage)
                    .resizable(resizingMode: .stretch)
                    .frame(width: 228, height: 228, alignment: .center)
                //
                
                self.card {
                    
                    firstPage()
                    
                    
                    
                }
                
//                ChipsButton
                
            }
            
            
            
            
        }
        .background(
            Image("MoonBG_v3")
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea(.all)
        )
        .task {
            self.moonManager.getMinModel()
        }
    }
    
    
    @ViewBuilder func firstPage() -> some View {
        VStack(alignment: .center, spacing: 16) {
            HStack(alignment: .center) {
                // Age
                MoonStatView(
                    footnote: "Moon day:",
                    firstTitle: self.moonManager.previousAge,
                    secondTitle: self.moonManager.moonAge,
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
            HStack(alignment: .center) {
                MoonStatView(
                    footnote: "Sign:",
                    imageName: self.moonManager.moonSignImage,
                    caption: self.moonManager.moonSign
                )
                Spacer()
                MoonStatView(
                    footnote: "Rise:",
                    firstTitle: self.moonManager.previousRiseTime,
                    caption: self.moonManager.previousRise
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
                    firstTitle: self.moonManager.moonRiseTime,
                    caption: self.moonManager.moonRise
                )
            }
            Accordion_SUI(
                accordionTitle: self.$accordionTitle,
                mainInfo: self.$mainInfo,
                minTextContainer: 40
            )
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .padding(.bottom,28)
        
    }
        
        
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

