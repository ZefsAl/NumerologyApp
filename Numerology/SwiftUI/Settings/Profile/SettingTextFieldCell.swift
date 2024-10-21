//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

// MARK: - "Setting Text Field Cell"
struct SettingTextFieldCell: View {
    
    @Binding var inputText: String

    var body: some View {
        UITextField.appearance().clearButtonMode = .whileEditing
        return TextField("placeholder text", text: $inputText)
    }
}
