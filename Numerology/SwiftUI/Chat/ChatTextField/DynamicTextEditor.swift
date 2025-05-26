//
//  DynamicTextEditor.swift
//  Numerology
//
//  Created by Serj_M1Pro on 22.05.2025.
//

import SwiftUI

/// Default leading padding(4)
struct DynamicTextEditor: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var dynamicHeight: CGFloat
    @Binding var customFocuse: Bool
    @State var placeholder: String
    @State var phColor: UIColor = .lightGray
    @State var tint: UIColor = .white
    @State var placeholderVisible: Bool = true
    //
    var insets: UIEdgeInsets = .zero
    var font: UIFont = UIFont.systemFont(ofSize: 17)
    
    func makeUIView(context: Context) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        tv.placeholder = self.placeholder
        // tv.isScrollEnabled = false // ломоет конфиг
        tv.font = .systemFont(ofSize: 17)
        tv.delegate = context.coordinator
        tv.textAlignment = .left
        //
        tv.textContainerInset = self.insets
        tv.backgroundColor = .clear
        tv.textContainer.lineBreakMode = .byWordWrapping
        tv.tintColor = self.tint
        
        tv.font = self.font
        return tv
    }
    
    func updateUIView(_ uiView: PlaceholderTextView, context: Context) {
        uiView.text = text
        // После того как SwiftUI установит frame, пересчитаем высоту
        DispatchQueue.main.async(qos: .userInteractive) {
            let size = uiView.sizeThatFits(
                CGSize(width: uiView.bounds.width, height: .greatestFiniteMagnitude)
            )
            if dynamicHeight != size.height {
                dynamicHeight = size.height
            }
        }

        print("🟣 uiView.isFirstResponder", uiView.isFirstResponder)
        print("🟣 uiView.isFocused", uiView.isFocused)
        print("🟣 self.customFocuse", self.customFocuse)
        print("🟣 ________________________________________________")
        
        DispatchQueue.main.async(qos: .userInteractive) {
            if self.customFocuse {
                uiView.becomeFirstResponder()
            } else {
                uiView.resignFirstResponder()
            }
        }
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            text: $text,
            height: $dynamicHeight,
            placeholder: $placeholder,
            phColor: $phColor,
            customFocuse: $customFocuse
        )
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var height: Binding<CGFloat>
        var placeholder: Binding<String>
        var phColor: Binding<UIColor>
        var customFocuse: Binding<Bool>
        
        init(
            text: Binding<String>,
            height: Binding<CGFloat>,
            placeholder: Binding<String>,
            phColor: Binding<UIColor>,
            customFocuse: Binding<Bool>
        ) {
            self.text = text
            self.height = height
            self.placeholder = placeholder
            self.phColor = phColor
            self.customFocuse = customFocuse
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async(qos: .userInteractive) { [weak self] in
                guard let self else { return }
                text.wrappedValue = textView.text
                // Resizing by text
                let size = textView.sizeThatFits(
                    CGSize(width: textView.bounds.width, height: .greatestFiniteMagnitude)
                )
                if height.wrappedValue != size.height {
                    height.wrappedValue = size.height
                }
            }
        }
        
        func textViewDidChangeSelection(_ textView: UITextView) {
            //print("⚠️🟣textViewDidChangeSelection")
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            self.updateFocuse(textView)
            //print("🟣🟠textViewDidEndEditing")
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            self.updateFocuse(textView)
            //print("🟣🟠textViewDidBeginEditing")
        }
        
        private func updateFocuse(_ textView: UITextView) {
            DispatchQueue.main.async(qos: .userInteractive) {
                self.customFocuse.wrappedValue = textView.isFirstResponder
            }
        }
        
    }
}

struct HuggingTF3_TESTPREVIEW: View {
//    @State var text: String = ""
        @State var text: String = "The value for FacebookAdvertiserIDCollectionEnabled is currently set to FALSE so you're sending app events without collecting Advertiser ID. This can affect the quality of your advertising and analytics results."
    @State private var height: CGFloat = 40
    @State var customFocuse: Bool = false
    
    var body: some View {
        
        VStack {
            Button(self.customFocuse ? "HIDE" : "SHOW") {
                self.customFocuse.toggle()
            }
            .buttonStyle(.bordered)
            .tint(.orange)
            GeometryReader { proxy in
                DynamicTextEditor(
                    text: $text,
                    dynamicHeight: $height,
                    customFocuse: $customFocuse,
                    placeholder: "Placeholder"
                )
                    .frame(width: proxy.size.width, height: height)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .animation(.easeInOut, value: height)
            }
            .frame(height: height) // предотвращаем бесконечный рост GeometryReader
            .padding()
            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.text = "Pla"
//                }
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    self.text = ""
//                }
            }
            
        }
    }
}

#Preview {
    HuggingTF3_TESTPREVIEW()
}
