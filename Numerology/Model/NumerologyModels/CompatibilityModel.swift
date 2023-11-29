//
//  CompatibilityModel.swift
//  Numerology
//
//  Created by Serj on 07.08.2023.
//

import Foundation


class CompatibilityModel: Codable {
 
    let numberOfUser: Int
    let chosenNumber: Int
    let aboutThisNumbers: String
    
    enum CodingKeys: String, CodingKey {
        case numberOfUser = "numberOfUser"
        case chosenNumber = "chosenNumber"
        case aboutThisNumbers = "aboutThisNumbers"
    }
}
