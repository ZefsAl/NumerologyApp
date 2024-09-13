//
//  NumbersOfSoulModel.swift
//  Numerology
//
//  Created by Serj on 26.07.2023.
//

import Foundation

class NumbersOfSoulModel: Codable, Identifiable {
 
    let number: Int
    let aboutSoul: String
    let infoSoul: String
    let image: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutSoul = "aboutSoul"
        case infoSoul = "infoSoul"
        case image = "image"
    }
}

class ImageModel: Codable {
    let downloadURL: String
    let lastModifiedTS: Int
    let name: String
    let ref: String
    let type: String
}


