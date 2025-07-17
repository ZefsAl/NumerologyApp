////
////  ChatView.swift
////  Numerology
////
////  Created by Serj_M1Pro on 27.04.2025.
////
//
//import Foundation
//import SwiftUI
//
//enum NetworkError: Error {
//    case invalidURL
//    case noData
//    case invalidResponse
//    case encodingFailed
//    case networkError(Error? = nil)
//    case httpError(Int)
//    case decodingFailed
//}
//
//struct Message: Identifiable {
//    let id = UUID()
//    let role: Roles
//    var content: String
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
//
//let apiKey_deepseek = "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"
//
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
//    func streamMessage(messages: [Message],
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
////            myPrint("JSON parsing error:", error)
////            myPrint("Problematic data:", dataString)
////        }
//        guard let data = dataString.data(using: .utf8),
//              dataString.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("{") else {
//            return
//        }
//        myPrint("🔹 Received SSE data chunk: \(dataString)")
//        do {
//            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//            
//            if let choices = json?["choices"] as? [[String: Any]],
//               let delta = choices.first?["delta"] as? [String: Any],
//               let content = delta["content"] as? String {
//                onTextReceived?(content)
//            }
//        } catch {
//            myPrint("JSON parsing error:", error)
//            myPrint("Problematic data:", dataString)
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
//    @State private var messages: [Message] = []
//    @State private var newMessage: String = ""
//    @State private var isLoading: Bool = false
//    @State private var streamingMessage: Message?
//    
//    private let streamingManager = DeepSeekStreamingManager()
//    
//    var body: some View {
////        let data = messages.filter {$0.role != .system} -- FIX
//        
//        // Messages list
//        VStack {
//            // Chat Liast
//            GeometryReader { reader in
//                ScrollViewReader { proxy in
//                    ScrollView(.vertical) {
//                        LazyVStack(spacing: 12) {
//                            Spacer()
//                            ForEach(messages) { message in
//                                MessageView(message: message)
//                                    .id(message.id)
//                            }
//                            
//                            if let streamingMessage = streamingMessage {
//                                MessageView(message: streamingMessage)
//                                    .id(streamingMessage.id)
//                            }
//                        }
//                        .padding()
//                        .frame(minHeight: reader.size.height, alignment: .bottom)
//                        .background(Color.orange)
//                        
//                    }
//                    .onChange(of: messages.count) { _ in
//                        scrollToBottom(proxy: proxy)
//                    }
//                    .onChange(of: streamingMessage?.content) { _ in
//                        scrollToBottom(proxy: proxy)
//                    }
//                }
//                .background(Color.brown)
//            }
//            // TEST
//            .onAppear {
////                for val in 0...12 {
////                    if val % 2 == 0 {
////                        self.messages.append(Message(role: .assistant, content: "Designed for Offline Use: Realm’s local database persists data on-disk, so apps work as well offline as they do online.", isStreaming: false))
////                    } else {
////                        self.messages.append(Message(role: .user, content: "Designed for Offline Use: Realm’s local database persists data on-disk, so apps work as well offline as they do online.", isStreaming: false))
////                    }
////                }
//            }
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
//        // prompt
//        let prompt = Message(role: .system, content: self.selectedPrompt, isStreaming: false)
//        messages.append(prompt)
//        // User
//        let userMessage = Message(role: .user, content: self.newMessage, isStreaming: false)
//        messages.append(userMessage)
//        //
//        isLoading = true
//        // AI
//        streamingMessage = Message(role: .assistant, content: "", isStreaming: true)
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
//                        messages.append(finalMessage)
//                    }
//                    streamingMessage = nil
//                    
//                    if let error = error {
//                        myPrint("Streaming error:", error.localizedDescription)
//                    }
//                    self.streamingManager.cancelStreaming()
//                }
//            }
//        )
//    }
//    
//    private func scrollToBottom(proxy: ScrollViewProxy) {
//        DispatchQueue.main.async {
//            withAnimation {
//                if let lastId = streamingMessage?.id ?? messages.last?.id {
//                    proxy.scrollTo(lastId, anchor: .bottom)
//                }
//            }
//        }
//    }
//}
//
//struct MessageView: View {
//    let message: Message
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
//    ChatView_v2(selectedPrompt: )
//}
