////
////  Accordion_Represent.swift
////  Numerology
////
////  Created by Serj_M1Pro on 08.11.2024.
////
//
import SwiftUI

struct RegularAccordion_SUI: View {

    // init
    @Binding var accordionTitle: String
    @Binding var mainInfo: String
    var minTextContainer: Double
    var vSpacing: Double
    
    // Желательно сделать чем больше контента тем меньше скорость анимации
    // MARK: - init
    init(
        accordionTitle: Binding<String>,
        mainInfo: Binding<String>,
        minTextContainer: Double = 40,
        vSpacing: Double = 10
    ) {
        _accordionTitle = accordionTitle
        _mainInfo = mainInfo
        self.minTextContainer = minTextContainer
        self.vSpacing = vSpacing
        
    }
    
    private let titleFont = DS.SourceSerifProFont.title_h3!
    private let subtitleFont = DS.SourceSerifProFont.subtitle!
    @State private var isDisclosed: Bool = false
    @State private var textSize: CGSize = .zero
    @State private var toggleIcon: Bool = false
    
    var body: some View  {
        
        VStack(spacing: self.vSpacing) {
            Button {
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
            VStack() {
                    Text(self.mainInfo)
                    .background(ViewGeometry())
                    .onPreferenceChange(ViewSizeKey.self) { self.textSize = $0 }
                    .multilineTextAlignment(.leading)
                    .font(Font((self.subtitleFont) as CTFont))
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .frame(
                height: isDisclosed ? self.textSize.height : self.minTextContainer, 
                alignment: .topLeading
            )
            .clipped()
        }
        
    }
}


struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    @State var accordionTitle: String = "Button"
    @State var mainInfo: String = "Symbol of the 13th Lunar Day - Snake biting its tailSymbol: ring; wheel; snake biting its tail Stones: Opal The 13th lunar day is like a continuation of the 12th lunar day. Do not give up on the things you start. There is enough energy to complete what you start. Today you could be compared to a wheel rolling down a mountain. Do not be frightened, do not slow down. Good luck is near. In terms of energy, on the thirteenth lunar day we refresh our energy reserve, renew our vitality. In general, you should treat this day with proper attention and seriousness. 13th lunar day, quite mystical and mysterious: a door between heaven and earth is opened, you can comprehend the unknown."
    
    return VStack {
        RegularAccordion_SUI(accordionTitle: $accordionTitle, mainInfo: $mainInfo, minTextContainer: 42)
            .background(Color.red)
    }
}
