//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.06.2024.
//

import Foundation
import UIKit

final class TrendsArticlesVM {
    
    static let shared = TrendsArticlesVM()
    static let notificationKey = "TrendsArticlesNotificationKey"
    
    
    var trendsArticlesModel: CollectionModel = CollectionModel(
        type: .standart,
        sections: []
    )
    
    
    // MARK: - init
    init() {
        presetData()
//        setListener()
//        self.setLikeNotification(observer: self, action: #selector(self.notificationLikeAction(notification:)))
    }
    
//    @objc private func notificationLikeAction(notification: Notification) {
//        guard let bool = notification.object as? Bool else { return }
//        print("notificationLikeAction 🟣🟢 get ", bool)
//        // что в логах ??
//    }
    
    func setLikeNotification(observer: Any, action: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: action,
            name: Notification.Name(TrendsArticlesVM.notificationKey),
            object: nil
        )
    }
    
    
//    func updatecCellModel(in model: inout CollectionModel, to newModel: TrendsCellModel, for articleID: String?) {
//        for sectionIndex in 0..<model.sections.count {
//            for cellIndex in 0..<model.sections[sectionIndex].sectionCells.count {
//                if model.sections[sectionIndex].sectionCells[cellIndex].articleID == articleID {
//                    model.sections[sectionIndex].sectionCells[cellIndex] = newModel
//                    return // выходим из функции, так как элемент найден и обновлен
//                }
//            }
//        }
//    }
//    
    func updateLikes(model: inout CollectionModel, likeValue: Int, articleID: String?) {
        for sectionIndex in 0..<model.sections.count {
            for cellIndex in 0..<model.sections[sectionIndex].sectionCells.count {
                if model.sections[sectionIndex].sectionCells[cellIndex].articleID == articleID {
                    model.sections[sectionIndex].sectionCells[cellIndex].likes = likeValue < 0 ? 0 : likeValue
                    return // выходим из функции, так как элемент найден и обновлен
                }
            }
        }
    }
    
    
    
    
    private func presetData() {

        var astrology = SectionModel(sectionTitle: "Astrology", sectionCells: [])
        for _ in 0...2 {
            astrology.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: "",
                    cardText: "",
                    cardTitle: "",
                    imageTitle: "",
                    image: nil,
                    isPremium: false,
                    likes: 0
                )
            )
        }
        trendsArticlesModel.sections.append(astrology)
        
        var numerology = SectionModel(sectionTitle: "Numerology", sectionCells: [])
        for _ in 0...3 {
            numerology.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: "",
                    cardText: "",
                    cardTitle: "",
                    imageTitle: "",
                    image: nil,
                    isPremium: false,
                    likes: 0
                )
            )
        }
        trendsArticlesModel.sections.append(numerology)
        
        var useful = SectionModel(sectionTitle: "Useful", sectionCells: [])
        for _ in 0...4 {
            useful.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: "",
                    cardText: "",
                    cardTitle: "",
                    imageTitle: "",
                    image: nil,
                    isPremium: false,
                    likes: 0
                )
            )
        }
        trendsArticlesModel.sections.append(useful)
    }
}




