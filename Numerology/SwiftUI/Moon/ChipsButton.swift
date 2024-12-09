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

    
    
    private let footnote = DesignSystem.SourceSerifProFont.footnote_Sb_13!
    
    init(
        title: String,
        iconName: String,
        selectedString: Binding<String>,
        action: (() -> ())? = nil
    ) {
        self.action = action
        self.title = title
        self.iconName = iconName
        _selectedString = selectedString
    }

    var body: some View {
        let selected = selectedString == title

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
            .foregroundStyle(.white)
            .scaledToFit()
            .padding(.horizontal, 8)
            .frame(minHeight: 30, alignment: .center)
            .background(
                ZStack {
                    let rect = RoundedRectangle(cornerRadius: 16)
                    rect.fill(selected ? Color(DesignSystem.MoonColors.darkTint).opacity(0.7) : .clear)
                    rect.stroke(
                        selected ? Color(DesignSystem.MoonColors.mediumTint) : Color.clear
                        , lineWidth: 1)
                }
            )
        }
    }
}

#Preview {
    ChipsButton_CUST_Preview()
}

struct ChipsButton_CUST_Preview: View {
    
    @State var some: String = "Meaning"
    @StateObject var vm: MoonCalendarViewModel = MoonCalendarViewModel()

    var body: some View {
        VStack {
            ForEach(Array(vm.chipsDataModels.enumerated()), id: \.offset) { offset, model in
                ChipsButton(title: model.title, iconName: model.iconName, selectedString: $some)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
    }
}


//let chipsModel
struct ChipsModel {
    let title, iconName: String
}
