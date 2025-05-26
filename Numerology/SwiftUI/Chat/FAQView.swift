//
//  FAQChips.swift
//  Numerology
//
//  Created by Serj_M1Pro on 21.05.2025.
//

import SwiftUI

struct FAQChips: View {
    
    var title: String
    @Binding var selected: String
    
    private var isSelected: Bool { self.selected == self.title }
    
    var body: some View {
        Button {
            self.selected = self.title
        } label: {
            VStack {
                Text(self.title)
                    .font(DS.SourceSerifProFont.title_h4!.asCTFont())
                    .foregroundStyle(isSelected ? .white : Color(DS.Horoscope.lightTextColor))
                    .padding(.horizontal, self.title.isMultilinedText ? 0 : 16 )
                    .padding(.vertical,12)
                    .frame(minWidth: self.title.isMultilinedText ? 180 : nil)
                    .background {
                        switch isSelected {
                        case true: Color(DS.PaywallTint.primaryPaywall)
                        case false: Color(.hexColor("302B4B")).opacity(0.7)
                        }
                    }
                    .overlay(
                        Capsule()
                            .strokeBorder(Color(DS.PaywallTint.primaryPaywall), lineWidth: 1)
                    )
                    .clipShape(Capsule())
                    .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
            }
        }
    }
}

extension String {
    var isMultilinedText: Bool { self.split(separator: "\n").count > 1 }
}

struct FAQChipsSelectionView: View {
    
    @State var selected: String = ""
    
    private let vSpacing: CGFloat = 16
    private let hSpacing: CGFloat = 8
    
    // 👍
    var body: some View {
        VStack(spacing: vSpacing) {
            FAQChips(
                title: chipsFAQData[0],
                selected: self.$selected
            )
            
            HStack(spacing: hSpacing) {
                FAQChips(
                    title: chipsFAQData[1],
                    selected: self.$selected
                )
                FAQChips(
                    title: chipsFAQData[2],
                    selected: self.$selected
                )
            }
            
            FAQChips(
                title: chipsFAQData[3],
                selected: self.$selected
            )
            
            HStack(spacing: hSpacing) {
                FAQChips(
                    title: chipsFAQData[4],
                    selected: self.$selected
                )
                FAQChips(
                    title: chipsFAQData[5],
                    selected: self.$selected
                )
            }
            
            FAQChips(
                title: chipsFAQData[6],
                selected: self.$selected
            )
            
            HStack(spacing: hSpacing) {
                FAQChips(
                    title: chipsFAQData[7],
                    selected: self.$selected
                )
                FAQChips(
                    title: chipsFAQData[8],
                    selected: self.$selected
                )
            }
            
            FAQChips(
                title: chipsFAQData[9],
                selected: self.$selected
            )
        }
    }
}

#Preview {
    FAQChipsSelectionView()
}

let chipsFAQData: [String] = [
    "SHOULD I TRUST MY GUT?",
    
    "WHAT’S MY\nTRUE POWER?",
    "IS THIS MY\nSOULMATE?",
    
    "WHAT’S IN THE STARS TODAY?",
    
    "SHOULD I\nTRUST MY GUT?",
    "WHERE IS SATURN\nLEADING ME?",
    
    "WHAT DOES MY NAME SAY?",
    
    "WHAT ENERGY\nGUIDES ME?",
    "IS THIS A GOOD\nTIME TO ACT?",
    
    "IS THIS A DESTINY SIGN?",
]

//2,3,5,6,8,9
