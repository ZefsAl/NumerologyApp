//

//  Numerology
//
//  Created by Serj on 30.01.2024.
//

import Foundation

struct MoonPhaseModel: Decodable {
    
    let moonDay: Int
    let currentDay: Int
    let todayInfo: String
    
    enum CodingKeys: String, CodingKey {
        case moonDay = "moonDay"
        case currentDay = "currentDay"
        case todayInfo = "todayInfo"
    }
}
