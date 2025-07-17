//
//  MarkdownTEST.swift
//  Numerology
//
//  Created by Serj_M1Pro on 07.07.2025.
//

import SwiftUI
//import Markdown
import MarkdownUI


struct MarkdownTEST: View {
    
    let source = "This is a markup *document*."
//    let document = Document(parsing: markdown_text)
    
    var body: some View {
        ScrollView {
            Markdown(markdown_text)
                .font(.system(size: 11))
                .scaleEffect(x: 0.9, y: 0.9)
        }
        .onAppear {
//            print("Test Lang", Locale.current.identifier ?? "auto" )
            
            // sdk - Localize_Swift
//            print("2", Localize.la)
            ExpertViewModel.determineDeviceLanguage()
        }
    }
}

#Preview {
    MarkdownTEST()
}

// simulator - Test Lang en_RU


