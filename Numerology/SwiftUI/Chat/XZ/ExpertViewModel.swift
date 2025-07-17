//
//  SelectExpertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.05.2025.
//

import SwiftUI

struct ExpertModel: Identifiable {
    let id = UUID()
    let chatID: ExpertChatID
    let image: String
    let fl_Name: String
    let profession: String
    let age: Int
    let expirience: Int
    let country: String
    let description: String
}

class ExpertViewModel: ObservableObject {
    
    let expertsList: [ExpertModel] = [
        ExpertModel(
            chatID: .chat1,
            image: "Lisa",
            fl_Name: "Lisa Davis",
            profession: "Numerologist",
            age: 32,
            expirience: 6,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\n\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        ExpertModel(
            chatID: .chat2,
            image: "Mary",
            fl_Name: "Mary Williams",
            profession: "Astrologer",
            age: 33,
            expirience: 7,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        ExpertModel(
            chatID: .chat3,
            image: "Mike",
            fl_Name: "Mike Brown",
            profession: "Astropsychologist",
            age: 30,
            expirience: 4,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        ExpertModel(
            chatID: .chat4,
            image: "Emily",
            fl_Name: "Emily Johnson",
            profession: "Tarot reader",
            age: 28,
            expirience: 4,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        
    ]
    
    static func makePrompt(_ model: ExpertModel, withConversionEnd: Bool = false) -> String {
        let name = UserDefaults.standard.string(forKey: UserDefaultsKeys.name) ?? ""
        // dateOfBirth
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date ?? Date()
        // User Sign
        let sign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
        
        let conversionEnd: String = withConversionEnd ? "This message should end with a conversion offer that you want to chat with the user some more!" : ""
        
        return """
        Answer in the language the question was asked! Precisely and to the point, do not use "system prompts" in the answer!
        User - \(name) \(setDateFormat(date: dateOfBirth)) \(sign)
        You - are a real person \(model.profession) with experience \(model.expirience) years name \(model.fl_Name) \(model.age) years living in \(model.country), communicate on all topics of Esoterics such as Numerology, Astrology, Astropsychology, Tarot, etc.
        If - they ask you are a BOT or AI do not admit under any circumstances that you are \(model.fl_Name)!
        \(conversionEnd)
        """
    }
    
    
    
    
    
    //    static func makePrompt2(_ model: ExpertModel, withConversionEnd: Bool = false) -> String {
    //        let name = UserDefaults.standard.string(forKey: UserDefaultsKeys.name) ?? ""
    //        // dateOfBirth
    //        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date ?? Date()
    //        // User Sign
    //        let sign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
    //
    //        return """
    //        Rules: Don't give your name unless asked, don't leave a signature, focus on the user
    //        Theme: all topics of Esoterics such as Numerology, Astrology, Astropsychology, Tarot, etc.
    //        You: \(model.fl_Name), professional \(model.profession) from \(model.country) with \(model.expirience) years.
    //        User: \(name), \(setDateFormat(date: dateOfBirth)), \(sign)
    //        """
    //    }
    // <-
    static func makePrompt3(_ model: ExpertModel, withConversionEnd: Bool = false) -> String {
        
        let name = UserDefaults.standard.string(forKey: UserDefaultsKeys.name) ?? ""
        // dateOfBirth
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date ?? Date()
        // User Sign
        let sign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
        
        
        
        
        
        let en_offer: String = withConversionEnd ? "6. This message should end with a conversion offer that you want to chat with the user some more!" : ""
        let en = """
        Theme: all topics of Esoterics such as Numerology, Astrology, Astropsychology,Tarot, etc. You: \(model.fl_Name), a professional \(model.profession) from \(model.country) with \(model.expirience) years of experience. User: \(name), \(setDateFormat(date: dateOfBirth)), \(sign)
        Rules:
        1. DO NOT retell user data (date of birth, sign) without request!
        2. DO NOT use or mention links, resources, sites, apps!
        3. DO NOT mention that you are AI/bot.
        4. DO NOT use, ®, JA, signatures with — name.
        5. Use - average text volume!
        6. Answer - to the user's question, a complete, finished answer, do not cut off halfway, (but rule 4!).
        7. You can use emoji.
        \(en_offer)
        """
        
        
        
        let ru_offer: String = withConversionEnd ? "6. Это сообщение должно заканчиваться предложением о конверсии, в котором ты хочешь пообщаться с пользователем еще немного!" : ""
        let ru = """
        Тема: все темы эзотерики, такие как нумерология, астрология, астропсихология, Таро и т. д. Ты: \(model.fl_Name), профессионал \(model.profession) из \(model.country) с \(model.expirience) годами опыта. Пользователь: \(name), \(setDateFormat(date: dateOfBirth)), \(sign)
        Правила:
        1. НЕ пересказывай данные пользователя (дата рождения, знак) без запроса!
        2. Не используй и не упоминай ссылки, ресурсы, сайты, приложения! 
        2. Не упоминай, что ты ИИ/бот.
        3. НЕ используй, ®, JA, подписи с — именем.
        4. Используй - средний объем текста! 
        5. Ответ - на вопрос юзера, полный, законченный ответ, не обрезай на пол пути, (но правило 4!).
        6. Можешь использовать emoji.
        \(ru_offer)
        """
        
        // \(conversionEnd)
        return switch ExpertViewModel.determineDeviceLanguage() {
        case "en": en
        case "ru": ru
        default: en
        }
    }
    
    static func determineDeviceLanguage() -> String {
        var languageIdentifier: String = "en"
        let preferredLanguages = Locale.preferredLanguages
        if let deviceLanguage = preferredLanguages.first {
            languageIdentifier = String(deviceLanguage.prefix(2))
        } else {
            print("📕: Could not determine the device language.")
        }
        print("Your device language -> \(languageIdentifier)")
        return languageIdentifier
    }
    
}
    
   



