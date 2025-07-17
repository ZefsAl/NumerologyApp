//
//  ChatTextField.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.05.2025.
//

import SwiftUI

struct ChatTextField: View {
    
    @Binding var enteredText: String
    @Binding var stars: Int
    @Binding var isLoading: Bool
    @Binding var dynamicHeight: CGFloat
    @Binding var customFocuse: Bool
    @State var font: UIFont
    let buttonAction: () -> ()
    
    var body: some View {
        HStack(alignment: .bottom,spacing: 0) {
            VStack(alignment: .leading, spacing: -0) {
                //
                StarsAmountVeiw(sizetype: .mini, stars: self.$stars)
                    .padding(.leading, 4)
                // TextField
                GeometryReader { proxy in
                    DynamicTextEditor(
                        text: $enteredText,
                        dynamicHeight: $dynamicHeight,
                        customFocuse: $customFocuse,
                        placeholder: "Write your message...",
                        font: self.font
                    )
                    .frame(width: proxy.size.width, height: dynamicHeight)
                }
                .frame(height: dynamicHeight) // предотвращаем бесконечный рост GeometryReader
            }
            .padding(EdgeInsets(top: 12, leading: 14, bottom: 10, trailing: 8))
            Button {
                self.buttonAction()
            } label: {
                Image("SendArrowTF")
                    .padding(.trailing, 18)
                    .padding(.bottom, 14)
                    .clipShape(RoundedRectangle(cornerRadius: DS.maxCornerRadius))
            }
            .disabled(enteredText.isEmpty || isLoading)
        }// HStack
        .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: DS.maxCornerRadius)
                    .fill(Color(.hexColor("302B4B")).opacity(0.7))
                    .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
                RoundedRectangle(cornerRadius: DS.maxCornerRadius)
                    .strokeBorder(Color(DS.PaywallTint.primaryPaywall), lineWidth: 1)
            }
            
        }
        .onTapGesture {
            withAnimation() {
                self.customFocuse = true
            }
        }
        
    }
}

struct ChatTextField_TESTPREVIEW: View {
    
    @State var enteredText: String = ""
//    @State var enteredText: String = "The value for FacebookAdvertiserIDCollectionEnabled is currently set to FALSE so you're sending app events without collecting Advertiser ID. This can affect the quality of your advertising and analytics results."
    @State var stars: Int = 10
    @State var isLoading: Bool = false
    
    @State var dynamicHeight: CGFloat = 10
    
    var body: some View {
        ChatTextField(
            enteredText: self.$enteredText,
            stars: self.$stars,
            isLoading: self.$isLoading,
            dynamicHeight: $dynamicHeight,
            customFocuse: .constant(false),
            font: DS.SourceSerifProFont.title_h4!,
            buttonAction: { }
        )
        .padding()
    }
}

#Preview {
    ChatTextField_TESTPREVIEW()
}
