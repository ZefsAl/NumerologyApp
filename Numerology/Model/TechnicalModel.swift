//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 07.08.2024.
//

import Foundation


class TechnicalModel: Decodable {
    
    let key: String?
    let val1: Int?
    let val2: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case val1 = "val1"
        case val2 = "val2"
    }
}
