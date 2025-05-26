//
//  ChatView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 27.04.2025.
//

import Foundation
import SwiftUI
import RealmSwift


struct Message: Identifiable {
    //    var id: ObjectIdentifier
    
    let id: UUID = UUID()
    let role: Role
    var content: String
    var isStreaming: Bool
    
    mutating func addContent(_ newContent: String) {
        content += newContent
    }
}
//enum Roles: String {
//    case system
//    case user
//    case assistant
//}

struct ChatView: View {
    @ObservedResults(MessageObj.self) var messages
    @Environment(\.realm) var realm
//    @Environment(\.key) var realm
    
    var expertModel: ExpertModel
    //    @State private var messages: [Message] = []
    @State private var newMessage: String = ""
    @State private var isLoading: Bool = false
    @State private var streamingMessage: Message?
    @State var customFocuse: Bool = false
    private let streamingManager = DeepSeekStreamingManager()
    var closeAction: () -> Void
    
    @State private var dynamicHeight: CGFloat = 0
    
    
    var body: some View {
        //        let data = messages.filter {$0.role != .system} -- FIX
        
        // Messages list
        VStack(spacing: 0) {
            ChatExpertHeader(
                expertModel: self.expertModel,
                profileAction: {},
                closeAction: closeAction
            )
            .padding(.horizontal)
            HStack {
                Button("DeleteAll") {
                    try! realm.write {
                        realm.deleteAll()
                    }
                }
            }
            
            // Chat Liast
            GeometryReader { reader in
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        // v1
                        //                        LazyVStack(spacing: 12) {
                        //                            Spacer()
                        //                            ForEach(messages) { message in
                        //                                MessageView(message: message)
                        //                                    .id(message.uuid)
                        //                            }
                        //
                        //                            if let streamingMessage = streamingMessage {
                        //                                MessageView2(message: streamingMessage)
                        //                                    .id(streamingMessage.id)
                        //                            }
                        //                        }
                        //                        .padding(.horizontal)
                        //                        .frame(minHeight: reader.size.height, alignment: .bottom)
                        //                        .background(Color.orange)
                        
                        // v2
                        VStack(spacing: 0) {
//                            Spacer()
                            ForEach(messages) { message in
                                MessageView(message: message)
                                    .id(message.uuid)
                                    .padding(.bottom, 12)
                            }
                            
                            if let streamingMessage = streamingMessage {
                                MessageView2(message: streamingMessage)
                                    .id(streamingMessage.id)
                                    .padding(.bottom)
                            }
//                            Spacer().frame(height: 16)
                        }
                        .padding(.horizontal)
                        .frame(minHeight: reader.size.height, alignment: .bottom)
                        .rotationEffect(Angle(degrees: 180))
//                        .transition(.slide)
//                         .background(Color.orange)
                    }
                    .rotationEffect(Angle(degrees: 180))
                    // To bottom
                    .onChange(of: messages.count) { _ in
//                        self.scrollToBottom(proxy: proxy)
                    }
                    .onChange(of: streamingMessage?.content) { _ in
                        //                        self.scrollToBottom(proxy: proxy)
                    }
                    .onChange(of: self.customFocuse) { val in
                        print("self.customFocuse", self.customFocuse)
                        if val {
//                            self.scrollToBottom(proxy: proxy, delay: 0.4)
                        } else {
                            // self.scrollToBottom(proxy: proxy, delay: 0, isAnimated: false)
                        }
                    }
                    //                    .onAppear {
                    
                }
            } // GeometryReader
            // не плохо с keyboardToolbar
            .keyboardToolbar(height: self.$dynamicHeight) {
                ChatTextField(
                    enteredText: self.$newMessage,
                    stars: .constant(10),
                    isLoading: self.$isLoading,
                    dynamicHeight: self.$dynamicHeight,
                    customFocuse: $customFocuse,
                    font: DS.SourceSerifProFont.title_h4!,
                    buttonAction: {
                        self.sendMessage()
                        self.customFocuse = false
                    }
                )
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        } // ZStask
        .background { HoroscopeBG() }
        .onTapGesture {
            self.customFocuse = false
        }
        
    }
    
    
    private func addMessageToRealm(obj: MessageObj) {
        try! self.realm.write {
            self.realm.add(obj)
        }
    }
    
    private func sendMessage() {
        // prompt
        let prompt = MessageObj(role: .system, content: makePrompt_v2(model: self.expertModel), isStreaming: false)
        self.addMessageToRealm(obj: prompt)
        //        messages.append(prompt)
        // User
        let userMessage = MessageObj(role: .user, content: self.newMessage, isStreaming: false)
        self.addMessageToRealm(obj: userMessage)
        //        messages.append(userMessage)
        //
        isLoading = true
        // AI
        streamingMessage = Message(role: .assistant, content: "", isStreaming: true)
        
        newMessage = ""
        
        streamingManager.streamMessage(
            messages: messages,
            onTextReceived: { text in
                DispatchQueue.main.async {
                    streamingMessage?.addContent(text)
                }
            },
            onCompletion: { error in
                DispatchQueue.main.async {
                    isLoading = false
                    if var finalMessage = streamingMessage {
                        finalMessage.isStreaming = false
                        self.addMessageToRealm(obj: MessageObj(
                            role: finalMessage.role,
                            content: finalMessage.content,
                            isStreaming: finalMessage.isStreaming
                        ))
                        
                        //                        messages.append(finalMessage)
                    }
                    streamingMessage = nil
                    
                    if let error = error {
                        print("Streaming error:", error.localizedDescription)
                    }
                    self.streamingManager.cancelStreaming()
                }
            }
        )
    }
    
    private func scrollToBottom(
        proxy: ScrollViewProxy,
        delay: Double = .zero,
        isAnimated: Bool = true
    ) {
        switch isAnimated {
        case true:
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, qos: .userInitiated) {
                withAnimation(.smooth(duration: 0.3)) {
                    if let lastId = streamingMessage?.id ?? messages.last?.uuid {
                        proxy.scrollTo(lastId, anchor: .bottom)
                    }
                }
            }
        case false:
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, qos: .userInitiated) {
                if let lastId = streamingMessage?.id ?? messages.last?.uuid {
                    proxy.scrollTo(lastId, anchor: .bottom)
                }
            }
        }
        
    }
}

struct MessageView: View {
    let message: MessageObj
    let bgColor: Color
    
    init(message: MessageObj) {
        self.message = message
        self.bgColor = switch message.role {
        case .system:
            Color.black
        case .user:
            Color.blue
        case .assistant:
            Color.gray
        }
    }
    
    var body: some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            
            Text(message.content)
                .padding(10)
                .background(self.bgColor)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            if message.role == .assistant {
                Spacer()
            }
        }
    }
}

struct MessageView2: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            
            Text(message.content)
                .padding(10)
                .background(message.role == .user ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            if message.role == .assistant {
                Spacer()
            }
        }
    }
}


#Preview {
    ChatView(expertModel: ExpertViewModel().expertsList[0], closeAction: {})
}

func makePrompt_v2(
//    name: String = "Lisa",
//    profession: String = "Astrologer",
//    expirience: Int = 6,
//    country: String = "US"
    
    model: ExpertModel
) -> String {
    return """
    1. Remember, you are a professional \(model.profession), with \(model.expirience) years of experience, your name is \(model.fl_Name), you \(model.age) years old, you live in \(model.country). 
    2. If suddenly you are asked whether you are a BOT or an AI? 
    3. Do not answer questions related to (politics, medicine, wars) or avoid! 
    4. Answer the user with kindness and involvement.
"""
}


func makePrompt(
    name: String = "Lisa",
    profession: String = "Astrologer",
    expirience: Int = 6,
    country: String = "US"
) -> String {
    return """
    1. Remember, you are a professional \(profession), with \(expirience) years of experience, your name is \(name), you \(32) years old, you live in \(country). 
    2. If suddenly you are asked whether you are a BOT or an AI? Do not admit that you are \(name) 
    3. Do not answer questions related to (politics, medicine, wars) or avoid! 
    4. Answer the user with kindness and involvement.
"""
}



