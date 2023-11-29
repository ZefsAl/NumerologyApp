//
//  SignsModel.swift
//  Numerology
//
//  Created by Serj on 25.11.2023.
//

import Foundation

class SignsModel: Decodable, Identifiable {
    
    let zodiacSigns: String
    let dateAboutYou: String
    let compatibility2: String
    let month: String
    let monthCopy: String
    let signCharacteristics: String
    let year: String
    let yearCopy: String
    let image: [Image]
    
    enum CodingKeys: String, CodingKey {
        case zodiacSigns = "zodiacSigns"
        case dateAboutYou = "dateAboutYou"
        case compatibility2 = "compatibility2"
        case month = "month"
        case monthCopy = "monthCopy"
        case signCharacteristics = "signCharacteristics"
        case year = "year"
        case yearCopy = "yearCopy"
        case image = "image"
    }
}
