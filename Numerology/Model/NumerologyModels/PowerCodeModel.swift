//
//  PowerCodeModel.swift
//  Numerology
//
//  Created by Serj on 31.07.2023.
//

import Foundation

class PowerCodeModel: Codable {
 
    let number: Int
    let aboutPower: String
    let infoPower: String
    let image: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutPower = "aboutPower"
        case infoPower = "infoPower"
        case image = "image"
    }
}
