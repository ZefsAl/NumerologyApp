//
//  PersonalYearModel.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import Foundation

class PersonalYearModel: Codable {
 
    let number: Int
    let aboutPersYear: String
    let infoPersYear: String
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutPersYear = "aboutPersYear"
        case infoPersYear = "infoPersYear"
    }
}
