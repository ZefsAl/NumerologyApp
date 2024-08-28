//

//  Numerology
//
//  Created by Serj on 29.11.2023.
//

import Foundation

class Year2024Model: Decodable, Identifiable {
    
    let mainTrends: String
    let yearSign: String
    let yourHoroscope: String
    let charts: String?
    
    enum CodingKeys: String, CodingKey {
        case mainTrends = "mainTrends"
        case yearSign = "yearSign"
        case yourHoroscope = "yourHoroscope"
        case charts = "charts"
    }
}

