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
    
    // тут нужно @AppStorage
//    @AppStorage(Self.userNameKey) var userName: String = "Unnamed"
    
    
    @Published var name: String = UserDataKvoManager.shared.name ?? ""
    @Published var surname: String = UserDataKvoManager.shared.surname ?? ""
    @Published var dateOfBirth: Date? = UserDataKvoManager.shared.dateOfBirth
    
//    @AppStorage(UserDefaultsKeys.name) var name: String = UserDataKvoManager.shared.name ?? ""
//    @AppStorage(UserDefaultsKeys.surname) var surname: String = UserDataKvoManager.shared.surname ?? ""
    
    
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
    
//    let profileSettingData: [ProfileSectionModel] = [
//        ProfileSectionModel(sectionTitle: "Name", cellText: "Enter your name"),
//        ProfileSectionModel(sectionTitle: "Surname", cellText: "Enter your surname"),
//        ProfileSectionModel(sectionTitle: "Date of birth", cellText: "Your date of birth"),
//    ]
    
}
