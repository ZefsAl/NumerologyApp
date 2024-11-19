//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

enum SettingType {
    case lifetime,profile,music,rate,terms,privacy,support,restore
}

class SettingsViewModel: ObservableObject {
    
    @Published var name: String? = UserDataKvoManager.shared.name
    @Published var surname: String? = UserDataKvoManager.shared.surname
    @Published var dateOfBirth: Date? = UserDataKvoManager.shared.dateOfBirth
    
    @Published var settings: [Setting] = [
        Setting(settingType: .lifetime, title: "Get lifetime access", color: Color(UIColor.systemIndigo), imageName: "sparkles"),
        Setting(settingType: .profile, title: "Profile", color: Color(UIColor.systemOrange), imageName: "person.fill"),
        Setting(settingType: .music, title: "Music", color: Color(UIColor.systemPink), imageName: "music.note.list"),
        Setting(settingType: .rate, title: "Rate app", color: Color(UIColor.systemBlue), imageName: "star.fill"),
        Setting(settingType: .terms, title: "Terms of use", color: Color(UIColor.gray), imageName: "exclamationmark.circle.fill"),
        Setting(settingType: .privacy, title: "Privacy policy", color: Color(UIColor.gray), imageName: "exclamationmark.circle.fill"),
        Setting(settingType: .support, title: "Support", color: Color(UIColor.gray), imageName: "questionmark.circle.fill"),
        Setting(settingType: .restore, title: "Restore purshace", color: Color(UIColor.systemGreen), imageName: "tag.fill"),
    ]
}
