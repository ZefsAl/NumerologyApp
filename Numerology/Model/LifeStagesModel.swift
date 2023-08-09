//
//  LifeStagesModel.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import Foundation

class LifeStagesModel: Codable {
 
    let number: Int
    let aboutStages: String
    let infoStages: String
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutStages = "aboutStages"
        case infoStages = "infoStages"
    }
}
