//
//  NumbersOfName.swift
//  Numerology
//
//  Created by Serj on 31.07.2023.
//

import Foundation


class NumbersOfNameModel: Codable, Identifiable {
 
    let number: Int
    let aboutName: String
    let infoName: String
    let image: [Image]
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutName = "aboutName"
        case infoName = "infoName"
        case image = "image"
    }
}
