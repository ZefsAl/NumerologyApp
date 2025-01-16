//
//  PushMessagesModel.swift
//  Numerology
//
//  Created by Serj_M1Pro on 30.12.2024.
//

import Foundation

struct PushMessagesModel: Decodable {
    let number: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case message = "message"
    }
}
