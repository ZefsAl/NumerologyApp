//
//  messageModel.swift
//  Numerology
//
//  Created by Serj_M1Pro on 29.04.2025.
//

import Foundation
import RealmSwift

enum Role: String, PersistableEnum {
    case system
    case user
    case assistant
}

class MessageObj: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var uuid: UUID = UUID()
    @Persisted var role: Role
    @Persisted var content: String
    @Persisted var isStreaming: Bool
    
    convenience init(role: Role, content: String, isStreaming: Bool) {
        self.init()
        self.role = role
        self.content = content
        self.isStreaming = isStreaming
    }
    
//    func addContent(_ newContent: String) {
//        content += newContent
//    }
}








