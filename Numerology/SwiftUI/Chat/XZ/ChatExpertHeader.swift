//
//  ChatExpertHeader.swift
//  Numerology
//
//  Created by Serj_M1Pro on 21.05.2025.
//

import SwiftUI

struct ChatExpertHeader: View {
    
    let expertModel: ExpertModel
    var profileAction: (() -> ())? = nil
    var closeAction: (() -> ())? = nil
    
    var body: some View {
        HStack {
            // Person
            Button {
                if let profileAction { profileAction() }
            } label: {
                HStack {
                    Image(expertModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .overlay (
                            Circle()
                                .strokeBorder(Color(DS.Chat.primary), lineWidth: 2)
                        )
                        .clipShape(Circle())
                        .overlay {
                            ZStack {
                                Circle()
                                    .fill(Color(DS.Chat.green))
                                    .frame(width: 10, height: 10)
                                    .padding(.top, 2)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        }
                    
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text(expertModel.fl_Name)
                                .multilineTextAlignment(.leading)
                                .font(DS.SourceSerifProFont.title_h4_SB!.asCTFont())
                            if let profileAction {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 11, weight: .bold))
                            }
                        }
                        .foregroundStyle(.white)
                        Text(expertModel.profession)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Color(.hexColor("9C9CA3")))
                            .font(DS.SourceSerifProFont.title_h6!.asCTFont())
                    }
                }
            }
            .allowsHitTesting(profileAction != nil)
            
            Spacer()
            
            // Close
            if let closeAction {
                Button {
                    closeAction()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.white.opacity(0.7))
                        .font(.system(size: 18, weight: .regular))
                        .frame(width: 24, height: 24)
                }
            }
        }
//        Divider().overlay(Color.red)
    }
}

#Preview {
    VStack {
        ChatExpertHeader(expertModel: ExpertViewModel().expertsList[0])
        ForEach(ExpertViewModel().expertsList) { item in
            ChatExpertHeader(
                expertModel: item,
                profileAction: {},
                closeAction: {}
            )
        }
    }
}
//ExpertViewModel
