//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 29.04.2024.
//

import Foundation

struct MonthCalendarModel: Decodable {
  
    let monthSigns: String
    let monthInfo: String
    let mainTrends: String
    let badDays: String
    let goodDays: String
    
    enum CodingKeys: String, CodingKey {
        case monthSigns = "monthSigns"
        case monthInfo = "monthInfo"
        case mainTrends = "mainTrends"
        case badDays = "badDays"
        case goodDays = "goodDays"
    }
}
