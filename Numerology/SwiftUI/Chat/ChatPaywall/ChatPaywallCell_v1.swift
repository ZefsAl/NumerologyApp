//
//  ChatPaywall.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.06.2025.
//

import SwiftUI

struct ChatPaywallCell_v1: View {
    
    @Binding var selection: String
    let model: ChatPaywallItem
    
    //
    private var isSelected: Bool { self.selection == self.model.productID }
    
    enum DecorAmount { case two, three, four }
    
    
    var body: some View {
            HStack {
                // 1
                HStack {
                    self.starRatingView()
                    Text("\(self.model.productAmount) Stars")
                        .font(UIFont.setSourceSerifPro(weight: .semiBold, size: DeviceMenager.isSmallDevice ? 17 : 20)?.asCTFont())
                }
                Spacer()
                // 2 - Trailing
                VStack(alignment: .trailing, spacing: 3) {
                    // Discount
                    Text("\(self.model.discount)")
                        .font(UIFont.setSourceSerifPro(weight: .bold, size: DeviceMenager.isSmallDevice ? 11 : 13)?.asCTFont())
                        .padding(EdgeInsets(top: 1, leading: 8, bottom: 2, trailing: 8))
                        .background(Color(DS.Chat.orange))
                        .clipShape(.capsule)
                    // Price
                    Text("\(self.model.price)")
                        .font(UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)?.asCTFont())
                        .padding(.trailing, 2)
                }
            }
            .foregroundStyle(.white)
            .padding(.vertical, 8).padding(.horizontal)
            .background(
                ZStack {
                    let rect = RoundedRectangle(cornerRadius: DS.midCornerRadius_20)
                    rect.fill(Color(self.isSelected ? DS.Chat.answer : DS.Chat.bg))
                    rect.stroke(
                        Color(self.isSelected ? DS.Chat.primary : .hexColor("434279")),
                        lineWidth: 2
                    )
                }
            )
            .overlay {
                if !self.isSelected {
                    RoundedRectangle(cornerRadius: DS.maxCornerRadius)
                        .fill(Color(DS.Chat.answer).opacity(0.5))
                }
            }
            .onTapGesture {
                withAnimation(.smooth(duration: 0.3)) {
                    self.selection = self.model.productID
                }
            }
    }
    
    
    @ViewBuilder func starRatingView() -> some View {
        HStack(spacing: -19) {
            ForEach((0..<self.model.decorAmount)) { _ in
                Image("StarSecondary")
            }
            Image("StarPrimary")
        }
    }
}


struct ChatPaywallCell_v1_TESTPREVIEW: View {
    @State var selection: String = "Test123"
    
    var body: some View {
        VStack {
            ChatPaywallCell_v1(
                selection: $selection,
                model: ChatPaywallItem(
                    productID: "Test123",
                    decorAmount: 2,
                    productAmount: 6,
                    discount: "BEST",
                    price: "2.99"
                )
            )
            ChatPaywallCell_v1(
                selection: $selection,
                model: ChatPaywallItem(
                    productID: "Test1234",
                    decorAmount: 3,
                    productAmount: 12,
                    discount: "BEST",
                    price: "5.99"
                )
            )
            ChatPaywallCell_v1(
                selection: $selection,
                model: ChatPaywallItem(
                    productID: "Test12345",
                    decorAmount: 4,
                    productAmount: 22,
                    discount: "BEST",
                    price: "12.99"
                )
            )
        }
        .padding()
    }
}

#Preview {
    ChatPaywallCell_v1_TESTPREVIEW()
}

//self.discountBadge.font = UIFont.setSourceSerifPro(weight: .bold, size: DeviceMenager.isSmallDevice ? 11 : 13)
//self.mainTitle.font = UIFont.setSourceSerifPro(weight: .semiBold, size: DeviceMenager.isSmallDevice ? 17 : 20)
//self.priceTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)
//self.discountTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 13 : 15)
