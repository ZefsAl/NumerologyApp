//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 27.04.2025.
//

import Foundation


//curl https://api.deepseek.com/chat/completions \
//  -H "Content-Type: application/json" \
//  -H "Authorization: Bearer <DeepSeek API Key>" \
//  -d '{
//        "model": "deepseek-chat",
//        "messages": [
//          {"role": "system", "content": "You are a helpful assistant."},
//          {"role": "user", "content": "Hello!"}
//        ],
//        "stream": false
//      }'


enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case encodingFailed
    case networkError(Error? = nil)
    case httpError(Int)
    case decodingFailed
}

// deepseek/deepseek-chat:free
// let apiKey_deepseek = "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" // v5
let apiKey_deepseek = "sk-d6afd4027ef5409fa9aa5c203fad0ce0" // Numerology1

class DeepSeekStreamingManager: NSObject {
    
    // v5
    //private let baseURL = "https://openrouter.ai/api/v1/chat/completions" // v5
    // private let model = "deepseek/deepseek-chat-v3-0324:free" // v5
    //
    //    "model": "deepseek/deepseek-chat-v3-0324:free",
    //    private let baseURL = "https://openrouter.ai/api/v1"
    
    
    
    // Numerology1
    private let baseURL = "https://api.deepseek.com/chat/completions"
    private let model = "deepseek-chat"
    
    
    private var urlSession: URLSession!
    private var task: URLSessionDataTask?
    private var buffer = ""
    private var onTextReceived: ((String) -> Void)?
    
    
    private var onCompletion: ((Error?) -> Void)?
    
//    var answer_language: String { Locale.current.languageCode ?? "auto" }
    
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    
    func streamMessage(
        messages: [MessageObject],
        max_tokens: Int? = nil,
        onTextReceived: @escaping (String) -> Void,
        onCompletion: @escaping (Error?) -> Void
    ) {
        print("START - streamMessage")
        // Realm - @ObservedResults(MessageObject.self) var messages
        //    func streamMessage(messages: Results<MessageObj>,
        //                      onTextReceived: @escaping (String) -> Void,
        //                      onCompletion: @escaping (Error?) -> Void) {
        self.onTextReceived = onTextReceived
        self.onCompletion = onCompletion
        self.buffer = ""
        
        // 2. Преобразуем каждое сообщение в [String: Any] - Realm
        //        let messagesData: [[String: Any]] = Array(messages).map {
        //            ["role": $0.role.rawValue, "content": $0.content]
        //        }
        
        
        let messagesData: [[String: Any]] = messages.map {
            ["role": $0.role.rawValue, "content": $0.content]
        }

        print("🔸 - messagesData", messagesData)
        
        guard let url = URL(string: baseURL) else {
            onCompletion(NetworkError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey_deepseek)", forHTTPHeaderField: "Authorization")
        
        var requestBody: [String: Any?] = [
            "model": self.model,
            "messages": messagesData,
            "stream": true,
//            "language": self.answer_language,
            "temperature": 0.3 // 0.7
//            "max_tokens": 500
            // для этой апи не работает
            // "frequency_penalty": 1.5, // Штрафует частые символы (*,#)
            // "presence_penalty": 0.8,  // Штрафует появление новых символов
            // "stop": ["**", "###"]     // Явный запрет
        ]
        if let max_tokens {
            requestBody["max_tokens"] = max_tokens
        }
        myPrint("🔹",requestBody)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            onCompletion(error)
            myPrint("❌ Error httpBody - serializing JSON")
            return
        }
        
        task = urlSession.dataTask(with: request)
        task?.resume()
    }
    
    private func processReceivedData(_ data: Data) {
        guard let string = String(data: data, encoding: .utf8) else { return }
        buffer += string
        
        // Обрабатываем строки формата SSE (Server-Sent Events)
        let eventSeparator = "\n\n"
        let events = buffer.components(separatedBy: eventSeparator)
        
        // Оставляем неполное событие в буфере
        buffer = events.last ?? ""
        
        for event in events.dropLast() {
            processEvent(event)
        }
    }
    
    private func processEvent(_ event: String) {
        guard !event.isEmpty else { return }
        
        // Разбираем строку события SSE
        var eventData: String?
        var eventType: String?
        
        for line in event.components(separatedBy: "\n") {
            if line.hasPrefix("data: ") {
                eventData = String(line.dropFirst(6))
            } else if line.hasPrefix("event: ") {
                eventType = String(line.dropFirst(7))
            }
        }
        

        // Обрабатываем только события с данными
        guard let dataString = eventData, !dataString.isEmpty else { return }
        
        // Проверяем на [DONE] - специальный маркер завершения
        if dataString == "[DONE]" {
            myPrint("🔹✅ - DONE", dataString)
            onCompletion?(nil)
            return
        }
        
        // Парсим JSON
//        guard let data = dataString.data(using: .utf8) else { return }
//
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
        
        myPrint("🔹 Received SSE data chunk: \(dataString)")
        guard let data = dataString.data(using: .utf8),
              dataString.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("{") else {
            return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            
            if let choices = json?["choices"] as? [[String: Any]],
               let delta = choices.first?["delta"] as? [String: Any],
               let content = delta["content"] as? String {
                onTextReceived?(content)
            }
        } catch {
            myPrint("❌ JSON parsing error:", error)
            myPrint("❌ Problematic data:", dataString)
        }
    }
    
    func cancelStreaming() {
        task?.cancel()
        task = nil
    }
}

extension DeepSeekStreamingManager: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        processReceivedData(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error { onCompletion?(error) }
    }
}
