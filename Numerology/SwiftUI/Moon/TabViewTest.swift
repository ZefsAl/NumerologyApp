//
//  TabViewTest.swift
//  Numerology
//
//  Created by Serj_M1Pro on 26.11.2024.
//

import SwiftUI

struct TabViewTest: View {
    
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            SomeViewTest(text: "e5SfUSyNsU1dlKqwta9wvR", color: .red).tag(0)
            SomeViewTest(text: "e5SfUSyNsU1dlKqwta9wvR", color: .blue).tag(1)
            
        }
        // .tabViewStyle(.page(indexDisplayMode: .never))
        .tabViewStyle(.page)
    }
}

#Preview {
    TabViewTest()
}


struct SomeViewTest: View {
    
    let text: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(text)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(color)
        
    }
}
