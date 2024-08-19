//
//  CompatibilityHrscpModel.swift
//  Numerology
//
//  Created by Serj on 22.01.2024.
//

import Foundation

struct CompatibilityHrscpModel: Decodable {
    
    let chosenSign: String
    let chosenSign2: String
    let compatibilityStats: String?
    let signOfUser: String
    // Text
    let aboutThisSign: String
    let family: String?
    let friendship: String?
    let intimacy: String?
    let work: String?
    
    enum CodingKeys: String, CodingKey {
        case aboutThisSign = "aboutThisSign";
        case chosenSign = "chosenSign";
        case chosenSign2 = "chosenSign2";
        case compatibilityStats = "compatibilityStats";
        case signOfUser = "signOfUser";
        case family = "family";
        case friendship = "friendship";
        case intimacy = "intimacy";
        case work = "work";
    }
}
