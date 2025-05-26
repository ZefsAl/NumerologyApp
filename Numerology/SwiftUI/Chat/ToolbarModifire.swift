//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.05.2025.
//

import SwiftUI

struct KeyboardToolbar<ToolbarView: View>: ViewModifier {
    @Binding private var height: CGFloat
    
    private let toolbarView: ToolbarView
    
    init(height: Binding<CGFloat>, @ViewBuilder toolbar: () -> ToolbarView) {
        self._height = height
        self.toolbarView = toolbar()
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    content
                }
                .frame(width: geometry.size.width, height: geometry.size.height - (height + 54) )
            }
            toolbarView
                .frame(height: self.height + 54)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.orange)
    }
}


extension View {
    func keyboardToolbar<ToolbarView>(height: Binding<CGFloat>, view: @escaping () -> ToolbarView) -> some View where ToolbarView: View {
        modifier(KeyboardToolbar(height: height, toolbar: view))
    }
}

struct ContentView1231: View {
    @State private var username = ""
    @FocusState var isFocused: Bool
    var body: some View {
        NavigationView{
            Text("Keyboar toolbar")
                .keyboardToolbar(height: .constant(50)) {
                    VStack {
                        TextField("Username", text: $username)
                            .focused($isFocused)
                        Button {
                            self.isFocused.toggle()
                        } label: {
                            Text("SHow Keyboard")
                        }

                    }
                    .border(.secondary, width: 1)
                    .padding()
                }
        }
    }
}

#Preview {
    ContentView1231()
}
