//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.10.2024.
//

import Foundation

class PremiumTextManager: ObservableObject {
    @Published var data: String? = ""
    @Published var isPremium: Bool = false
    
    private let visibleWords = 10
    
    enum PremiumContentType {
        case free,premium
    }
    
    func getPremiumText(_ type: PremiumContentType) -> String? {
        guard let data = data else { return data }
        let strPrefixArr = data.components(separatedBy: " ").prefix(visibleWords)
        let strPrefix = strPrefixArr.joined(separator: " ")
        //
        let strSuffix = data.components(separatedBy: " ").suffix(from: strPrefixArr.count).joined(separator: " ")
        
        switch type {
        case .free:
            return strPrefix
        case .premium:
            return strSuffix
        }
    }
    func getPremiumText_v2(_ type: PremiumContentType) -> String? {
        guard let data = data else { return nil }

        // Разделяем строку на абзацы
        let paragraphs = data.components(separatedBy: "\n").filter { !$0.isEmpty }
        
        guard !paragraphs.isEmpty else { return nil }
        
        switch type {
        case .free:
            // Возвращаем первый абзац
            return paragraphs.first
        case .premium:
            // Возвращаем все абзацы, кроме первого, как один текст
            return paragraphs.dropFirst().joined(separator: "\n")
        }
    }
    
    
}
