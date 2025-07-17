//
//  ChatVM.swift
//  Numerology
//
//  Created by Serj_M1Pro on 16.06.2025.
//

import Foundation
import RealmSwift


/// - храним все в перемешку но при получаем фильтруя по obj.chatID и датам
/// - View отобразит только тип Message
/// - Но храним как MessageObject

class ChatRoomVM: ObservableObject {
    
    @Published var streamingMessage: String? = nil
    @Published var isStreaming: Bool = false
    /// Для UI 
    @Published var messages: [MessageObject] = []
    @Published var newMessage: String = ""
    @Published var isLoading: Bool = false
    
    private var realm: Realm
    private var expertModel: ExpertModel
    private let streamingManager = DeepSeekStreamingManager()
    
    /// Для хранения токена подписки на уведомления Realm
    private var notificationToken: NotificationToken?
    
    // MARK: - init
    init(expertModel: ExpertModel) {
        let config = Realm.Configuration(objectTypes: [MessageObject.self])
        self.realm = try! Realm(configuration: config)
        self.expertModel = expertModel
        self.fillData_view()
    }
    
    // MARK: - get Realm Results
    /// для получения актуальных данных раньше observe
    var getRealmResults: Results<MessageObject> {
        return realm.objects(MessageObject.self)
            .filter("chatID == %@", expertModel.chatID)
            // .filter("role != %@", "system") // не так
            .sorted(byKeyPath: "date", ascending: true)
    }
    
    
    // MARK: - private func fillData_view
    private func fillData_view() {
        self.messages = Array(self.getRealmResults)
        
        // Подписываемся на уведомления об изменениях
        notificationToken = self.getRealmResults.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(let initial):
                print("🔶 initial")
                // Первый раз: уже взяли выше, но можно обновить снова
                self.messages = Array(initial)
            case .update(let updatedResults, _, _, _):
                print("🔶 update")
                // При каждом изменении Realm обновляем массив
                self.messages = Array(updatedResults)
            case .error(let error):
                // Обработка ошибок подписки
                myPrint("❌ Realm notification error:", error)
            }
        }
    }
    
    // MARK: - add Message To Realm
    private func addMessageToRealm(obj: MessageObject) {
        try! self.realm.write {
            self.realm.add(obj, update: .modified)
        }
    }
    
    func clearHistory() {
        let toDelete = realm.objects(MessageObject.self)
            .filter("chatID == %@", self.expertModel.chatID)
        // Сначала очистить UI-массив
        self.messages.removeAll()
        // Затем удалить из Realm
        try! realm.write {
            realm.delete(toDelete)
        }
    }
    
    
    func sendMessage(onCompletion: @escaping () -> Void) {
        
        self.isLoading = true
        // prompt
        let prompt = MessageObject(chatID: self.expertModel.chatID, date: Date(), role: .system, content: ExpertViewModel.makePrompt3(self.expertModel))
        
        // Check add
        if self.getRealmResults.isEmpty && !self.getRealmResults.contains(where: { $0.role == .system }) {
            self.addMessageToRealm(obj: prompt)
        }
        
        // User
        let userMessage = MessageObject(chatID: self.expertModel.chatID, date: Date(), role: .user, content: newMessage)
        // v2
        self.addMessageToRealm(obj: userMessage)

        // AI
        self.isStreaming = true
        self.streamingMessage = ""
        // clear state
        self.newMessage = ""
        
        // Get specific messages
        let getPrompt = getRealmResults.first { $0.role == .system } ?? prompt
        let secondary_messages = getRealmResults.filter { $0.role != .system && $0 != getPrompt }.suffix(6)
        let someMessages = [getPrompt] + secondary_messages
        
        // print("🔸someMessages🔸", someMessages, someMessages.count)
        
        
        streamingManager.streamMessage(
            messages: someMessages, // тут можно отфильтровать 3 последних например
            onTextReceived: { text in
                DispatchQueue.main.async {
                    self.streamingMessage! += text
                }
            },
            onCompletion: { error in
                DispatchQueue.main.async {
                    if let finalMessage = self.streamingMessage {
                        self.addMessageToRealm(obj: MessageObject(
                            chatID: self.expertModel.chatID,
                            date: Date(),
                            role: .assistant,
                            content: finalMessage)
                        )
                    }
                    self.isStreaming = false
                    self.streamingMessage = nil
                    
                    if let error = error {
                        myPrint("❌⚠️ Streaming error:", error.localizedDescription)
                    }
                    self.streamingManager.cancelStreaming()
                    self.isLoading = false
                    onCompletion()
                }
            }
        )
        
        
    }
}

