//
//  ChatOfferVM.swift
//  Numerology
//
//  Created by Serj_M1Pro on 04.06.2025.
//

import Foundation


// TODO: - Восстановить Realm
// TODO: - Восстановить Realm



class ChatOfferVM: ObservableObject {
    
    
    
    @Published var streamingMessage: String?
    @Published var isStreaming: Bool = false
    @Published var messages: [MessageObject] = []
    @Published var customFocuse: Bool = false
    @Published var showBuyNowBtn: Bool = false
    @Published var stars: Int = 1
    @Published var newMessage: String = ""
    @Published var isLoading: Bool = false
    
    let expertModel: ExpertModel = ExpertViewModel().expertsList[0]
    private let streamingManager = DeepSeekStreamingManager()
    
    // @Published var name: String? = UserDataKvoManager.shared.name
    // @Published var surname: String? = UserDataKvoManager.shared.surname
    // @Published var dateOfBirth: Date? = UserDataKvoManager.shared.dateOfBirth
    
    
    
    // MARK: - TODO
    // 1. Получение данных о пользователе
    // 2. helloMessage - Первое сообщение при открытии
    // 3. offerMessage - AI - Последнее сообщение
    // 4. Открыть Paywall
    
    // MARK: - add Hello Message
    func addHelloMessage() {
        
        let name = UserDefaults.standard.string(forKey: UserDefaultsKeys.name) ?? ""
        // dateOfBirth
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date ?? Date()
        // User Sign
        let sign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
        
        let emoji: String = HoroscopeSign.shared.zodiacEmojis[sign] ?? ""
        
        let content = "Hi \(name), \(setDateFormat(date: dateOfBirth)), \(sign)\(emoji) I’m your personal astrologer. Just ask me anything to uncover deep truths about yourself! 🌌✨ "
        
        self.streamingMessage = ""
        self.isStreaming = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.messages.append(MessageObject(date: Date(), role: .assistant, content: content))
            self.streamingMessage = nil
            self.isStreaming = false
        }
    }
    
    func sendMessage() {
        // prompt
        let prompt = MessageObject(date: Date(), role: .system, content: ExpertViewModel.makePrompt(self.expertModel, withConversionEnd: true))
        messages.append(prompt)
        // User
        let userMessage = MessageObject(date: Date(), role: .user, content: self.newMessage)
        messages.append(userMessage)
        //
        isLoading = true
        // AI
        self.isStreaming = true
        streamingMessage = ""
        newMessage = ""
        
        streamingManager.streamMessage(
            messages: messages,
            max_tokens: 400,
            onTextReceived: { text in
                DispatchQueue.main.async {
                    self.streamingMessage! += text
                }
            },
            onCompletion: { error in
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    if let finalMessage = self.streamingMessage {
                        self.messages.append(MessageObject(
                            chatID: self.expertModel.chatID,
                            date: Date(),
                            role: .assistant,
                            content: finalMessage)
                        )
                        self.streamingMessage = nil
                        self.isStreaming = false
                        self.streamingManager.cancelStreaming()
                        if self.stars != 0 {
                            self.stars -= 1
                        }
                    }

                    if let error = error {
                        myPrint("❌⚠️ Streaming error:", error.localizedDescription)
                    }
                }
            }
        )
        AnalyticsManager.shared.userAskAstrologer_Facebook()
        AnalyticsManager.shared.userAskAstrologer_FIB()
        
    }
    
    
    
    
    
}


