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
    
    let trendsArticlesVM = TrendsArticlesVM()
    
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
//        self.backgroundColor = .clear
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        
        self.backgroundColor = .systemGray6
        
        register()
        setCompositionalLayoutCV(model: self.trendsArticlesVM.trendsArticlesModel)
        requestData()
    }
    
    
//    private func remoteOpen() {
//        // date Compatibility CV
//        dateCompatibilityCV.remoteOpenDelegate = self
//        dateCompatibilityCV.remoteOpenDelegate?.openFrom = self
//        // your numerology CV
//        yournumerologyCV.remoteOpenDelegate = self
//        yournumerologyCV.remoteOpenDelegate?.openFrom = self
//        // personal Predictions CV
//        personalPredictionsCV.remoteOpenDelegate = self
//        personalPredictionsCV.remoteOpenDelegate?.openFrom = self
//        // about CV
//        aboutCV.remoteOpenDelegate = self
//        aboutCV.remoteOpenDelegate?.openFrom = self
//        // your Money CV
//        yourMoneyCV.remoteOpenDelegate = self
//        yourMoneyCV.remoteOpenDelegate?.openFrom = self
//        // angel Numbers CV
//        angelNumbersCV.remoteOpenDelegate = self
//        angelNumbersCV.remoteOpenDelegate?.openFrom = self
//        // pythagorean Square CV
//        pythagoreanSquareCV.remoteOpenDelegate = self
//        pythagoreanSquareCV.remoteOpenDelegate?.openFrom = self
//
//        self.openFrom = self
//    }
    
    private func register() {
        // Delegates
        self.dataSource = self
        self.delegate = self
        // cell
        self.register(TrendsCell.self, forCellWithReuseIdentifier: TrendsCell.reuseID)
        // Header
        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
        //
    }
    @objc func shareCellAction() {
        self.remoteOpenDelegate?.openFrom?.shareButtonClicked()
    }
    
    func requestData() {
        
        let astrologyIDs = [
            0 : TrendsFieldID.astrologyID_1,
            1 : TrendsFieldID.astrologyID_2,
            2 : TrendsFieldID.astrologyID_3,
        ]
        let numerologyIDs = [
            0 : TrendsFieldID.numerologyID_1,
            1 : TrendsFieldID.numerologyID_2,
            2 : TrendsFieldID.numerologyID_3,
            3 : TrendsFieldID.numerologyID_4,
        ]
        let usefulIDs = [
            0 : TrendsFieldID.usefulID_1,
            1 : TrendsFieldID.usefulID_2,
            2 : TrendsFieldID.usefulID_3,
            3 : TrendsFieldID.usefulID_4,
            4 : TrendsFieldID.usefulID_5,
        ]
        
        let sections = [
            0 : astrologyIDs,
            1 : numerologyIDs,
            2 : usefulIDs,
        ]
        
        DispatchQueue.main.async {
            for (sectionKey, sectionOfIDs) in sections {
                for (cellKey, articleID) in sectionOfIDs {
                    TrendsArticlesManager.shared.getTrendsArticles(articleID: articleID) { model, image in
//                        let model = TrendsCellModel(
//                            imageTitle: model.imageTitle,
//                            image: image,
//                            isPremium: model.isPremium ?? false,
//                            likes: model.likes
//                        )
                        
                        let model = TrendsCellModel(
                            article: model.article,
                            cardText: model.cardText,
                            cardTitle: model.cardTitle,
                            imageTitle: model.imageTitle,
                            image: image,
                            isPremium: model.isPremium ?? false,
                            likes: model.likes
                        )
                        print("🔴⚠️🌕 section",sectionKey,"cell",cellKey,model.isPremium)
                        
                        self.trendsArticlesVM.trendsArticlesModel.sections[sectionKey].sectionCells[cellKey] = model
                        self.reloadData()
                    }
                }
            }
        }
        
        
        
        
//            DispatchQueue.main.async {
//                TrendsArticlesManager.shared.getTrendsArticles(articleID: TrendsFieldID.astrologyID_1 ) { model, image in
//                    let model = TrendsCellModel(
//                        imageTitle: model.imageTitle,
//                        image: image,
//                        isPremium: model.isPremium ?? false,
//                        likes: model.likes
//                    )
//                    
//                    self.trendsArticlesVM.trendsArticlesModel.sections[0].sectionCells[0] = model
//                    self.reloadData()
//            }
            
//        }
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

    // MARK: - cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendsCell.reuseID,
            for: indexPath as IndexPath
        ) as! TrendsCell
        
        cell.shareButton.addTarget(self, action: #selector(shareCellAction), for: .touchUpInside)
        
        let row = self.trendsArticlesVM.trendsArticlesModel.sections[indexPath.section].sectionCells[indexPath.row]
        
        cell.configure(
//            imageTitle: row.imageTitle,
            imageTitle: row.article ?? "error" ,
            bgImage: row.image,
            isPremium: row.isPremium,
            likes: row.likes
        )
        
//        switch indexPath {
//        case [0, 0]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.astrologyID_1, cell: cell)
//            return cell
//        case [0, 1]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.astrologyID_2, cell: cell)
//            return cell
//        case [0, 2]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.astrologyID_3, cell: cell)
//            return cell
//        //
//        case [1, 0]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.numerologyID_1, cell: cell)
//            return cell
//        case [1, 1]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.numerologyID_2, cell: cell)
//            return cell
//        case [1, 2]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.numerologyID_3, cell: cell)
//            return cell
//        case [1, 3]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.numerologyID_4, cell: cell)
//            return cell
//        //
//        case [2, 0]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.usefulID_1, cell: cell)
//            return cell
//        case [2, 1]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.usefulID_2, cell: cell)
//            return cell
//        case [2, 2]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.usefulID_3, cell: cell)
//            return cell
//        case [2, 3]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.usefulID_4, cell: cell)
//            return cell
//        case [2, 4]:
//            self.makeRequestAndCell(articleID: TrendsFieldID.usefulID_5, cell: cell)
//            return cell
//            
//        default:
//            break
//        }
        
        
        
        return cell
    }
    
    private func makeRequestAndCell(articleID: String, cell: TrendsCell) {
        DispatchQueue.main.async {
            TrendsArticlesManager.shared.getTrendsArticles(articleID: articleID) { model, image in
                cell.configure(
                    imageTitle: model.imageTitle,
                    bgImage: image,
                    isPremium: model.isPremium ?? false,
                    likes: model.likes
                )
            }
        }
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
        
        print("TAP cell TrendsArticlesCV✅",indexPath)
        let vc = DatailTrendsArticlesVC()
        vc.configureUI(model: model, visibleConstant: 150)
        
        
//        vc.view.backgroundColor = .red
        
        vc.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .overFullScreen
        self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: ((collectionView.frame.size.width-36)/2)-8, height: 112)
//    }
//    
//    
//    // Vertical spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 24
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 24
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
//        return CGSize(width: collectionView.frame.width, height: 50)
//    }
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
        
//        let items: [NSCollectionLayoutItem] = {
//            // костыль что бы не падала прила
//            if sectionItems.isEmpty {
//                return [NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .estimated(0),
//                    heightDimension: .estimated(0)
//                ))]
//            } else {
//                let val: [NSCollectionLayoutItem] = sectionItems.compactMap({ _ in
//                        .init(layoutSize: itemSize)
//                })
//                return val 
//            }
//        }()
        
        
            
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
