//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 24.10.2024.
//

import Foundation

// Model
struct MusicSectionModel: Hashable {
    let sectionTitle: String
    let melodyModels: [MelodyModel]
}

struct MelodyModel: Hashable {
    let melody: String
}
