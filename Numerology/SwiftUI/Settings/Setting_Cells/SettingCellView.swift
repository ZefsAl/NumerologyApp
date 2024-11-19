//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

// MARK: - SettingCellView
struct SettingCellView<CustomView: View>: View {
    
    var actionHandler: (() -> Void)? = nil
    var customView: CustomView?
    
    enum CellType {
        case toggle, chevron
    }
    
    let model: Setting?
    
    @State private var isPressed: Bool = false

    var body: some View {
        Button {
            if let actionHandler = actionHandler {
                actionHandler()
            }
        } label: {
            HStack {
                ZStack {
                    Image(systemName: model?.imageName ?? "")
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 29, height: 29)
                .foregroundColor(.white)
                .background(model?.color)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                // Title
                Text(model?.title ?? "")
                if let customView = customView {
                    Spacer()
                    customView
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}


