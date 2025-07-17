//
//  CloseCircleButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 01.07.2025.
//

import SwiftUI


struct CloseCircleButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: "xmark")
                .padding(10)
        }
        .background(Circle().fill(.gray.opacity(0.3)))
        .tint(.gray)
    }
}

#Preview {
    VStack {
        CloseCircleButton {}
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    .background(.black)
}
