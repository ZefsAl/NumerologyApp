//
//  CompatibilityHrscpModel.swift
//  Numerology
//
//  Created by Serj on 22.01.2024.
//

import Foundation

struct CompatibilityHrscpModel: Decodable {
    
    let aboutThisSign: String
    let chosenSign: String
    let chosenSign2: String
    let compatibilityStats: String
    let signOfUser: String
    
    enum CodingKeys: String, CodingKey {
        case aboutThisSign = "aboutThisSign"
        case chosenSign = "chosenSign"
        case chosenSign2 = "chosenSign2"
        case compatibilityStats = "compatibilityStats"
        case signOfUser = "signOfUser"
    }
}
