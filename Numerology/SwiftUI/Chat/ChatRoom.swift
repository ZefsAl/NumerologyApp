//
//  ChatRoom.swift
//  Numerology
//
//  Created by Serj_M1Pro on 04.06.2025.
//

import SwiftUI

struct ChatRoom: View {
    
    @StateObject var vm: ChatRoomVM
    @StateObject var sm: StarsManager
    @StateObject var cpm: ChatPaywallManager
    let expertModel: ExpertModel
    var closeAction: () -> Void
//    @Binding var stars: Int
    // @Published var showBuyNowBtn: Bool = false
    @State private var showBuyNowBtn: Bool = false
    @State private var customFocuse: Bool = false
    @State private var showExpertInfo: Bool = false
    @State private var clearHistoryAlert: Bool = false
    @State private var isPresented_Paywall: Bool = false
    
    init(
        expertModel: ExpertModel,
        sm: StarsManager,
        cpm: ChatPaywallManager,
        closeAction: @escaping () -> Void
    ) {
        self._vm = StateObject(wrappedValue: ChatRoomVM(expertModel: expertModel))
        self._cpm = StateObject(wrappedValue: cpm)
        
        
        
        self.expertModel = expertModel
        self._sm = StateObject(wrappedValue: sm)
        self.closeAction = closeAction
    }
    
    var body: some View {
        VStack {
            ChatView(
                streamingMessage: self.$vm.streamingMessage,
                isStreaming: self.$vm.isStreaming,
                // messages: self.$vm.messages, // all data - old
                messages: Binding(
                    get: { self.vm.messages.filter { $0.role != .system } },
                    set: { _ in /* Нечего устанавливать это делает sendMessage */ }),
                expertModel: expertModel,
                newMessage: self.$vm.newMessage,
                isLoading: self.$vm.isLoading,
                stars: self.$sm.userBalance,
                customFocuse: self.$customFocuse,
                showBuyNowBtn: self.$showBuyNowBtn,
                sendMessage: {
                    // TODO: - Restrict Action while Balance == 0
                    guard self.sm.userBalance > 0 else { return }
                    self.vm.sendMessage(onCompletion: {
                        // Допустим тут будет логика списания
                        self.sm.spentStars()
                        self.sm.getBalance()
                    })
                },
                buyNowAction: {
                    // TODO: - Show Paywall
                    self.isPresented_Paywall = true
                },
                header: {
                    VStack {
                        ChatExpertHeader(
                            expertModel: self.expertModel,
                            profileAction: {
                                withoutTransaction {
                                    self.showExpertInfo = true
                                }
                            },
                            closeAction: closeAction
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                }
            )
        }
//        .onAppear {
//            AnalyticsManager.shared.testEVENTs()
//        }
        .onDisappear {
            self.sm.getBalance()
        }
        .onReceive(self.sm.$userBalance, perform: { balcnce in
            self.showBuyNowBtn = balcnce <= 0
        })
        .overlay {
            if self.vm.messages.isEmpty && !self.customFocuse {
                FAQChipsSelectionView(onSelect: { self.vm.newMessage = $0 })
            }
        }
        // Expert Info
        .contentAlert(
            isPresented: self.$showExpertInfo,
            onBgTapDismiss: {},
            content: {
                VStack(spacing: 16) {
                    HStack {
                        ClearHistoryButton { self.clearHistoryAlert = true }
                        Spacer()
                        CloseCircleButton { self.showExpertInfo = false }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    // Card
                    ExpertCard(
                        model: self.expertModel,
                        frameSize: CGSize(
                            width: UIScreen.main.bounds.width-32,
                            height: UIScreen.main.bounds.height/1.8
                        )
                    )
                    .alert("The message history will be cleared.", isPresented: $clearHistoryAlert) {
                        Button("Close", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            self.vm.clearHistory()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                self.showExpertInfo = false
                            }
                        }
                    }
                }
            })
        // Paywall
        .fullScreenCover(isPresented: self.$isPresented_Paywall) {
            ChatPaywall(
                cpm: self.cpm,
                sm: self.sm
            )
        }
        
    }
}

#Preview {
    ChatRoom(
        expertModel: ExpertViewModel().expertsList[0],
        sm: StarsManager(),
        cpm: ChatPaywallManager(),
        closeAction: {}
    )
}
