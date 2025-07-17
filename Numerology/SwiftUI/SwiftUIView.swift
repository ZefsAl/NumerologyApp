//
//  SwiftUIView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 24.06.2025.
//

import SwiftUI

struct SwiftUIView: View {
    let manager = DeepSeekStreamingManager()
    @State var messages: [MessageObject] = []
    @State var streamingMessage: String = ""
    
    var text: String = "привет расскажи о нумерологии"
    
    var body: some View {
        List {
            ForEach(messages, id: \.id) { message in
                Text(message.content)
            }
        }
        
        Text(streamingMessage)
            .background(Color.gray)
        Text(text)
            .background(Color.gray)
        Button(action: {
            self.simpletest()
        }, label: {
            Text("send")
        })
        .buttonStyle(.bordered)
        .tint(.orange)
        
    }
    
    func simpletest() {
        
        let message1 = MessageObject(
            date: Date(),
            role: .user,
            content: self.text
        )
        self.messages.append(message1)
        
        manager.streamMessage(
            messages: self.messages,
            onTextReceived: { text in
                DispatchQueue.main.async {
                    self.streamingMessage += text
                }
            },
            onCompletion: { error in
                DispatchQueue.main.async {
                  
                    
                        let message = MessageObject(
                            date: Date(),
                            role: .assistant,
                            content: self.streamingMessage
                        )
                        self.messages.append(message)
                    
                    
                    // self.isStreaming = false
                    //self.streamingMessage = nil
                    
                    if let error = error {
                        myPrint("❌⚠️ Streaming error:", error.localizedDescription)
                    }
                    self.manager.cancelStreaming()
                }
            }
        )
    }
    
}

#Preview {
    SwiftUIView()
}
