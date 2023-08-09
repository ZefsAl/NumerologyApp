//
//  PersonalDayModel.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import Foundation

class PersonalDayModel: Codable {
 
    let number: Int
    let aboutPersDay: String
    let infoPersDay: String
//    let image: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutPersDay = "aboutPersDay"
        case infoPersDay = "infoPersDay"
//        case image = "image"
    }
}
