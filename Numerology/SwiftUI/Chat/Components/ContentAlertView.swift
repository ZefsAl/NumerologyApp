//
//  ContentAlertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 16.06.2025.
//

import SwiftUI

struct ContentAlertView<Content: View>: View {
    
    @Binding var isPresented: Bool
    var bgTint: Color = .black.opacity(0.8)
    var strokeTint: Color = .red.opacity(0.8)
    var content: () -> Content
    var onBgTapDismiss: (() -> ())?
    
    
    // Animation
    @State private var isAnimating = false
    private let animationDuration = 0.5
    
    init(
        isPresented: Binding<Bool>,
        onBgTapDismiss: (() -> ())? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        _isPresented = isPresented
        self.onBgTapDismiss = onBgTapDismiss
        self.content = content
    }
    
    var body: some View {
        ZStack {
            if isAnimating {
                // fullcover BG
                Color(.black)
                    .ignoresSafeArea()
                    .opacity(isPresented ? 0.85 : 0)
                    .onTapGesture {
                        if let onBgTapDismiss {
                            self.dismiss()
                            onBgTapDismiss()
                        }
                    }
                // Content
                ZStack() {
                    content()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .zIndex(1)
                .transition(.offset(
                    x: 0,
                    y: UIScreen.main.bounds.height
                ))
            }
        }
        .ignoresSafeArea()
        .zIndex(0)
        .onAppear {
            show()
        }
    }
    
    // Actions
    func dismiss() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            isAnimating = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            withoutTransaction {
                isPresented = false
            }
        }
    }
    
    func show() {
        withAnimation(.bouncy(duration: animationDuration, extraBounce: 0)) {
            isAnimating = true
        }
    }
    
}







struct ContentAlertViewPreview: View {
    @State var isPresented: Bool = false
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea(.all)
        }
        .onTapGesture {
            withoutTransaction {
                self.isPresented = true
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                withoutTransaction {
                    self.isPresented = true
                }
            }
        }
        .contentAlert(
            isPresented: self.$isPresented,
            onBgTapDismiss: {},
            content: {
                ExpertCard(
                    model: ExpertViewModel().expertsList[0],
                    frameSize: CGSize(
                        width: UIScreen.main.bounds.width-32,
                        height: UIScreen.main.bounds.height/1.8
                    )
                )
            })
    }
}

#Preview {
    ContentAlertViewPreview()
}
