//
//  ChipsButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.11.2024.
//

import SwiftUI

struct ChipsButton: View {
    
    let title: String
    let iconName: String
    @Binding var selectedString: String
    var action: (() -> Void)?
    private let footnote = DS.SourceSerifProFont.footnote_Sb_13!
    
    let tintColor: String
//    Color(DesignSystem.MoonColors.mediumTint)
    init(
        title: String,
        iconName: String,
        tintColor: String,
        selectedString: Binding<String>,
        action: (() -> ())? = nil
    ) {
        self.action = action
        self.title = title
        self.tintColor = tintColor
        self.iconName = iconName
        _selectedString = selectedString
    }

    var body: some View {
        let selected = selectedString == title
        
        let tintColor = Color(.hexColor(self.tintColor))
        

        Button {
            withAnimation() {
                let state = self.selectedString == self.title
                self.selectedString = state ? "" : self.title
            }
            if let action { action() }
        } label: {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: self.iconName)
                    .renderingMode(.template)
                Text(self.title)
                    .font(Font((self.footnote) as CTFont))
            }
            .font(.system(size: 14, weight: .medium, design: .default))
            .foregroundStyle(tintColor.opacity(selected ? 1 : 0.5))
            .scaledToFit()
            .padding(.horizontal, 8)
            .frame(minWidth: 80, minHeight: 50,  alignment: .center)
            
            .background(
                ZStack {
                    let rect = RoundedRectangle(cornerRadius: 16)
                    rect.fill(tintColor.opacity(
                        selected ? 0.14 : 0.07
                    ))
                    rect.stroke(
                        selected ? tintColor : Color.clear
                        , lineWidth: 1)
                }
            )
        }
    }
}


struct ChipsButton_Test_Preview: View {
    
    @State var some: String = "Meaning"
    @StateObject var vm: MoonCalendarViewModel = MoonCalendarViewModel()

    var body: some View {
        VStack {
            ForEach(Array(vm.chipsDataModels.enumerated()), id: \.offset) { offset, model in
                ChipsButton(
                    title: model.title,
                    iconName: model.iconName,
                    tintColor: model.HEX,
                    selectedString: $some
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
    }
}

#Preview {
    ChipsButton_Test_Preview()
}

//let chipsModel
struct ChipsModel {
    let title, iconName, HEX: String
}
