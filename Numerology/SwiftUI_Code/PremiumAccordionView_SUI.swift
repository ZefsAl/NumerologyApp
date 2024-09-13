//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 06.09.2024.
//

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}


class PremiumTextData: ObservableObject {
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

import SwiftUI
// MARK: - PremiumTextView_SUI
struct PremiumTextView_SUI: View {
    //
    @ObservedObject var sharedData: PremiumTextData
    //
    private let viewMargin = EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
    private let cardMargin = EdgeInsets(top: 16,leading: 16,bottom: 16,trailing: 16)
    // Style
    let primaryColor = DesignSystem.Horoscope.primaryColor
    let bgColor = DesignSystem.Horoscope.backgroundColor
    let textFont = DesignSystem.SourceSerifProFont.subtitle!
    
    // MARK: - body
    var body: some View {
        
        VStack(spacing: 8) {
            Text(sharedData.getPremiumText(.free) ?? "Error")
                .font(Font((textFont) as CTFont))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(BackgroundClearView())
            Text(sharedData.getPremiumText(.premium) ?? "Error")
                .font(Font((textFont) as CTFont))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .blur(radius: sharedData.isPremium ? 3 : 0) // 5
                .background(BackgroundClearView())
        }
    }
}




struct PremiumTextView_SUI_Previews: PreviewProvider {
    static var previews: some View {
        PremiumTextView_SUI(sharedData: PremiumTextData())
            .previewLayout(.sizeThatFits)
    }
}

