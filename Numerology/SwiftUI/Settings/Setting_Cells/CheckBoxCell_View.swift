//
//  SwiftUIView.swift
//  MapApp
//
//  Created by Serj_M1Pro on 10.10.2024.
//

import SwiftUI

struct CheckBoxCellView: View {
    let title: String
    @Binding var selectedMelody: String
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.13)) {
                self.selectedMelody = self.title
            }
            UserDefaults.standard.set(self.selectedMelody, forKey: UserDefaultsKeys.selectedMelody)
            UserDefaults.standard.synchronize()
        } label: {
            HStack(){
                ZStack {
                    Image(systemName: (title == selectedMelody) ?
                          "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                }
                .frame(width: 29, height: 29)
                Text(title)
            }
        }
        .tint((title == selectedMelody) ? .white : .gray )
    }
}


//#Preview {
//    CheckBoxCellView(
//        title: "Testst",
//        singleSelect: MusicViewModel().$selectedMelody
//    )
//}
