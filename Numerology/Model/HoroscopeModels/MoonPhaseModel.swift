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
    //
    let meaning: String?
    let love: String?
    let home: String?
    let health: String?
    let money: String?
    let relationships: String?
    let haircut: String?
    let marriage: String?
    let birthday: String?
    let advice: String?
    let warnings: String?
    let dreams: String?
    let moonPhase: String?
    
    enum CodingKeys: String, CodingKey {
        case moonDay,currentDay,todayInfo,meaning,love,home,health,money,relationships,haircut,marriage,birthday,advice,warnings,dreams,moonPhase
    }
}


