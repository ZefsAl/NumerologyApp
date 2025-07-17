//
//  messageModel.swift
//  Numerology
//
//  Created by Serj_M1Pro on 29.04.2025.
//

import Foundation
import RealmSwift

enum ExpertChatID: String, PersistableEnum {
    case chat1, chat2, chat3, chat4
}

enum RoleObject: String, PersistableEnum {
    case system
    case user
    case assistant
}

class MessageObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var uuid: UUID = UUID()
    @Persisted var chatID: ExpertChatID?
    @Persisted var date: Date
    @Persisted var role: RoleObject
    @Persisted var content: String
    //
//    var isStreaming: Bool?
    
    convenience init(
        chatID: ExpertChatID? = nil,
        date: Date,
        role: RoleObject,
        content: String
//        isStreaming: Bool? = nil
    ) {
        self.init()
        self.chatID = chatID
        self.date = date
        self.role = role
        self.content = content
//        self.isStreaming = isStreaming
    }
    
    // не работает
//    func addContent(_ newContent: String) {
//        content += newContent
//    }
    
    
}








