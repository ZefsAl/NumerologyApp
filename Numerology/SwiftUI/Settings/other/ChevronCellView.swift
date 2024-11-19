//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 30.10.2024.
//

import SwiftUI

struct ChevronCellView: View {
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(uiColor: .systemGray3))
            }
        }
    }
}
