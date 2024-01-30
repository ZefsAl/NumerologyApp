//
//  TodayTomorModel.swift
//  Numerology
//
//  Created by Serj on 28.11.2023.
//

import Foundation
// Today, Tomorrow, Week
class HoroscopeDefaultModel: Decodable, Identifiable {
    
    let number: Int
    let info: String
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case info = "info"
    }
}
