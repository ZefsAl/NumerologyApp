//
//  TodayTomorModel.swift
//  Numerology
//
//  Created by Serj on 28.11.2023.
//

import Foundation
// Today, Tomorrow, Week

class HoroscopeDefaultModel: Decodable {
    
    let number: Int?
    let info: String? // ❌ , неделя нужна!
    let charts: String?
    let business: String?
    let friendship: String?
    let health: String?
    let love: String?
    let sex: String?
    let social: String?
    
    enum CodingKeys: String, CodingKey {
        case number = "number";
        case info = "info";
        case charts = "charts";
        case business = "business";
        case friendship = "friendship";
        case health = "health";
        case love = "love";
        case sex = "sex";
        case social = "social";
    }
}
