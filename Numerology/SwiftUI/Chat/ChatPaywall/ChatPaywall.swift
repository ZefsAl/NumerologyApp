//
//  ChatPaywall.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.06.2025.
//

import SwiftUI
import ACarousel

struct ChatPaywall: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) private var dismiss
    @StateObject var cpm: ChatPaywallManager
    @StateObject var sm: StarsManager
    //
    @State private var presentURL: URL?
    @State private var current_userReview: Int = 1
    @State private var isPurchasing: Bool = false
    
    var body: some View {
        ZStack {
            
            VStack {
                // Header
                HStack(alignment: .top, spacing: 0) {
                    LabelView(text: "Buy stars\nto ask\nquestions\nto a specialist.")
                        .fixedSize()
                    Spacer()
                    // Close
                    self.closeButton()
                }
                .padding(.horizontal)
                Spacer()
                
                // Carousel
                ACarousel(
                    userReview_dataSource,
                    index: self.$current_userReview,
                    spacing: 0,
                    headspace: 45,
                    sidesScaling: 0.8,
                    isWrap: true,
                    autoScroll: .active(12),
                    offsetAnimation: .smooth(duration: 0.3)
                ) { item in
                    UserReviewView(model: item)
                }
                .frame(height: 135,alignment: .center)
                
                // Page Control
                PageControlSUI(
                    currentPage: self.$current_userReview,
                    numberOfPages: userReview_dataSource.count,
                    selectedColor: .white,
                    unselectedColor: .white.withAlphaComponent(0.5),
                    isUserInteractionEnabled: false
                )
                
                // Container
                VStack(spacing: 18) {
                    // LIst
                    VStack(spacing: 12) {
                        // Products
                            if DeviceMenager.isSmallDevice {
                                if !self.cpm.products.isEmpty {
                                    // Small device
                                    ChatPaywallCell_v2(
                                        selection: self.$cpm.selected_product,
                                        model: self.cpm.products[2].toCellItem(),
                                        cellType: .standart
                                    )
                                    
                                    HStack {
                                        ChatPaywallCell_v2(
                                            selection: self.$cpm.selected_product,
                                            model: self.cpm.products[1].toCellItem()
                                        )
                                        ChatPaywallCell_v2(
                                            selection: self.$cpm.selected_product,
                                            model: self.cpm.products[0].toCellItem()
                                        )
                                    }
                                }
                            } else {
                                ForEach(self.cpm.products, id: \.self) { item in
                                // Regular device
                                VStack {
                                    ChatPaywallCell_v1(
                                        selection: self.$cpm.selected_product,
                                        model: item.toCellItem()
                                    )
                                }
                            }
                        }
                        if self.cpm.products.isEmpty {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.white)
                                .padding()
                        }
                    }
                    // Buttons
                    self.buttons()
                } // Container
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, safeAreaInsets.bottom + 6)
                .background {
                    RoundedCorner(radius: DS.maxCornerRadius, corners: [.topLeft, .topRight])
                        .fill(Color(DS.Chat.bg).opacity(0.9))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background { LottieBackgroundView() }
        // Policies
        .fullScreenCover(item: $presentURL) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder func buttons() -> some View {
        BigButton(
            title: "Continue",
            isLoad: self.$isPurchasing,
            action: {
                self.isPurchasing = true
                self.cpm.purchaseProduct { id in
                    self.isPurchasing = false
                    self.sm.setStarsPurchesed(id)
                    self.sm.getBalance()
                    self.dismiss()
                }
            }
        )
        HStack(spacing: 0) {
            Spacer()
            Button("Terms Of Use", action: {
                self.presentURL = URL(string: AppSupportedLinks.terms.rawValue)
            })
            Spacer()
            Button("Restore purchases", action: {
                
            })
            Spacer()
            Button("Privacy Policy", action: {
                self.presentURL = URL(string: AppSupportedLinks.privacy.rawValue)
            })
            Spacer()
        }
        .font(UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 11 : 13)?.asCTFont())
        .tint(.white)
    }
    
    @ViewBuilder func closeButton() -> some View {
        Button {
            self.dismiss()
        } label: {
            ZStack {
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
            }
            .frame(width: 32, height: 32, alignment: .trailing)
            .clipShape(Rectangle())
            .opacity(0.8)
        }
    }
    
}

#Preview {
    ChatPaywall(
        cpm: ChatPaywallManager(),
        sm: StarsManager()
    )
}




extension NSMutableAttributedString {
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}



struct LabelView: View {
    var text: String

    var body: some View {
        InternalLabelView(text: text)
    }

    struct InternalLabelView: UIViewRepresentable {
        var text: String

        func makeUIView(context: Context) -> UILabel {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            label.font = DS.CinzelFont.title_h0

            label.textColor = DS.Chat.textColor
            let mas: NSMutableAttributedString = {
                let mas = NSMutableAttributedString(string: text)
                mas.setColorForText(textForAttribute: "ask", withColor: DS.Chat.orange)
                mas.setColorForText(textForAttribute: "specialist.", withColor: DS.Chat.orange)

                // NSMutableParagraphStyle
                let mps = NSMutableParagraphStyle()
                mps.lineSpacing = 0
                mps.minimumLineHeight = 10
                mps.paragraphSpacingBefore = 0
                mps.maximumLineHeight = 50
                mas.addAttribute(NSAttributedString.Key.paragraphStyle, value: mps, range: NSMakeRange(0, text.count))
                return mas
            }()
            label.attributedText = mas
            return label
        }

        func updateUIView(_ uiView: UILabel, context: Context) {}
    }
}


extension ChatPaywall {
    static func adaptive_font_title() -> UIFont? {
        return DeviceMenager.isSmallDevice ? DS.CinzelFont.title_h1 : DS.CinzelFont.title_h0
    }
}
