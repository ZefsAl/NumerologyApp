//
//  MessageContextMenu.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.07.2025.
//

import SwiftUI

//https://stackoverflow.com/questions/78201062/ios-swiftui-need-to-display-popover-without-arrow/78202598#78202598


//Не плохой вариант - нужно тестировать
// https://stackoverflow.com/questions/78278081/how-to-implement-context-menu-with-custom-view-in-preview-param-that-can-interac


//struct MessageContextMenu: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//
//
//#Preview {
//    MessageContextMenu()
//}




struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
}

struct MessageView: View {
    let message: Message

    var body: some View {
        Text(message.text)
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.background)
            }
            .fixedSize(horizontal: false, vertical: true)
    }
}

//struct EmojiButton: View {
//    let emoji: Character
//    @State private var animate = false
//
//    var body: some View {
//        Text(String(emoji))
//            .font(.largeTitle)
//            .phaseAnimator([false, true], trigger: animate) { content, phase in
//                content.scaleEffect(phase ? 1.3 : 1)
//            } animation: { phase in
//                .bouncy(duration: phase ? 0.2 : 0.05, extraBounce: phase ? 0.7 : 0)
//            }
//            .onTapGesture {
//                print("\(emoji) tapped")
//                animate.toggle()
//            }
//    }
//}

struct MessageContextMenu_Demo: View {
    @State private var selectedMessage: Message?
    @Namespace private var nsPopover

    private let demoMessages: [Message] = [
        Message(text: "Once upon a time"),
        Message(text: "the quick brown fox jumps over the lazy dog"),
        Message(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        Message(text: "and they all lived happily ever after.")
    ]

//    private var reactionsView: some View {
//        HStack {
//            ForEach(Array("👍👎😄🔥💕⚠️❓"), id: \.self) { char in
//                EmojiButton(emoji: char)
//            }
//        }
//        .padding(10)
//        .background {
//            RoundedRectangle(cornerRadius: 10)
//                .fill(.bar)
//        }
//    }

    @ViewBuilder
    private var messageView: some View {
        if let selectedMessage {
            MessageView(message: selectedMessage)
                .allowsHitTesting(false)
        }
    }

    private func optionLabel(label: String, imageName: String) -> some View {
        HStack(spacing: 0) {
            Text(label)
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .contentShape(Rectangle())
    }

    private var optionsMenu: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                print("Reply tapped")
            } label: {
                optionLabel(label: "Reply", imageName: "arrowshape.turn.up.left.fill")
            }
            Divider()
            Button {
                print("Copy tapped")
            } label: {
                optionLabel(label: "Copy", imageName: "doc.on.doc.fill")
            }
            Divider()
            Button {
                print("Unsend tapped")
            } label: {
                optionLabel(label: "Unsend", imageName: "location.slash.circle.fill")
            }
        }
        .buttonStyle(.plain)
        .frame(width: 220)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.bar)
        }
    }

    private var customPopover: some View {
        VStack(alignment: .leading) {
//            reactionsView
            messageView
            optionsMenu
        }
//        .padding(.top, -70)
        .padding(.trailing)
        .padding(.trailing)
    }

    var body: some View {
        ZStack {
            
            
            // Simple Chat
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(demoMessages) { message in
                        MessageView(message: message)
                            .matchedGeometryEffect(
                                id: message.id,
                                in: nsPopover,
                                anchor: .topLeading,
                                isSource: true
                            )
                            .onLongPressGesture {
                                selectedMessage = message
                            }
                    }
                }
                .rotationEffect(Angle(degrees: 180))
            }
            .rotationEffect(Angle(degrees: 180))
//            .blur(radius: selectedMessage == nil ? 0 : 5)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.red)
            

            
            // MARK: - TEST 1
//            if let selectedMessage {
//                Color.clear
//                    .background(.ultraThinMaterial)
//                    .onTapGesture { self.selectedMessage = nil }
//             
//                customPopover
//                    .confirmationDialog("Select a color", isPresented: .constant(true), titleVisibility: .visible) {
//                        Button {
//                            print("Reply tapped")
//                        } label: {
//                            optionLabel(label: "Reply", imageName: "arrowshape.turn.up.left.fill")
//                        }
//                        Divider()
//                        Button {
//                            print("Copy tapped")
//                        } label: {
//                            optionLabel(label: "Copy", imageName: "doc.on.doc.fill")
//                        }
//                        Divider()
//                        Button {
//                            print("Unsend tapped")
//                        } label: {
//                            optionLabel(label: "Unsend", imageName: "location.slash.circle.fill")
//                        }
//                    }
//            }
       
            // MARK: - TEST 2
            // Context menu Overlay
            if let selectedMessage {
                Color.clear
                    .background(.ultraThinMaterial)
                    .preferredColorScheme(.dark)
                    .onTapGesture { self.selectedMessage = nil }
                    

                customPopover
//                    .offset(y: -100)
                // TODO: - как получить offset
                // Если ниже середины то делать по центру
                    .matchedGeometryEffect(
                        id: selectedMessage.id,
                        in: nsPopover,
                        properties: .position,
                        anchor: .topLeading,
                        isSource: true // выключить
                    )
                    .transition(
                        .opacity.combined(with: .scale)
                        .animation(.smooth(duration: 0.3, extraBounce: 0.2))
                    )
            }
            
            
        }
        .animation(.easeInOut(duration: 0.25), value: selectedMessage)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.31, green: 0.15, blue: 0.78))
    }
}

#Preview {
    MessageContextMenu_Demo()
}
