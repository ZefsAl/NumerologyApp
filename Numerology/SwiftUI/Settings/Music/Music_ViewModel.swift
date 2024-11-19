//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 10.10.2024.
//

import SwiftUI

class MusicViewModel: ObservableObject {
    
    lazy var musicSectionsData: [MusicSectionModel] = [
        MusicSectionModel(
            sectionTitle: "Melody",
            melodyModels: melodyData
        )
    ]
    
    let melodyData: [MelodyModel] = [
        MelodyModel(melody: SoundsName.melody1),
        MelodyModel(melody: SoundsName.melody2),
        MelodyModel(melody: SoundsName.melody3),
    ]
}
