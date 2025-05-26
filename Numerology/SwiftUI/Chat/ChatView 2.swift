////
////  ChatView.swift
////  Numerology
////
////  Created by Serj_M1Pro on 27.04.2025.
////
//
//import Foundation
//import SwiftUI
//import RealmSwift
//
//let apiKey_deepseek = "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"
//
//class DeepSeekStreamingManager: NSObject {
////    private let apiKey = "your_api_key_here"
//    private let baseURL = "https://openrouter.ai/api/v1/chat/completions"
//    
//    private var urlSession: URLSession!
//    private var task: URLSessionDataTask?
//    private var buffer = ""
//    private var onTextReceived: ((String) -> Void)?
//    private var onCompletion: ((Error?) -> Void)?
//    
//    override init() {
//        super.init()
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 60
//        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
//    }
//    
//    func streamMessage(messages: Results<MessageObj>,
//                      onTextReceived: @escaping (String) -> Void,
//                      onCompletion: @escaping (Error?) -> Void) {
//        self.onTextReceived = onTextReceived
//        self.onCompletion = onCompletion
//        self.buffer = ""
//        
//        guard let url = URL(string: baseURL) else {
//            onCompletion(NetworkError.invalidURL)
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(apiKey_deepseek)", forHTTPHeaderField: "Authorization")
//        
//        let requestBody: [String: Any] = [
//            "model": "deepseek/deepseek-chat:free",
//            "messages": messages.map {
//                ["role": $0.role.rawValue, "content": $0.content]
//            },
//            "stream": true,
//            "temperature": 0.7
//        ]
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
//        } catch {
//            onCompletion(error)
//            return
//        }
//        
//        task = urlSession.dataTask(with: request)
//        task?.resume()
//    }
//    
//    private func processReceivedData(_ data: Data) {
//        guard let string = String(data: data, encoding: .utf8) else { return }
//        buffer += string
//        
//        // Обрабатываем строки формата SSE (Server-Sent Events)
//        let eventSeparator = "\n\n"
//        let events = buffer.components(separatedBy: eventSeparator)
//        
//        // Оставляем неполное событие в буфере
//        buffer = events.last ?? ""
//        
//        for event in events.dropLast() {
//            processEvent(event)
//        }
//    }
//    
//    private func processEvent(_ event: String) {
//        guard !event.isEmpty else { return }
//        
//        // Разбираем строку события SSE
//        var eventData: String?
//        var eventType: String?
//        
//        for line in event.components(separatedBy: "\n") {
//            if line.hasPrefix("data: ") {
//                eventData = String(line.dropFirst(6))
//            } else if line.hasPrefix("event: ") {
//                eventType = String(line.dropFirst(7))
//            }
//        }
//        
//        // Обрабатываем только события с данными
//        guard let dataString = eventData, !dataString.isEmpty else { return }
//        
//        // Проверяем на [DONE] - специальный маркер завершения
//        if dataString == "[DONE]" {
//            onCompletion?(nil)
//            return
//        }
//        
//        // Парсим JSON
////        guard let data = dataString.data(using: .utf8) else { return }
////
////        do {
////            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
////
////            if let choices = json?["choices"] as? [[String: Any]],
////               let delta = choices.first?["delta"] as? [String: Any],
////               let content = delta["content"] as? String {
////                onTextReceived?(content)
////            }
////        } catch {
////            print("JSON parsing error:", error)
////            print("Problematic data:", dataString)
////        }
//        guard let data = dataString.data(using: .utf8),
//              dataString.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("{") else {
//            return
//        }
//        print("🔹 Received SSE data chunk: \(dataString)")
//        do {
//            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//            
//            if let choices = json?["choices"] as? [[String: Any]],
//               let delta = choices.first?["delta"] as? [String: Any],
//               let content = delta["content"] as? String {
//                onTextReceived?(content)
//            }
//        } catch {
//            print("JSON parsing error:", error)
//            print("Problematic data:", dataString)
//        }
//    }
//    
//    func cancelStreaming() {
//        task?.cancel()
//        task = nil
//    }
//}
//
//extension DeepSeekStreamingManager: URLSessionDataDelegate {
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        processReceivedData(data)
//    }
//    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        onCompletion?(error)
//    }
//}
//
//
//
//struct ChatView_v2: View {
//    let selectedPrompt: String
//    
//    @ObservedResults(MessageObj.self) var messages
//    @Environment(\.realm) var realm
////    @State private var messages: [MessageObj] = []
////    @StateObject var rm = RealmManager()
//    
//    @State private var newMessage: String = ""
//    @State private var isLoading: Bool = false
//    @State private var streamingMessage: MessageObj?
//    
//    private let streamingManager = DeepSeekStreamingManager()
//    
//    var body: some View {
////        let data = messages.filter {$0.role != .system}
//        // Messages list
//        VStack {
//            ScrollViewReader { proxy in
//                ScrollView {
//                    LazyVStack(spacing: 12) {
//                        ForEach(self.messages) { message in
//                            MessageView(message: message)
//                        }
//                        
//                        if let streamingMessage = streamingMessage {
//                            MessageView(message: streamingMessage)
//                        }
//                    }
//                    .padding()
//                    .frame(alignment: .bottom)
//                }
//                .onChange(of: self.messages.count) { _ in
//                    scrollToBottom(proxy: proxy)
//                }
//                .onChange(of: streamingMessage?.content) { _ in
//                    scrollToBottom(proxy: proxy)
//                }
//            }
//            .background(Color.brown)
//            
//            // Text Field
//            HStack {
//                TextField("Type a message...", text: $newMessage)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .disabled(isLoading)
//                
//                Button(action: sendMessage) {
//                    Image(systemName: "paperplane.fill")
//                }
//                .disabled(newMessage.isEmpty || isLoading)
//            }
//            .padding()
//        }
//    }
//    
//    private func sendMessage() {
//        
//        // system
//        let prompt = MessageObj(role: .system, content: self.selectedPrompt, isStreaming: false)
//        try! self.realm.write {
//            self.realm.add(prompt)
//        }
////        messages.append(prompt)
//        // User
//        let userMessage = MessageObj(role: .user, content: self.newMessage, isStreaming: false)
////        messages.append(userMessage)
//        try! self.realm.write {
//            self.realm.add(userMessage)
//        }
//        //
//        isLoading = true
//        // assistant
//        streamingMessage = MessageObj(role: .assistant, content: "", isStreaming: true)
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
//                    if let finalMessage = streamingMessage {
//                        finalMessage.isStreaming = false
//                        //                        messages.append(finalMessage)
//                        try! self.realm.write {
//                            self.realm.add(finalMessage)
//                        }
//                    }
//                    streamingMessage = nil
//                    
//                    if let error = error {
//                        print("Streaming error:", error.localizedDescription)
//                    }
//                }
//            }
//        )
//    }
//    
//    private func scrollToBottom(proxy: ScrollViewProxy) {
//        DispatchQueue.main.async {
//            withAnimation {
//                if let lastId = streamingMessage?._id ?? messages.last?._id {
//                    proxy.scrollTo(lastId, anchor: .bottom)
//                }
//            }
//        }
//    }
//}
//
//struct MessageView: View {
//    let message: MessageObj
//    
//    var body: some View {
//        HStack {
//            if message.role == .user {
//                Spacer()
//            }
//            
//            Text(message.content)
//                .padding(10)
//                .background(message.role == .user ? Color.blue : Color.gray)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            
//            if message.role == .assistant {
//                Spacer()
//            }
//        }
//    }
//}
//
//
//#Preview {
//    ChatView_v2(selectedPrompt: makePrompt())
//}
//
//func makePrompt(
//    name: String = "Lisa",
//    profession: String = "Astrologer",
//    expirience: Int = 6,
//    country: String = "US"
//) -> String {
//    return """
//    1. Remember, you are a professional \(profession), with \(expirience) years of experience, your name is \(name), you \(32) years old, you live in \(country). 
//    2. If suddenly you are asked whether you are a BOT or an AI? Do not admit that you are \(name) 
//    3. Do not answer questions related to (politics, medicine, wars) or avoid! 
//    4. Answer the user with kindness and involvement.
//"""
//}
//
//
//
//enum NetworkError: Error {
//    case invalidURL
//    case noData
//    case invalidResponse
//    case encodingFailed
//    case networkError(Error? = nil)
//    case httpError(Int)
//    case decodingFailed
//    
//}
//
