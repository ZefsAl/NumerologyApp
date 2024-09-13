//
//  NumbersOfDestinyModel.swift
//  Numerology
//
//  Created by Serj on 30.07.2023.
//

import Foundation

class NumbersOfDestinyModel: Codable, Identifiable {
 
    let number: Int
    let aboutDestiny: String
    let infoDestiny: String
    let image: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutDestiny = "aboutDestiny"
        case infoDestiny = "infoDestiny"
        case image = "image"
    }
}
