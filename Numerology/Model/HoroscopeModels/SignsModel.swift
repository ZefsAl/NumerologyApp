//
//  SignsModel.swift
//  Numerology
//
//  Created by Serj on 25.11.2023.
//

import Foundation

class SignsModel: Decodable, Identifiable {
    
    let dateAboutYou: String?
    let zodiacSigns: String?
    let signCharacteristics: String?
    let image: [ImageModel]?
    let charts: String?
    let family: String?
    let friendship: String?
    let intimacy: String?
    let work: String?
    
    
    enum CodingKeys: String, CodingKey {
        case dateAboutYou = "dateAboutYou"
        case zodiacSigns = "zodiacSigns"
        case signCharacteristics = "signCharacteristics"
        case image = "image"
        case charts = "charts"
        case family = "family"
        case friendship = "friendship"
        case intimacy = "intimacy"
        case work = "work"
    }
}
