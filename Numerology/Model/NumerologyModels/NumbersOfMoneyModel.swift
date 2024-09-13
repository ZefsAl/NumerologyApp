//
//  NumbersOfMoneyModel.swift
//  Numerology
//
//  Created by Serj on 31.07.2023.
//

import Foundation

class NumbersOfMoneyModel: Codable, Identifiable {
 
    let number: Int
    let aboutMoney: String
    let infoMoney: String
    let image: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case number = "number"
        case aboutMoney = "aboutMoney"
        case infoMoney = "infoMoney"
        case image = "image"
    }
}
