//
//  ClearHistoryButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 01.07.2025.
//

import SwiftUI


struct ClearHistoryButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "trash")
                Text("Delete History")
                    .font(DS.SourceSerifProFont.title_h4!.asCTFont())
            }
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.bordered)
        .tint(.red)
    }
}

#Preview {
    ClearHistoryButton {
        
    }
}
