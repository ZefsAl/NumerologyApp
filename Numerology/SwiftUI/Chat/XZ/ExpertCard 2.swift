//
//  SelectExpertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.05.2025.
//

import SwiftUI

struct ExpertCard_Mini: View {
    
    let model: ExpertModel
    
    // MARK: - body
    var body: some View {
        VStack(alignment: .center, spacing: -18) {
            Image(model.image)
                .resizable(resizingMode: .stretch)
                .frame(width: 151, height: 151)
                .overlay (
                    Circle()
                        .strokeBorder(Color(DS.Chat.primary), lineWidth: 2)
                )
                .clipShape(Circle())
                .overlay (
                    Circle()
                        .fill(Color(DS.Chat.green))
                        .frame(width: 24, height: 24)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(10)
                )
            
            HStack(alignment: .top, spacing: 2) {
                Text(model.fl_Name)
                    .font(DS.SourceSerifProFont.title_h4_SB?.asCTFont())
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 8))
            }
            .padding(EdgeInsets(top: 5, leading: 12, bottom: 3, trailing: 6))
            .background {
                Capsule().fill(Color(DS.Chat.primary))
            }
        }
        .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
    }
}

#Preview {
    ExpertCard_Mini(
        model: ExpertViewModel().expertsList[0]
    )
}
