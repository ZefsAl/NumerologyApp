//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 27.04.2025.
//

import Foundation
import RealmSwift

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case encodingFailed
    case networkError(Error? = nil)
    case httpError(Int)
    case decodingFailed
}

let apiKey_deepseek = "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"

class DeepSeekStreamingManager: NSObject {
//    private let apiKey = "your_api_key_here"
    private let baseURL = "https://openrouter.ai/api/v1/chat/completions"
    
    private var urlSession: URLSession!
    private var task: URLSessionDataTask?
    private var buffer = ""
    private var onTextReceived: ((String) -> Void)?
    private var onCompletion: ((Error?) -> Void)?
    
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    func streamMessage(messages: Results<MessageObj>,
                      onTextReceived: @escaping (String) -> Void,
                      onCompletion: @escaping (Error?) -> Void) {
        self.onTextReceived = onTextReceived
        self.onCompletion = onCompletion
        self.buffer = ""
        
        // 2. Преобразуем каждое сообщение в [String: Any]
        let messagesData: [[String: Any]] = Array(messages).map {
            ["role": $0.role.rawValue, "content": $0.content]
        }
        
        guard let url = URL(string: baseURL) else {
            onCompletion(NetworkError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey_deepseek)", forHTTPHeaderField: "Authorization")
        
        let requestBody: [String: Any?] = [
            "model": "deepseek/deepseek-chat:free",
            "messages": messagesData,
            "stream": true,
            "temperature": 0.7
        ]
        print(requestBody)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            onCompletion(error)
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
//            print("JSON parsing error:", error)
//            print("Problematic data:", dataString)
//        }
        guard let data = dataString.data(using: .utf8),
              dataString.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix("{") else {
            return
        }
        print("🔹 Received SSE data chunk: \(dataString)")
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            
            if let choices = json?["choices"] as? [[String: Any]],
               let delta = choices.first?["delta"] as? [String: Any],
               let content = delta["content"] as? String {
                onTextReceived?(content)
            }
        } catch {
            print("JSON parsing error:", error)
            print("Problematic data:", dataString)
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
        onCompletion?(error)
    }
}
