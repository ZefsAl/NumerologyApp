////
////  CompatibilityHrscp.swift
////  Numerology
////
////  Created by Serj_M1Pro on 31.07.2024.
////
//
//import Foundation
//import UIKit
//
//
//
//class CompatibilityHrscpCV: UICollectionView {
//    
//    let horoscopeDescriptionVC = HoroscopeDescriptionVC()
//    
//    var remoteOpenDelegate: RemoteOpenDelegate? = nil
//    
//    // MARK: - init
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
//        self.backgroundColor = .clear
//        
//        register()
//        setCompositionalLayoutCV()
//        self.backgroundColor = .black
//    }
//    
//    
//    // MARK: - Layout
////    private func setupCV_Layout() {
////        let size = NSCollectionLayoutSize(
////            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
////            heightDimension: NSCollectionLayoutDimension.absolute(230)
////        )
////        
////        let item = NSCollectionLayoutItem(layoutSize: size)
////        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
////        group.accessibilityScroll(.right)
////        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
////        
////        let section = NSCollectionLayoutSection(group: group)
////        
////        section.boundarySupplementaryItems = [headerItem,footerItem]
////        section.supplementariesFollowContentInsets = false
////        section.interGroupSpacing = 18
////        section.orthogonalScrollingBehavior = .groupPaging
////        
////        let layout = UICollectionViewCompositionalLayout(section: section)
////        
////        self.collectionViewLayout = layout
////        self.alwaysBounceVertical = false
////    }
//    
//    // MARK: - Layout
//    private func setCompositionalLayoutCV() {
//        // Compositional Layout
//        let collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
//            guard let self = self else { return nil }
////            let section = model.sections[sectionIndex]
////            let section = compatibilitySignsData.
//            
//            // Должны вернуть NSCollectionLayoutSection для конкретной секции
//            return self.setSectionLayout(sectionItems: compatibilitySignsData, environment: environment)
//        }
//        // Collection View
//        self.collectionViewLayout = collectionViewLayout
//    }
//    
//    private func setSectionLayout(sectionItems: [CompatibilitySignsModel], environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//        
//        // ✅ group == itemSize т.к должна быть видна следующая карточка
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(260)
//        )
//        
//        
//        
//        // orig
//        let items: [NSCollectionLayoutItem] = sectionItems.compactMap({ _ in
//                .init(layoutSize: itemSize)
//        })
//        
//        let trailingMargin: CGFloat = 0
//        //
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: items )
//        group.accessibilityScroll(.right)
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: trailingMargin)
//        
//        //
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = -trailingMargin
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
//        section.boundarySupplementaryItems = [headerItem,footerItem]
//        section.supplementariesFollowContentInsets = false
//        
//        return section
//    }
//    
//    // header Item + used Delegate
//    private var headerItem: NSCollectionLayoutBoundarySupplementaryItem {
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .estimated(50)
//        )
//        
//        return NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .topLeading
//        )
//    }
//    // footer Item
//    private var footerItem: NSCollectionLayoutBoundarySupplementaryItem {
//        let footerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .estimated(86)
//        )
//        
//        return NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: footerSize,
//            elementKind: UICollectionView.elementKindSectionFooter,
//            alignment: .bottomLeading
//        )
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func register() {
//        // Delegate Collection View
//        self.delegate = self
//        self.dataSource = self
//        self.register(CompatibilityHrscpCell.self, forCellWithReuseIdentifier: CompatibilityHrscpCell.reuseID)
//        // Header
//        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
//        // Footer
//        self.register(CompatibilityHrscpFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CompatibilityHrscpFooter.reuseID)
//    }
//    
//}
//
//
//// MARK: Delegate
//extension CompatibilityHrscpCV: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    //  Supplementary Element
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        // header
//        if kind == UICollectionView.elementKindSectionHeader {
//            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
//            sectionHeader?.label.text = "Compatibility of Signs"
//            sectionHeader?.label.textColor = #colorLiteral(red: 0.6980392157, green: 0.6901960784, blue: 0.9725490196, alpha: 1)
//            return sectionHeader ?? UICollectionReusableView()
//        }
//        // footer 
//        if kind == UICollectionView.elementKindSectionFooter {
//            let sectionFooter = collectionView.dequeueReusableSupplementaryView(
//                ofKind: kind,
//                withReuseIdentifier: CompatibilityHrscpFooter.reuseID,
//                for: IndexPath(item: 0, section: 0)
//            ) as? CompatibilityHrscpFooter
//            return sectionFooter ?? UICollectionReusableView()
//        }
//        
//        return UICollectionReusableView()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return compatibilitySignsData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: CompatibilityHrscpCell.reuseID,
//            for: indexPath as IndexPath
//        ) as! CompatibilityHrscpCell
//        
////        let name = UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as? String
//        
//        
////        cell.configure(
////            title: compatibilitySignsData[indexPath.row].title,
////            setImage: compatibilitySignsData[indexPath.row].image
////        )
//        return cell
//        
//    }
//    
//    // MARK: did Select ItemAt
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
////        if indexPath.row == 0 {
////            let navVC = UINavigationController(rootViewController: horoscopeDescriptionVC)
////            navVC.modalPresentationStyle = .overFullScreen
////            self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
////        }
//
//    }
//}
//
//
//
////let compatibilitySignsData = [
////    CompatibilitySignsModel(title: "1", image: UIImage(named: "Aquarius-CMPTB")),
////    CompatibilitySignsModel(title: "2", image: UIImage(named: "Aquarius-CMPTB")),
////    CompatibilitySignsModel(title: "3", image: UIImage(named: "Aquarius-CMPTB"))
////
////]
////
////struct CompatibilitySignsModel {
////    let title: String
////    let image: UIImage?
////}
//
