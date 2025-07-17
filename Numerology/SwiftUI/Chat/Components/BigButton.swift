//
//  BigButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 04.06.2025.
//

import SwiftUI

struct BigButton<TrailingContent: View>: View {
    
    @State var title: String
    //
    var style: Style
    var color: Color
    
    var spacing: CGFloat
    var minHeight: CGFloat
    var cornerRadius: CGFloat
    //
    @Binding var isLoad: Bool
    var action: () -> Void
    var trailingContent: TrailingContent?
    
    enum Style { case bordered, filled }
    
    init(
        title: String,
        style: Style = .filled,
        spacing: CGFloat = 6,
        minHeight: CGFloat = 60,
        cornerRadius: CGFloat = DS.maxCornerRadius,
        isLoad: Binding<Bool> = .constant(false),
        action: @escaping () -> Void,
        @ViewBuilder trailingContent: () -> TrailingContent? = { EmptyView() }
    ) {
        self.title = title
        self.style = style
        self.spacing = spacing
        self.minHeight = minHeight
        self.cornerRadius = cornerRadius
        //
        self._isLoad = isLoad
        self.action = action
        self.trailingContent = trailingContent()
        
        
        // Color
        self.color = switch self.style {
        case .bordered:
            Color(DS.Chat.darkBG)
        case .filled:
            Color(DS.Chat.primary)
        }
    }
    
    var body: some View {
        Button {
            self.action()
        } label: {
            HStack(spacing: self.spacing) {
                Text(self.title)
                    .foregroundStyle(.white)
                    .font(DS.SourceSerifProFont.title_h2!.asCTFont())
                self.trailingContent
                if self.isLoad {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                }
            }
            .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .center)
            .background(
                ZStack {
                    let rect = RoundedRectangle(cornerRadius: self.cornerRadius)
                    rect.fill(self.color)
                    rect.stroke(Color(DS.Chat.primary), lineWidth: 1)
                }
            )
            .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
            .allowsHitTesting(self.isLoad)
        }
    }
}

#Preview {
    VStack {
        BigButton(title: "Ask Lisa Now", action: {}, trailingContent: {
            Image("SendArrow")
        })
        BigButton(title: "Ask Lisa Now", isLoad: .constant(true), action: {}, trailingContent: {
            Image("SendArrow")
        })
        BigButton(
            title: "Store",
            style: .bordered,
            isLoad: .constant(true),
            action: {},
            trailingContent: {
                Image("StarPrimary")
                    .renderingMode(.template)
                    .foregroundStyle(.white)
            }
        )
    }
    .padding(.horizontal)
}
// Image("SendArrow")

//Button {
//    self.isPresented = true
//} label: {
//    HStack(spacing: 6) {
//        Text("Ask Lisa Now")
//            .foregroundStyle(.white)
//            .font(DS.SourceSerifProFont.title_h2!.asCTFont())
//        Image("SendArrow")
//    }
//    .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
//    .background(Color(DS.PaywallTint.primaryPaywall))
//    .cornerRadius(DS.maxCornerRadius)
//    .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
//}
