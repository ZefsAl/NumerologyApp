//
//  ChatOfferView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 04.06.2025.
//

import SwiftUI

struct ChatOfferView: View {
    
    let closeAction: () -> Void
    let buyNowAction: () -> Void
    
    @StateObject private var vm = ChatOfferVM()
    
    var body: some View {
        VStack {
            ChatView(
                streamingMessage: self.$vm.streamingMessage,
                isStreaming: self.$vm.isStreaming,
                messages: Binding(
                    get: { self.vm.messages.filter { $0.role != .system } },
                    set: { _ in /* Нечего устанавливать это делает sendMessage */ }),
                expertModel: self.vm.expertModel,
                newMessage: self.$vm.newMessage,
                isLoading: self.$vm.isLoading,
                stars: self.$vm.stars,
                customFocuse: self.$vm.customFocuse,
                showBuyNowBtn: self.$vm.showBuyNowBtn,
                sendMessage: { self.vm.sendMessage() },
                buyNowAction: self.buyNowAction,
                header: {
                    VStack(spacing: -20) {
                        // Close
                        Button {
                            self.closeAction()
                        } label: {
                            Image(systemName: "xmark")
                                .tint(.white.opacity(0.7))
                                .font(.system(size: 15, weight: .regular))
                        }
                        .frame(maxWidth: .infinity, maxHeight: 18, alignment: .trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 16))
                        VStack(spacing: 0) {
                            // Card - v2
                            if !self.vm.customFocuse {
                                VStack(spacing: 0) {
                                    ExpertCard_Mini(model: self.vm.expertModel)
                                        .padding(.bottom, 12)
                                    // Title
                                    PageTitile(title: "Let’s Chat with\nPersonal Astrologer!")
                                        .shadow(color: Color(DS.Chat.textColor), radius: 16, x: 0, y: 4)
                                }
                                .transition(.scale(scale: 0, anchor: .topLeading))
                                
                            } else {
                                ChatExpertHeader(expertModel: self.vm.expertModel)
                                .padding(.horizontal)
                                .transition(.scale(scale: 0, anchor: .center))
                            }
                        }
                        
                        .animation(.smooth(duration: 0.5), value: self.vm.customFocuse)
                    }
                }
            )
        } // VStack
        .onAppear {
            self.vm.addHelloMessage()
        }
        .onReceive(self.vm.$stars) { val in
            if val == 0 {
                self.vm.showBuyNowBtn = true
            }
        }
        
    }
}

#Preview {
    ChatOfferView(closeAction: {}, buyNowAction: {})
}

//Card
//                GeometryReader { geo in
//                    if !self.vm.customFocuse {
//                        ExpertCard(
//                            model: self.vm.expertModel,
//                            frameSize: CGSize(width: geo.size.width-32, height: 320)
//                        )
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .transition(.offset(y: -geo.size.height/1.5))
//                    }
//                }
//                .animation(.smooth, value: self.vm.customFocuse)
