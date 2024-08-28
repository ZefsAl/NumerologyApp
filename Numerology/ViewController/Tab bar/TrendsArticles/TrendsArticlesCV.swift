//
//  NumerologyVC_2024.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.04.2024.
//

import Foundation
import UIKit

final class TrendsArticlesCV: UICollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    let trendsArticlesVM = TrendsArticlesVM.shared
    
//    let premiumBadgeManager = PremiumBadgeManager()
    
    // MARK: - init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        //
        register()
        setCompositionalLayoutCV(model: self.trendsArticlesVM.trendsArticlesModel)
        requestData()
    }
    
    private func register() {
        // Delegates
        self.dataSource = self
        self.delegate = self
        // cell
        self.register(TrendsCell.self, forCellWithReuseIdentifier: TrendsCell.reuseID)
        // Header
        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
        self.trendsArticlesVM.setLikeNotification(observer: self, action: #selector(self.notificationLikeAction(notification:)))
    }
    
    
    @objc private func notificationLikeAction(notification: Notification) {
        print("🟣🟢 notificationLikeAction 🟣🟢")
        DispatchQueue.main.async {
            self.reloadData()
        }
        // что в логах ??
    }
    
    
    func requestData() {
        // 1
        let numerologyIDs = [
            0 : TrendsFieldID.numerologyID_1,
            1 : TrendsFieldID.numerologyID_2,
            2 : TrendsFieldID.numerologyID_3,
        ]
        // 2
        let astrologyIDs = [
            0 : TrendsFieldID.astrologyID_1,
            1 : TrendsFieldID.astrologyID_2,
            2 : TrendsFieldID.astrologyID_3,
            3 : TrendsFieldID.astrologyID_4,
        ]
        // 3
        let symbolsOfLife = [
            0 : TrendsFieldID.symbolsOfLifeID_1,
            1 : TrendsFieldID.symbolsOfLifeID_2,
            2 : TrendsFieldID.symbolsOfLifeID_3,
            3 : TrendsFieldID.symbolsOfLifeID_4,
            4 : TrendsFieldID.symbolsOfLifeID_5,
            5 : TrendsFieldID.symbolsOfLifeID_6,
            6 : TrendsFieldID.symbolsOfLifeID_7,
        ]
        // 4
        let chakras = [
            0 : TrendsFieldID.chakrasID_1,
            1 : TrendsFieldID.chakrasID_2,
            2 : TrendsFieldID.chakrasID_3,
            3 : TrendsFieldID.chakrasID_4,
            4 : TrendsFieldID.chakrasID_5,
            5 : TrendsFieldID.chakrasID_6,
            6 : TrendsFieldID.chakrasID_7,
            7 : TrendsFieldID.chakrasID_8,
            8 : TrendsFieldID.chakrasID_9,
            9 : TrendsFieldID.chakrasID_10,
            10 : TrendsFieldID.chakrasID_11,
            11 : TrendsFieldID.chakrasID_12,
            12 : TrendsFieldID.chakrasID_13,
            13 : TrendsFieldID.chakrasID_14,
            14 : TrendsFieldID.chakrasID_15,
        ]
        // 5
        let usefulIDs = [
            0 : TrendsFieldID.usefulID_1,
            1 : TrendsFieldID.usefulID_2,
            2 : TrendsFieldID.usefulID_3,
            3 : TrendsFieldID.usefulID_4,
            4 : TrendsFieldID.usefulID_5,
        ]
        
        let sections = [
            0 : numerologyIDs,
            1 : astrologyIDs,
            2 : symbolsOfLife,
            3 : chakras,
            4 : usefulIDs,
        ]
        
        DispatchQueue.main.async {
            for (sectionKey, sectionOfIDs) in sections {
                for (cellKey, articleID) in sectionOfIDs {
                    TrendsArticlesManager.shared.getTrendsArticles(articleID: articleID) { model, image, id in
                        
                        let model = TrendsCellModel(
                            articleID: id,
                            article: model.article,
                            cardText: model.cardText,
                            cardTitle: model.cardTitle,
                            imageTitle: model.imageTitle,
                            image: image,
                            isPremium: model.isPremium ?? false,
                            likes: model.likes
                        )
                        
                        self.trendsArticlesVM.trendsArticlesModel.sections[sectionKey].sectionCells[cellKey] = model
                        self.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: Data Source
extension TrendsArticlesCV: UICollectionViewDataSource {
    
    // MARK: - Sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.trendsArticlesVM.trendsArticlesModel.sections.count
    }
    
    // MARK: - Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.trendsArticlesVM.trendsArticlesModel.sections[section].sectionCells.count
    }

    // MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendsCell.reuseID,
            for: indexPath as IndexPath
        ) as! TrendsCell
        
        cell.trendsView.remoteOpenDelegate = remoteOpenDelegate
        cell.trendsView.remoteOpenDelegate?.openFrom = remoteOpenDelegate?.openFrom
        
        let model = self.trendsArticlesVM.trendsArticlesModel.sections[indexPath.section].sectionCells[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }

    // MARK: - Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            let title = self.trendsArticlesVM.trendsArticlesModel.sections[indexPath.section].sectionTitle
            sectionHeader?.label.text = title
            sectionHeader?.label.textColor = DesignSystem.TrendsArticles.textColor
            return sectionHeader ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
}

// MARK: - Flow layout
extension TrendsArticlesCV: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = self.trendsArticlesVM.trendsArticlesModel.sections[indexPath.section].sectionCells[indexPath.row]
        
        let vc = DatailTrendsArticlesVC(model: model, visibleConstant: 150)
        self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Compositional Layout
extension TrendsArticlesCV {
    // MARK: - Layout
    private func setCompositionalLayoutCV(model: CollectionModel) {
        // Compositional Layout
        let collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let section = model.sections[sectionIndex]
            // Должны вернуть NSCollectionLayoutSection для конкретной секции
            return self.setSectionLayout(sectionItems: section.sectionCells, environment: environment)
        }
        // Collection View
        self.collectionViewLayout = collectionViewLayout
    }
    
    private func setSectionLayout(sectionItems: [TrendsCellModel], environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        // ✅ group == itemSize т.к должна быть видна следующая карточка
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(220)
        )
        // orig
        let items: [NSCollectionLayoutItem] = sectionItems.compactMap({ _ in
                .init(layoutSize: itemSize)
        })
        
        let trailingMargin: CGFloat = 36
        //
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: items )
        group.accessibilityScroll(.right)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: trailingMargin)
        //
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = -trailingMargin
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
        section.boundarySupplementaryItems = [headerItem]
        section.supplementariesFollowContentInsets = false
        
        return section
    }
    
    // headerItem + used data source
    private var headerItem: NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}
