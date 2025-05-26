//
//  SelectExpertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.05.2025.
//

import SwiftUI

struct ExpertCard: View {
    
    let model: ExpertModel
    let frameSize: CGSize
    var showReadMoreLabel: Bool = false
    
    private let titleFont = DS.SourceSerifProFont.title_h4!
    private let bodyFont = DS.SourceSerifProFont.title_h6!
    private let caption3 = DS.SourceSerifProFont.caption3!
    private let footnote_Sb_13 = DS.SourceSerifProFont.footnote_Sb_13!.asCTFont()
    
    // MARK: - body
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 16) {
                Image(model.image)
                    .resizable(resizingMode: .stretch)
                    .frame(width: 101, height: 101)
                    .overlay (
                        Circle()
                            .strokeBorder(Color(DS.Chat.primary), lineWidth: 2)
                    )
                    .clipShape(Circle())
                    .overlay (
                        self.onlineBadge()
                    )
                // Expert
                self.expertData()
            }
            .frame(height: 101)
            .padding(.top)
            .padding(.horizontal)
            
            // About
            self.aboutExpert()
            .overlay {
                self.moreContentDecor()
            }
        }
        .frame(
            minWidth: frameSize.width,
            maxWidth: frameSize.width,
            minHeight: frameSize.height,
            maxHeight: frameSize.height,
            alignment: .center
        )
        .background {
            Color(.hexColor("302B4B")).opacity(0.7)
        }
        .overlay(
            RoundedRectangle(cornerRadius: DS.maxCornerRadius)
                .strokeBorder(Color(DS.PaywallTint.primaryPaywall), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: DS.maxCornerRadius))
        .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
    }
    
    // MARK: - expert Data
    @ViewBuilder func expertData() -> some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(alignment: .top, spacing: 2) {
                Text(model.fl_Name)
                    .font(Font((self.titleFont) as CTFont))
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 8))
            }
            Text(model.profession)
                .font(Font((self.bodyFont) as CTFont))
            self.labelRow(title: "Age: ", text: "\(model.age)")
            self.labelRow(title: "Expirience: ", text: "\(model.expirience)")
            self.labelRow(title: "Country: ", text: "\(model.country)")
        }
        .multilineTextAlignment(.leading)
    }
    
    // MARK: - label Row
    @ViewBuilder func labelRow(title: String, text: String) -> some View {
        HStack(spacing: 0) {
            Text(title)
                .foregroundStyle(Color(.hexColor("9C9CA3")))
                .font(Font((self.bodyFont) as CTFont))
            Text(text)
                .font(Font((self.bodyFont) as CTFont))
        }
    }
    
    // MARK: - about Expert
    @ViewBuilder func aboutExpert() -> some View {
        VStack(alignment: .leading, spacing: 4){
            Text("About the Expert")
                .font(Font((self.titleFont) as CTFont))
            ScrollView {
                Text(self.model.description)
                    .font(Font((self.bodyFont) as CTFont))
                    .padding(.bottom, 60)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - online Badge
    @ViewBuilder func onlineBadge() -> some View {
        ZStack(alignment: .bottom) {
            Text("Online")
                .font(Font((self.caption3) as CTFont))
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background {
                    Capsule().fill(Color(DS.PaywallTint.discountBadge))
                }
                .offset(y: 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    
    // MARK: - more Content Decor
    @ViewBuilder func moreContentDecor() -> some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                gradient: Gradient(colors: [
                    .clear,
                    Color(.hexColor("302B4B")).opacity(0.6),
                    Color(.hexColor("302B4B")).opacity(0.9),
                ]),
                startPoint: .top, endPoint: .bottom
            )
            .allowsHitTesting(false)
            .frame(maxHeight: self.frameSize.height/5)
            
            if self.showReadMoreLabel {
                HStack(alignment: .center, spacing: 4) {
                    Text("Read more")
                        .font(self.footnote_Sb_13)
                    Image(systemName: "chevron.right")
                        .font(self.footnote_Sb_13)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(Capsule().fill(Color(DS.PaywallTint.primaryPaywall)))
                .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    ExpertCard(
        model: ExpertViewModel().expertsList[0],
        frameSize: CGSize(width: 300, height: 440)
    )
}
