//
//  model.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

// MARK: - Model
struct Setting: Hashable {
    let settingType: SettingType?
    let title: String
    let color: Color
    let imageName: String
}
