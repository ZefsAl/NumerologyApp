//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 10.06.2024.
//

import Foundation

class TrendsArticlesModel: Codable, Identifiable {
 
    let article: String
    let cardText: String
    let cardTitle: String
    let imageTitle: String
    let image: [Image]
    let isPremium: Bool?
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case article    = "article"
        case cardText   = "cardText"
        case cardTitle  = "cardTitle"
        case imageTitle = "imageTitle"
        case image      = "image"
        case isPremium  = "isPremium"
        case likes      = "likes"
    }
}
