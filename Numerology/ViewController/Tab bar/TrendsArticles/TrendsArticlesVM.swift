//

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
        setEmptyData()

    }
    
    func setLikeNotification(observer: Any, action: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: action,
            name: Notification.Name(TrendsArticlesVM.notificationKey),
            object: nil
        )
    }
    
    func updateLikes(model: inout CollectionModel, likeValue: Int, articleID: String?) {
        for sectionIndex in 0..<model.sections.count {
            for cellIndex in 0..<model.sections[sectionIndex].sectionCells.count {
                if model.sections[sectionIndex].sectionCells[cellIndex].articleID == articleID {
                    model.sections[sectionIndex].sectionCells[cellIndex].likes = likeValue < 0 ? 0 : likeValue
                    return 
                }
            }
        }
    }
    
    private func setEmptyData() {

        var astrology = SectionModel(sectionTitle: "Numerology", sectionCells: [])
        for _ in 0...2 {
            astrology.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: nil,
                    cardText: nil,
                    cardTitle: nil,
                    imageTitle: "",
                    image: nil,
                    isPremium: false,
                    likes: 0
                )
            )
        }
        trendsArticlesModel.sections.append(astrology)
        
        var numerology = SectionModel(sectionTitle: "Astrology", sectionCells: [])
        for _ in 0...3 {
            numerology.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: nil,
                    cardText: nil,
                    cardTitle: nil,
                    imageTitle: "",
                    image: nil,
                    isPremium: false,
                    likes: 0
                )
            )
        }
        trendsArticlesModel.sections.append(numerology)
        
        
        
        var symbolsOfLife = SectionModel(sectionTitle: "Symbols of Life.", sectionCells: [])
        
        for _ in 0...6 {
            symbolsOfLife.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: nil,
                    cardText: nil,
                    cardTitle: nil,
                    imageTitle: "",
                    image: nil,
                    isPremium: false,
                    likes: 0
                )
            )
        }
        trendsArticlesModel.sections.append(symbolsOfLife)
        
        
        var chakras = SectionModel(sectionTitle: "Chakras", sectionCells: [])
        for _ in 0...14 {
            chakras.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: nil,
                    cardText: nil,
                    cardTitle: nil,
                    imageTitle: "",
                    image: nil,
                    isPremium: false,
                    likes: 0
                )
            )
        }
        trendsArticlesModel.sections.append(chakras)
        
        
        
        
        
        
        var useful = SectionModel(sectionTitle: "Useful", sectionCells: [])
        for _ in 0...4 {
            useful.sectionCells.append(
                TrendsCellModel(
                    articleID: nil,
                    article: nil,
                    cardText: nil,
                    cardTitle: nil,
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




