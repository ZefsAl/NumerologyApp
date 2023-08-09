//
//  PersonalMonthModel.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import Foundation


class PersonalMonthModel: Codable {
 
    let number: Int
    let aboutPersMonth: String
    let infoPersMonth: String
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutPersMonth = "aboutPersMonth"
        case infoPersMonth = "infoPersMonth"
    }
}
