//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 26.10.2024.
//

import SwiftUI


struct CustomRateAlert: View {
    
    @Binding private var isPresented: Bool
    @State private var title: String
    @State private var message: String? = nil
    private var primaryAction: (() -> ())?
    
    // Animation
    @State private var isAnimating = false
    private let animationDuration = 0.5
    
    init(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryAction: @escaping () -> ()
    ) {
        _isPresented = isPresented
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
    }
    
    var body: some View {
        
        ZStack {

            if isAnimating {
                // fullcover BG
                Color(uiColor: .black)
                    .ignoresSafeArea()
                    .opacity(isPresented ? 0.6 : 0)
                    .onTapGesture {
                        self.dismiss()
                    }
                // Content
                ZStack {
                    VStack(spacing: 32) {
                        //                Text("Do you like this app?")
                        Text(self.title)
                        if let message {
                            Text(message)
                                .multilineTextAlignment(.center)
                        }
                        
                        HStack(spacing: 16) {
                            // Dislike
                            Button {
                                self.dismiss()
                            } label: {
                                Text("👎")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            }
                            .frame(width: 126, height: 46, alignment: .center)
                            .background(Color.init(uiColor: .systemGray4))
                            .clipShape(RoundedRectangle(cornerRadius: .infinity))
                            // Like
                            Button {
                                if let primaryAction {
                                    primaryAction()
                                }
                            } label: {
                                Text("👍")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            }
                            .frame(width: 126, height: 46, alignment: .center)
                            .background(Color.init(uiColor: .systemGray4))
                            .clipShape(RoundedRectangle(cornerRadius: .infinity))
                        }
                    }
                }
                .frame(
                    maxWidth: UIScreen.main.bounds.width-32,
                    maxHeight: 200
                )
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 32))
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
            self.withoutTransaction {
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

#Preview {
    @State var isPresented: Bool = false
    return CustomRateAlert(
        isPresented: $isPresented,
        title: "Test",
        message: "1232512515125") {
            
        }
}

