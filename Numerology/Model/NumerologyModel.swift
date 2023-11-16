//
//  NumerologyModel.swift
//  Numerology
//
//  Created by Serj on 21.10.2023.
//

import Foundation
import UIKit


struct NumerologyCVModel {
    var sections: [ContentSection]
}

// Data Model
struct ContentSection {
    let sectionTitle: String?
    var sectionCells: [CellSectionType]
}

enum CellSectionType {
    case bigrCell(model: BigCell)
}

struct BigCell {
    let title: String?
    let info: String?
    let about: String?
    let imageName: UIImage?
    let handler: (() -> Void)
}
