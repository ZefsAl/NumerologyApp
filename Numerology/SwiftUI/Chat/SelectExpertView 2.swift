//
//  SelectExpertView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.05.2025.
//

import SwiftUI

struct ExpertModel: Identifiable {
    let id = UUID()
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
            image: "person1",
            fl_Name: "Lisa Davis",
            profession: "Numerologist",
            age: 32,
            expirience: 6,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\n\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        ExpertModel(
            image: "person1",
            fl_Name: "Mary Williams",
            profession: "Astrologer",
            age: 32,
            expirience: 6,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        ExpertModel(
            image: "person1",
            fl_Name: "Mike Brown",
            profession: "Astropsychologist",
            age: 32,
            expirience: 6,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        ExpertModel(
            image: "person1",
            fl_Name: "Emily Johnson",
            profession: "Tarot reader",
            age: 32,
            expirience: 6,
            country: "United States",
            description: "A forward-thinking astrologer-researcher blending cutting-edge analytical frameworks with the ancient wisdom of astrology. Specializing in modern psychological astrology, Irina deciphers birth charts through a unique fusion of symbolic language, cognitive behavioral insights, and data-driven interpretation.\nMy approach empowers clients to: Unlock their core motivations and untapped potential, Navigate life transitions with clarity using personalized cosmic roadmaps, Align career, relationships, and goals with their authentic cosmic blueprint. Irina’s signature methodology transforms abstract planetary patterns into actionable strategies for self-mastery, resonating with seekers of evidence-informed spiritual growth."
        ),
        
    ]
    
    static func makePrompt(_ model: ExpertModel) -> String {
        return """
        1. Remember, you are a professional \(model.profession), with \(model.expirience) years of experience, your name is \(model.fl_Name), you \(model.age) years old, you live in \(model.country). 
        2. If suddenly you are asked whether you are a BOT or an AI? Do not admit that you are \(model.fl_Name) 
        3. Do not answer questions related to (politics, medicine, wars) or avoid! 
        4. Answer the user with kindness and involvement.
        """
    }
}



struct SelectExpertView2: View {
    @StateObject var vm = ExpertViewModel()
    
    
    var body: some View {
        VStack(spacing: 22) {
            ForEach(Array(vm.expertsList.enumerated()), id: \.offset) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.element.fl_Name)
                            .multilineTextAlignment(.leading)
                        Text(item.element.profession)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                Divider().overlay(Color.red)
            }
            
        }
    }
    
}


#Preview {
    SelectExpertView2()
}
