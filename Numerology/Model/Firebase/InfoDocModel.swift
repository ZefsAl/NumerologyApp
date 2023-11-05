//
//  InfoDocModel.swift
//  Numerology
//
//  Created by Serj on 13.08.2023.
//

import Foundation

class InfoDocModel: Codable {
    
    let info: String
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
    }
}
