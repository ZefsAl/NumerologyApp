//
//  NumerologyModel.swift
//  Numerology
//
//  Created by Serj on 21.10.2023.
//

import Foundation
import UIKit


enum EditSettingsModelType {
    case effect
    case text
    case background
}


struct EditSettingsModel {
    let editSettingsModelType: EditSettingsModelType
    let sections: [ContentSection]
    
}

// Data Model
struct ContentSection {
    let sectionTitle: String?
    let sectionCells: [CellSectionType]
}

enum CellSectionType {
    case bigrCell(model: BigCell)
}

struct BigCell {
    let title: String?
    let iconSystemName: String?
    let bgColor: UIColor?
    let fontName: String?
    let handler: (() -> Void)
}
