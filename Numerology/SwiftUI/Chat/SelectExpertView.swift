//
//  SelectExpertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.05.2025.
//

import SwiftUI
import ACarousel
import AuthenticationServices

struct SelectExpertView: View {
    @StateObject var evm = ExpertViewModel()
    @StateObject var authManager: AuthManager = AuthManager()
    @StateObject var sm: StarsManager = StarsManager()
    @StateObject var cpm: ChatPaywallManager = ChatPaywallManager()
    
    //
    @State private var selection: Int = 1
    @State private var isPresented_Chat: Bool = false
    @State private var isPresented_Paywall: Bool = false
    @State private var isPresented_ExpertInfo: Bool = false
    @State private var isPresented_SignInNotice: Bool = false
    
    
    private var expertName: String {
        String(ExpertViewModel().expertsList[self.selection].fl_Name.split(separator: " ").first ?? "")
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Title
            PageTitile(title: "Select an expert\nfor chat")
            
            // Experts
            ACarousel(
                self.evm.expertsList,
                index: self.$selection,
                spacing: 0,
                headspace: 45,
                sidesScaling: 0.8,
                isWrap: false,
                autoScroll: .inactive,
                offsetAnimation: .smooth(duration: 0.3)
            ) { item in
                ExpertCard(
                    model: item,
                    frameSize: getAdaptive_ExpertCardSize(),
                    showReadMoreLabel: true,
                    descriptionScrollEnabled: false,
                    onTap: {
                        withoutTransaction {
                            self.isPresented_ExpertInfo = true
                        }
                    }
                )
            }
            .frame(height: getAdaptive_ExpertCardSize().height + adaptive_ExpertCardSize_contaiter(), alignment: .top)
            Spacer()
            VStack(spacing: 6) {
                let state = self.sm.userBalance == 0
                let text = state ? "Ask \(self.expertName) Now" : "Chat"
                // Header
                if authManager.authState == .signedIn {
                    self.starsHeader()
                    // Button CTA

                HStack {
                    if !state {
                        BigButton(
                            title: "Store",
                            style: .bordered,
                            minHeight: self.adaptive_BigButton_Height(),
                            cornerRadius: self.adaptive_BigButton_cornerRadius(),
                            action: {
                                self.isPresented_Paywall = true
                            }, trailingContent: {
                                Image("StarPrimary")
                                    .renderingMode(.template)
                                    .foregroundStyle(.white)
                            }
                        )
                    }
                    BigButton(
                        title: text,
                        minHeight: self.adaptive_BigButton_Height(),
                        cornerRadius: self.adaptive_BigButton_cornerRadius(),
                        action: {
                            if self.sm.userBalance == 0 {
                                self.isPresented_Paywall = true
                            } else {
                                self.isPresented_Chat = true
                            }
                        }, trailingContent: { Image("SendArrow") }
                    )
                    .id(UUID()) // хз не переотрисовывала
                }
                    
                } else {
                    self.notice()
                        .padding(.bottom, 10)
                    // MARK: - Apple
                    SignInWithAppleButton(
                        onRequest: { request in
                            AppleSignInManager.shared.requestAppleAuthorization(request)
                        },
                        onCompletion: { result in
                            self.authManager.handleAppleID(result)
                        }
                    )
                    .signInWithAppleButtonStyle(.white)
                    .frame(height: self.adaptive_BigButton_Height())
                    .cornerRadius(self.adaptive_BigButton_cornerRadius())
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background{ HoroscopeBG() }
        // Balance
        .onAppear {
            self.sm.getBalance()
        }
        // Chat
        .fullScreenCover(isPresented: self.$isPresented_Chat) {
            ChatRoom(
                expertModel: self.evm.expertsList[selection],
                sm: self.sm,
                cpm: self.cpm,
                closeAction: { self.isPresented_Chat = false }
            )
        }
        // Paywall
        .fullScreenCover(isPresented: self.$isPresented_Paywall) {
            ChatPaywall(
                cpm: self.cpm,
                sm: self.sm
            )
        }
        // Expert Description
        .contentAlert(
            isPresented: self.$isPresented_ExpertInfo,
            onBgTapDismiss: {},
            content: {
                ExpertCard(
                    model: self.evm.expertsList[selection],
                    frameSize: CGSize(
                        width: UIScreen.main.bounds.width-32,
                        height: UIScreen.main.bounds.height/1.8
                    )
                )
            })
        
        // Notice
        .contentAlert(
            isPresented: self.$isPresented_SignInNotice,
            onBgTapDismiss: {},
            content: { self.noticeView() })
    }
    
    // MARK: - stars Header
    @ViewBuilder func starsHeader() -> some View {
        HStack {
            Text("Your Stars:")
                .font(DS.SourceSerifProFont.title_h3!.asCTFont())
                .foregroundStyle(Color(DS.Horoscope.lightTextColor))
            StarsAmountVeiw(sizetype: .large, stars: self.$sm.userBalance)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder func noticeView() -> some View {
        VStack {
            HStack {
                Spacer()
                CloseCircleButton { self.isPresented_SignInNotice = false }
            }
            .padding(.horizontal)
            VStack(alignment: .leading, spacing: 16) {
                Text("Sign in with Apple protects your privacy and is convenient:")
                    .font(DS.SourceSerifProFont.title_h3!.asCTFont())
                Text("""
                • Apple does not share your email, passwords, or personal data with us. 🔒
                
                • You need to sign in to ask questions. 💬
                
                • This will help us maintain your account balance. ⭐️
                
                • We do not use your personal data. You decide whether to share your real email or use a hidden one. 👻                 
                """)
                .font(DS.SourceSerifProFont.title_h4!.asCTFont())
            }
            .padding(.horizontal)
            .frame(
                width: UIScreen.main.bounds.width-32,
                height: 362,
                alignment: .leading
            )
            .background {
                Color(.hexColor("302B4B")).opacity(0.7)
            }
            .overlay(
                RoundedRectangle(cornerRadius: DS.maxCornerRadius)
                    .strokeBorder(Color(DS.PaywallTint.primaryPaywall), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: DS.maxCornerRadius))
            .shadow(color: Color(DS.PaywallTint.primaryPaywall), radius: 16, x: 0, y: 4)
        }
    }
    
    @ViewBuilder func notice() -> some View {
        Button {
            withoutTransaction {
                self.isPresented_SignInNotice = true
            }
        } label: {
            HStack(alignment: .center, spacing: 4) {
                Text("Read about - sign in")
                    .font(font_adaptive_ReadAboutSignIn()?.asCTFont())
                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .semibold))
            }
            .foregroundStyle(.white)
            
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 12))
    }
}

#Preview {
    SelectExpertView()
}
