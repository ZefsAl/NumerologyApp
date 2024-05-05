//
//  BoardOfDayModel.swift
//  Numerology
//
//  Created by Serj on 30.07.2023.
//

import Foundation

struct BoardOfDayModel: Codable {
    
    let dayTip: String
    let short: String

    enum CodingKeys: String, CodingKey {
        case dayTip = "dayTip"
        case short = "short"
    }
    
}
