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
struct SectionModel {
    let sectionTitle: String?
    var sectionCells: [TrendsCellModel]
}
// Cell Type
enum CellSectionType {
    case regularCell(model: TrendsCellModel)
}
// Cell
struct TrendsCellModel {
    let article: String? 
    let cardText: String? 
    let cardTitle: String? 
    //
    let imageTitle: String
    let image: UIImage?
    let isPremium: Bool
    let likes: Int
    let handler: (() -> Void)? = nil
}



struct DiffableSectionModel: Hashable {
    var id = UUID().uuidString
    let sectionTitle: String
//    var sectionCells: [DiffableCellModel]
}



struct DiffableCellModel: Hashable {
    let id = UUID().uuidString
    //
    let article: String? = nil
    let cardText: String? = nil
    let cardTitle: String? = nil
    //
    let imageTitle: String
    let image: UIImage?
    let isPremium: Bool
    let likes: Int
//    let handler: (() -> Void)? = nil
}
