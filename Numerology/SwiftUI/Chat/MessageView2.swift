//
//  ChatView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 27.04.2025.
//

import Foundation
import SwiftUI
import RealmSwift
import Lottie
import MarkdownUI

struct MessageView2: View {
    
    var message: MessageObject? = nil
    var streamingMessage: Binding<String?> = .constant(nil)
    var isStreaming: Binding<Bool> = .constant(false)
    
    
    @State private var onLongPressScale: CGSize = CGSize(width: 1.0, height: 1.0)
    @State private var saveSize: CGSize = .zero
    
    private func getColor() -> Color {
        return switch message?.role {
        case .system:
            Color.black
        case .user:
            Color(DS.Chat.question)
        case .assistant:
            Color(DS.Chat.answer)
        default:
            Color(DS.Chat.answer)
        }
    }
    
    
    
    var body: some View {
        let isCurrentUser = self.message?.role == .user
        
        HStack {
            // Alignment
            if message?.role == .user {
                Spacer()
            }
            
            
            let msg = message?.content ?? ""
            let stream = streamingMessage.wrappedValue ?? ""
            
            // Message View
            HStack(spacing: 0) {
                Markdown(message?.content ?? streamingMessage.wrappedValue ?? "")
                if msg.isEmpty, stream.isEmpty, self.isStreaming.wrappedValue {
                    LottieView(animation: .named("typing"))
                        .configure(\.contentMode, to: .scaleAspectFill)
                        .looping()
                        .frame(width: 40, height: 20)
                        .scaleEffect(1.15)
                }
            }
            .padding(EdgeInsets(
                top: 12,
                leading: isCurrentUser ? 14 : 18,
                bottom: 12,
                trailing: isCurrentUser ? 18 : 14)
            )
            .background {
                ZStack {
                    let bubble = BubbleShape(myMessage: isCurrentUser)
                    bubble.fill(self.getColor())
                }
            }
            // Alignment
            if message?.role == .assistant || streamingMessage.wrappedValue != nil {
                Spacer()
            }
        } // HStack
        // Анимация взаиможействия
//        .saveSize(in: self.$saveSize)
//        .scaleEffect(self.onLongPressScale, anchor: .center)
        
        
        // TODO: - LongPressGesture и scroll view баг совместимости ⚠️
        
//        .onLongPressGesture(
//            minimumDuration: <#T##Double#>,
//            maximumDistance: <#T##CGFloat#>,
//            perform: <#T##() -> Void#>,
//            onPressingChanged: <#T##((Bool) -> Void)?#>
//        )
        
//        .simultaneousGesture(
//               LongPressGesture(minimumDuration: 0.5)
//                   .onEnded { _ in
//                       // Действие при долгом тапе
//                   }
//           )
//        .gesture(
//            LongPressGesture(minimumDuration: 0.5)
//                .onEnded { bool in
//                    // Обработка
//                    self.gestureAction(bool)
//                },
//            including: .subviews
//        )
//        .onLongPressGesture(
//            minimumDuration: 2,
//            maximumDistance: 0,
//            perform: { print("✅ perform") },
//            onPressingChanged: { self.gestureAction($0) }
//        )
        
        
    }
    
    func gestureAction(_ bool: Bool) {
        withAnimation(.smooth) {
            let scaleFactor = self.saveSize.height < 100 ? 0.88 : 0.95
            self.onLongPressScale = bool ? CGSize(width: scaleFactor, height: scaleFactor) : CGSize(width: 1, height: 1)
        }
        if bool {
            TouchSupport.haptic(.medium)
            print("✅ long press")
            print(self.saveSize)
        }
    }
}


struct SizeCalculator: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear // we just want the reader to get triggered, so let's use an empty color
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}

extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}



struct MessageView2_TESTPREVIEW: View {
//    @State var messages: [MessageObject] = []
    var body: some View {
        ScrollView {
            VStack {
                MessageView2(message: MessageObject(
                    chatID: .chat1,
                    date: Date(),
                    role: .assistant,
                    content: "Test message"
                ))
                MessageView2(message: MessageObject(
                    chatID: .chat1,
                    date: Date(),
                    role: .system,
                    content: "Test message"
                ))
                MessageView2(message: MessageObject(
                    chatID: .chat1,
                    date: Date(),
                    role: .user,
                    content: markdown_text
                ))
                MessageView2(
                    message: nil,
                    streamingMessage: .constant(""), isStreaming: .constant(true)
                )
            }
        }
        .background(.gray.opacity(0.3))
    }
}
#Preview {
    MessageView2_TESTPREVIEW()
}

let markdown_text = """
"As a Cancer born on July 5, 2005, your current astrological climate suggests a mix of influences—some supportive, others requiring caution. Here’s what stands out for you right now:\n\n### **Key Astrological Factors:**\n1. **Moon in Cancer (Your Sun Sign)** – If the Moon is currently in Cancer (or moving into Leo), your emotions are heightened. This can be a powerful time to act *if* your intuition strongly aligns with the situation. Cancers thrive when they trust their gut.  \n   \n2. **Mars in Taurus (as of mid-2024)** – Mars, the planet of action, is in steady Taurus, encouraging slow, deliberate moves rather than impulsive ones. If your plan requires patience and persistence, this is a favorable time.  \n\n3. **Saturn Retrograde (Pisces, mid-2024)** – Saturn asks you to review commitments. If you’re acting on something long-term, double-check the foundations. Rushed decisions now could lead to delays later.  \n\n4. **Jupiter in Gemini (until mid-2024)** – Expansive Jupiter in your 12th house (hidden matters) suggests working behind the scenes or refining ideas before going public.  \n\n### **Your Best Approach:**  \n- **If it’s emotional/spiritual/personal:** Yes, but move with care—Cancer energy is sensitive now.  \n- **If it’s career/financial:** Wait for a clearer signal (e.g., after Mercury retrograde ends, if applicable).  \n- **If it’s about relationships:** Communicate clearly (Mercury’s influence), but avoid passive-aggressive tendencies.  \n\n**Final Verdict:** **Proceed, but with strategic patience.** Your Cancerian intuition is your superpower—listen to it, but temper reactions with logic.  \n\nWould you like me to check a specific area (love, career, etc.) in more depth?  \n\n— *Mary Williams*  \n*Professional Astrologer*"
"""
