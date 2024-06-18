//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.06.2024.
//

import Foundation
import UIKit
//struct CollectionModel
// Sections
struct CollectionModel {
    let type: ModelType
    var sections: [SectionModel]
}
//// Type
enum ModelType {
    case standart
}
// Section
//struct SectionModel {
//    let sectionTitle: String?
//    var sectionCells: [TrendsCellModel]
//}
struct SectionModel {
    let sectionTitle: String?
    var sectionCells: [TrendsCellModel]
}

// Cell Type
//enum CellSectionType: Hashable {
//    case regularCell(model: TrendsCellModel)
//}

// Cell
struct TrendsCellModel {
    var articleID: String?
    //
    var article: String?
    var cardText: String?
    var cardTitle: String?
    //
    var imageTitle: String
    var image: UIImage?
    var isPremium: Bool
    var likes: Int
    //
    var handler: (() -> Void)? = nil
}
