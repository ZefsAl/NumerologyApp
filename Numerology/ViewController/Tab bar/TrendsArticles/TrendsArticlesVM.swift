//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.06.2024.
//

import Foundation
import UIKit

class TrendsArticlesVM {
    
    private var premiumSetting: Bool = true
    private var freeSetting: Bool = false
    
    var trendsArticlesModel: CollectionModel = CollectionModel(
        type: .standart,
        sections: [
//            SectionModel(
//                sectionTitle: "Astrology trends",
//                sectionCells: [
//                    TrendsCellModel(
//                            imageTitle: "",
//                            image: nil,
//                            isPremium: false,
//                            likes: 0
//                    ),
//                ]),
        ]
    )
    func completeData() {
        var astrology = SectionModel(sectionTitle: "Astrology", sectionCells: [])
        for _ in 0...2 {
            astrology.sectionCells.append(
                TrendsCellModel(
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
    
    // MARK: - init
    init() {
        completeData()
    }
    
//    private func checkActiveSubscription() {
//        // Hide premium badge
//        guard
//            let premium = UserDefaults.standard.object(forKey: "UserIsPremiumObserverKey") as? Bool
//        else { return }
//        self.premiumSetting = premium ? false : true
//    }
    
//    func requestAstrologyTrends() {
//        TrendsArticlesManager.shared.getTrendsArticles(articleID: .horoscopeID_1) { model, image in
//            print(model.article)
//            print(model.cardText)
//            print(model.cardTitle)
//            print(model.isPremium)
//            print(model.likes)
//            
//            self.trendsArticlesModel.sections[0].sectionCells.append(
//                CellSectionType.regularCell(
//                    model: TrendsCellModel(
//                        imageTitle: model.imageTitle,
//                        image: image,
//                        isPremium: model.isPremium,
//                        likes: model.likes
//                    )
//                )
//            )
//        }
//        
//    }
    
//    private func configEffectData() {
//        trendsArticlesModel = CollectionModel(
//            type: .standart,
//            sections: [
//                // 1
//                SectionModel(
//                    sectionTitle: "Astrology trends",
//                    sectionCells: [
//                        CellSectionType.regularCell(
//                            model: TrendsCellModel(
//                                title: "test1",
//                                isPremium: true
//                            )),
//                        CellSectionType.regularCell(
//                            model: TrendsCellModel(
//                                title: "test1",
//                                isPremium: true
//                            )),
//                        CellSectionType.regularCell(
//                            model: TrendsCellModel(
//                                title: "test1",
//                                isPremium: true
//                            )),
//                    ]),
//                // 2
//                SectionModel(
//                    sectionTitle: "Numerology trends",
//                    sectionCells: [
//                        CellSectionType.regularCell(
//                            model: TrendsCellModel(
//                                title: "test1",
//                                isPremium: true
//                            )),
//                        CellSectionType.regularCell(
//                            model: TrendsCellModel(
//                                title: "test1",
//                                isPremium: true
//                            )),
//                    ]),
//                // 3
//                SectionModel(
//                    sectionTitle: "General",
//                    sectionCells: [
//                        CellSectionType.regularCell(
//                            model: TrendsCellModel(
//                                title: "test1",
//                                isPremium: true
//                            )),
//                        CellSectionType.regularCell(
//                            model: TrendsCellModel(
//                                title: "test1",
//                                isPremium: true
//                            )),
//                    ]),
//                
//            ])
//    }
}




