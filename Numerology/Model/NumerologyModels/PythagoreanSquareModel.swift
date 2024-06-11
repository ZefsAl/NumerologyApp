//
//  PythagoreanSquareModel.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.05.2024.
//

import Foundation

struct ConvertPythagoreanNumbers {
    // for Pythagorean Square Model
    static func intToConstName(count: Int, model: PythagoreanSquareModel) -> String {
        switch count {
        case 0: return model.zeroSign
        case 1: return model.oneSign
        case 2: return model.twoSign
        case 3: return model.threeSign
        case 4: return model.fourSign
        case 5: return model.fiveSign
        default:
            return model.zeroSign
        }
    }
    
}

struct PythagoreanSquareModel: Codable {
    
    let cell: Int
    let zeroSign: String
    let oneSign: String
    let twoSign: String
    let threeSign: String
    let fourSign: String
    let fiveSign: String
    let info: String

    enum CodingKeys: String, CodingKey {
        case cell       = "cell"
        case zeroSign   = "zeroSign"
        case oneSign    = "oneSign"
        case twoSign    = "twoSign"
        case threeSign  = "threeSign"
        case fourSign   = "fourSign"
        case fiveSign   = "fiveSign"
        case info       = "info"
    }
}
