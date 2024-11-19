//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

// MARK: - Profile Setting View
struct MusicSetting: View {
    
    @ObservedObject var musicManager = MusicManager.shared
    @StateObject var musicViewModel = MusicViewModel()
    
    let musicToggleModel = Setting(
        settingType: .music,
        title: "Music",
        color: Color(UIColor.systemPink),
        imageName: "speaker.wave.3.fill"
    )

    var body: some View {
        List {
            SettingCellView(
                customView:
                Toggle("", isOn: $musicManager.isOnMusic)
                    .onChange(of: musicManager.isOnMusic) { value in
                        UserDefaults.standard.setValue(value, forKey: UserDefaultsKeys.bgMusicState)
                        value ? musicManager.playSound() : musicManager.stopSound()
                    },
                model: musicToggleModel
            )
            ForEach(musicViewModel.musicSectionsData, id: \.self) { data in
                Section(header: Text(data.sectionTitle).textCase(nil)) {
                    ForEach(data.melodyModels, id: \.self) { model in
                        CheckBoxCellView(
                            title: model.melody,
                            selectedMelody: $musicManager.selectedMelody
                        )
                    }
                }
            }
        }
        .navigationTitle("Profile").navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MusicSetting()
}
