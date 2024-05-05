//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 28.04.2024.
//

import Foundation

struct AngelNumbersModel: Codable {
    
    let number: String
    let info: String

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case info = "info"
    }
}
