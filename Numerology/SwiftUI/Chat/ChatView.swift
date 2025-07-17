//
//  ChatView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 27.04.2025.
//

import Foundation
import SwiftUI
import RealmSwift


//struct Message: Identifiable {
//    let id: UUID = UUID()
//    let role: Roles
//    var content: String
//    var date: Date
//    var isStreaming: Bool
//    
//    mutating func addContent(_ newContent: String) {
//        content += newContent
//    }
//}
//enum Roles: String {
//    case system
//    case user
//    case assistant
//}




// TODO: - Хочу что бы ChatView не зависил от данных т.к планирую использовать просто тип Message или MessageObj

struct ChatView<Header: View>: View {
    
    @Binding var streamingMessage: String?
    @Binding var isStreaming: Bool
    @Binding var messages: [MessageObject]
    var expertModel: ExpertModel
    
    @Binding var newMessage: String
    @Binding var isLoading: Bool
    
    @Binding var stars: Int
    @Binding var customFocuse: Bool
    var showBuyNowBtn: Binding<Bool> = .constant(false)
    var sendMessage: (() -> Void)
    var buyNowAction: (() -> Void)?
    
    @ViewBuilder var header: () -> Header
    
//    init(
//        streamingMessage: Binding<String?>,
//        messages: Binding<[MessageObject]>,
//        expertModel: ExpertModel,
//        newMessage: Binding<String>,
//        isLoading: Binding<Bool>,
//        stars: Binding<Int>,
//        customFocuse: Binding<Bool>,
//        showBuyNowBtn: Binding<Bool> = .constant(false),
//        sendMessage: @escaping () -> Void,
//        buyNowAction: (() -> Void)? = nil,
//        @ViewBuilder emptyStateContent: () -> EmptyStateContent? = { EmptyView() }
//    ) {
//        self._streamingMessage = streamingMessage
//        self._messages = messages
//        self.expertModel = expertModel
//        self._newMessage = newMessage
//        self._isLoading = isLoading
//        self._stars = stars
//        self._customFocuse = customFocuse
//        self.showBuyNowBtn = showBuyNowBtn
//        self.sendMessage = sendMessage
//        self.buyNowAction = buyNowAction
//        self.emptyStateContent = emptyStateContent()
//    }
    
    // private
    @State private var dynamicHeight: CGFloat = 0
    
    
    var body: some View {
        //        let data = messages.filter {$0.role != .system} -- FIX
        
        // Messages list
        VStack(spacing: 0) {
            self.header()
            // Chat List
            GeometryReader { reader in
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        // v2
                        VStack(spacing: 0) {
                            ForEach(messages) { message in
                                MessageView2(message: message)
                                    // .id(message.id)
                                    .padding(.bottom, 12)
                            }
                            if let _ = streamingMessage {
                                MessageView2(
                                    streamingMessage: self.$streamingMessage,
                                    isStreaming: self.$isStreaming)
                                    // .id(streamingMessage.id)
                                    .padding(.bottom)
                            }
                        }
                        .padding(.horizontal)
                        .frame(minHeight: reader.size.height, alignment: .bottom)
                        .rotationEffect(Angle(degrees: 180))
                    }
                    .rotationEffect(Angle(degrees: 180))
                    // To bottom
                    // .onChange(of: messages.count) { _ in
                    // self.scrollToBottom(proxy: proxy)
                    // }
                    // .onChange(of: streamingMessage?.content) { _ in
                    // self.scrollToBottom(proxy: proxy)
                    // }
                    // .onChange(of: self.customFocuse) { val in
                    //   myPrint("self.customFocuse", self.customFocuse)
                    //  if val {
                    // self.scrollToBottom(proxy: proxy, delay: 0.4)
                    //} else {
                    // self.scrollToBottom(proxy: proxy, delay: 0, isAnimated: false)
                    // }
                    // }
                    
                }
            } // GeometryReader
            // не плохо с keyboardToolbar
            .keyboardToolbar(height: self.$dynamicHeight) {
                VStack {
                    if self.showBuyNowBtn.wrappedValue {
                        BigButton(
                            title: "Chat Now",
                            action: { if let buyNowAction { buyNowAction() }},
                            trailingContent: {
                                Image("SendArrow")
                            })
                    } else {
                        ChatTextField(
                            enteredText: self.$newMessage,
                            stars: self.$stars,
                            isLoading: self.$isLoading,
                            dynamicHeight: self.$dynamicHeight,
                            customFocuse: $customFocuse,
                            font: DS.SourceSerifProFont.title_h4!,
                            buttonAction: {
                                self.sendMessage()
                                self.customFocuse = false
                            }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        } // ZStask
        .background { HoroscopeBG() }
        .onTapGesture {
            self.customFocuse = false
        }
        // Custom Context menu
//        .overlay {
//            ZStack {
//                ScrollView {
//                    VStack {
//
//                    }
//                }
//            }
//            .ignoresSafeArea(.all)
//        }
        
    }
    
    

    
//    private func sendMessage() {
//        // prompt
//        let prompt = Message(role: .system, content: (model: self.expertModel), date: Date(), isStreaming: false)
////        self.addMessageToRealm(obj: prompt)
//                messages.append(prompt)
//        // User
//        let userMessage = Message(role: .user, content: self.newMessage, date: Date(), isStreaming: false)
////        MessageObj(role: .user, content: self.newMessage, isStreaming: false)
//        // v2
////        self.addMessageToRealm(obj: userMessage)
//        // v1
//        messages.append(userMessage)
//        //
//        isLoading = true
//        // AI
//        streamingMessage = Message(role: .assistant, content: "", date: Date(), isStreaming: true)
//        
//        newMessage = ""
//        
//        streamingManager.streamMessage(
//            messages: messages,
//            onTextReceived: { text in
//                DispatchQueue.main.async {
//                    streamingMessage?.addContent(text)
//                }
//            },
//            onCompletion: { error in
//                DispatchQueue.main.async {
//                    isLoading = false
//                    if var finalMessage = streamingMessage {
//                        finalMessage.isStreaming = false
////                        self.addMessageToRealm(obj: MessageObj(
////                            role: finalMessage.role,
////                            content: finalMessage.content,
////                            isStreaming: finalMessage.isStreaming
////                        ))
//                        
//                        
//                        // TODO: - Учесть когда ии не прислал ответ
//                        // TODO: - decrease stars
//                        if self.stars != 0 {
//                            self.stars -= 1
//                        }
//                        messages.append(finalMessage)
//                        
//                        
//                    }
//                    streamingMessage = nil
//                    
//                    if let error = error {
//                        myPrint("❌⚠️ Streaming error:", error.localizedDescription)
//                    }
//                    self.streamingManager.cancelStreaming()
//                }
//            }
//        )
//    }
    
//    private func scrollToBottom(
//        proxy: ScrollViewProxy,
//        delay: Double = .zero,
//        isAnimated: Bool = true
//    ) {
//        switch isAnimated {
//        case true:
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay, qos: .userInitiated) {
//                withAnimation(.smooth(duration: 0.3)) {
//                    if let lastId = streamingMessage?.uuid ?? messages.last?.uuid {
//                        proxy.scrollTo(lastId, anchor: .bottom)
//                    }
//                }
//            }
//        case false:
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay, qos: .userInitiated) {
//                if let lastId = streamingMessage?.uuid ?? messages.last?.uuid {
//                    proxy.scrollTo(lastId, anchor: .bottom)
//                }
//            }
//        }
//    }
}

//struct MessageView: View {
//    let message: MessageObj
//    let bgColor: Color
//    
//    init(message: MessageObj) {
//        self.message = message
//        self.bgColor = switch message.role {
//        case .system:
//            Color.black
//        case .user:
//            Color.blue
//        case .assistant:
//            Color.gray
//        }
//    }
//    
//    var body: some View {
//        HStack {
//            if message.role == .user {
//                Spacer()
//            }
//            
//            Text(message.content)
//                .padding(10)
//                .background(self.bgColor)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            
//            if message.role == .assistant {
//                Spacer()
//            }
//        }
//    }
//}


struct ChatView_TESTPREVIEW: View {
    
    @StateObject var chatVM = ChatRoomVM(expertModel: ExpertViewModel().expertsList[0])
//    @State var streamingMessage: MessageObject? = nil
//    @State var messages: [MessageObject] = []
    
    var body: some View {
        ChatView(
            streamingMessage: self.$chatVM.streamingMessage,
            isStreaming: self.$chatVM.isStreaming,
            messages: self.$chatVM.messages,
            expertModel: ExpertViewModel().expertsList[0],
            newMessage: self.$chatVM.newMessage,
            isLoading: self.$chatVM.isLoading,
            stars: .constant(10),
            customFocuse: .constant(false),
            sendMessage: {},
            header: { Text("Header!") }
        )
    }
}
#Preview {
    ChatView_TESTPREVIEW()
}



