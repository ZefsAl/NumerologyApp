//
//  WeekModel.swift
//  Numerology
//
//  Created by Serj on 28.11.2023.
//

import Foundation

class MonthModel: Decodable, Identifiable {
    
    let mainTrends: String
    let monthSigns: String
    let yourMonthlyHoroscope: String
    
    enum CodingKeys: String, CodingKey {
        case mainTrends = "mainTrends"
        case monthSigns = "monthSigns"
        case yourMonthlyHoroscope = "yourMonthlyHoroscope"
    }
}

