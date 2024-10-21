//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

// MARK: - Profile Setting View
struct MusicSetting: View {
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
                    Toggle("", isOn: $musicViewModel.isOnMusic)
                    .onChange(of: musicViewModel.isOnMusic) { value in
                        print("✅Toggle",value)
                    },
                model: musicToggleModel
            )
            ForEach(musicViewModel.musicSectionsData, id: \.self) { data in
                Section(header: Text(data.sectionTitle).textCase(nil)) {
                    ForEach(data.melodyModels, id: \.self) { model in
                        CheckBoxCellView(
                            title: model.melody,
                            selectedMelody: $musicViewModel.selectedMelody
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
