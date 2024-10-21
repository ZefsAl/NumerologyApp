//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 10.10.2024.
//

import SwiftUI

class MusicViewModel: ObservableObject {
    @Published var isOnMusic: Bool = true
    @Published var selectedMelody: String? = ""
    
    lazy var musicSectionsData: [MusicSectionModel] = [
        MusicSectionModel(
            sectionTitle: "Melody",
            melodyModels: melodyData
        )
    ]
    
    let melodyData: [MelodyModel] = [
        MelodyModel(melody: "Music1"),
        MelodyModel(melody: "Music2"),
        MelodyModel(melody: "Music3"),
    ]
}

// Model
struct MusicSectionModel: Hashable {
    let sectionTitle: String
    let melodyModels: [MelodyModel]
}

struct MelodyModel: Hashable {
    let melody: String
}
