//
//  NumerologyIsModel.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import Foundation


//class NumerologyDescriptionModel: Codable {
//
//    let description: String
//
//    enum CodingKeys: String, CodingKey {
//        case description = "description"
//    }
//}

class NumerologyIsModel: Codable {

    let number: Int
    let infoNumerology: String

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case infoNumerology = "infoNumerology"
    }
}
