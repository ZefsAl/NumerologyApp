//
//  ChatPaywall.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.06.2025.
//

import SwiftUI

struct ChatPaywallCell_v2: View {
    
    @Binding var selection: String
    let model: ChatPaywallItem
    var cellType: CellType = .compact
    
    //
    private var isSelected: Bool { self.selection == self.model.productID }
    
    enum CellType { case compact, standart  }
    
    
    var body: some View {
        ZStack {
            // MARK: - Small Device
            if cellType == .compact {
                VStack(spacing: 0) {
                    HStack(spacing: 4) {
                        // Decor
                        self.starDecorView()
                        // Amount
                        self.productAmountView()
                    }
                    HStack(spacing: 3) {
                        // Discount
                        self.discountView()
                        // Price
                        self.priceView()
                    }
                }
            } else {
                // MARK: - Regular Device
                HStack {
                    // 1 - Leading
                    HStack {
                        // Decor
                        self.starDecorView()
                        self.productAmountView()
                    }
                    Spacer()
                    // 2 - Trailing
                    VStack(alignment: .trailing, spacing: 3) {
                        // Discount
                        self.discountView()
                        // Price
                        self.priceView()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
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
    
    // MARK: - Product Amount
    @ViewBuilder func productAmountView() -> some View {
        Text("\(self.model.productAmount) Stars")
            .font(UIFont.setSourceSerifPro(weight: .semiBold, size: DeviceMenager.isSmallDevice ? 17 : 20)?.asCTFont())
    }
    
    // MARK: - Price
    @ViewBuilder func priceView() -> some View {
        Text("\(self.model.price)")
            .font(UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)?.asCTFont())
            .padding(.trailing, 2)
    }
    
    // MARK: - Discount
    @ViewBuilder func discountView() -> some View {
        Text("\(self.model.discount)")
            .font(UIFont.setSourceSerifPro(weight: .bold, size: DeviceMenager.isSmallDevice ? 11 : 13)?.asCTFont())
            .fixedSize()
            .padding(EdgeInsets(top: 1, leading: 8, bottom: 2, trailing: 8))
            .background(Color(DS.Chat.orange))
            .clipShape(.capsule)
    }
    
    // MARK: - Decor
    @ViewBuilder func starDecorView() -> some View {
        let frameRatio: CGFloat = DeviceMenager.isSmallDevice ? 20 : 24
        let spacing: CGFloat = DeviceMenager.isSmallDevice ? -16 : -19
        HStack(spacing: spacing) {
            ForEach((0..<self.model.decorAmount)) { _ in
                StarImage(imageName: "StarSecondary", frameRatio: frameRatio)
            }
            StarImage(imageName: "StarPrimary", frameRatio: frameRatio)
        }
    }
    
}

struct DynamicStack<Content: View>: View {
    
    var content: () -> Content
    
    var body: some View {
        if DeviceMenager.isSmallDevice {
            HStack { self.content() }
        } else {
            VStack { self.content() }
        }
    }
}


struct StarImage: View {
    
    var imageName: String
    var frameRatio: CGFloat
    
    var body: some View {
        Image(self.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: frameRatio, height: frameRatio)
    }
}

struct ChatPaywallCell_v2_TESTPREVIEW: View {
    @State var selection: String = "Test123"
    
    var body: some View {
        VStack {
            ChatPaywallCell_v2(
                selection: $selection,
                model: ChatPaywallItem(
                    productID: "Test123",
                    decorAmount: 2,
                    productAmount: 6,
                    discount: "BEST",
                    price: "2.99"
                )
            )
            ChatPaywallCell_v2(
                selection: $selection,
                model: ChatPaywallItem(
                    productID: "Test1234",
                    decorAmount: 3,
                    productAmount: 12,
                    discount: "BEST",
                    price: "5.99"
                )
            )
            ChatPaywallCell_v2(
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
    ChatPaywallCell_v2_TESTPREVIEW()
}

//self.discountBadge.font = UIFont.setSourceSerifPro(weight: .bold, size: DeviceMenager.isSmallDevice ? 11 : 13)
//self.mainTitle.font = UIFont.setSourceSerifPro(weight: .semiBold, size: DeviceMenager.isSmallDevice ? 17 : 20)
//self.priceTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)
//self.discountTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 13 : 15)
