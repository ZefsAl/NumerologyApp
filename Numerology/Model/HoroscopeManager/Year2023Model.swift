//
//  File.swift
//  Numerology
//
//  Created by Serj on 29.11.2023.
//

import Foundation

class Year2023Model: Decodable, Identifiable {
    
    let yearSign: String
    let yourHoroscope: String
    
    enum CodingKeys: String, CodingKey {
        case yearSign = "yearSign"
        case yourHoroscope = "yourHoroscope"
    }
}
