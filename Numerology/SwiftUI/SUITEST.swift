//
//  SUITEST.swift
//  Numerology
//
//  Created by Serj_M1Pro on 07.07.2025.
//

import SwiftUI

struct SUITEST: View {
    
    var body: some View {
        ScrollView {
            Text("Hello")
        }
        .onAppear {
            TokensManager.shared.getDeepseekToken { val in
                
            }
        }
    }
}

#Preview {
    SUITEST()
}


