//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 22.05.2024.
//

import UIKit

class PythagoreanSquareCV: UICollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    let pythagoreanSquareCVCell = PythagoreanSquareCVCell()
    
    // MARK: - init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.backgroundColor = .clear
        
        register()
        setupCV_Layout()
    }
    
    
    // MARK: - Layout
    private func setupCV_Layout() {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.absolute(300)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        group.accessibilityScroll(.right)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [headerItem]
        section.supplementariesFollowContentInsets = false
        section.interGroupSpacing = 18
        section.orthogonalScrollingBehavior = .groupPaging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        self.collectionViewLayout = layout
        self.alwaysBounceVertical = false
    }
    
    // headerItem + used Delegate
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func register() {
        // Delegate Collection View
        self.delegate = self
        self.dataSource = self
        self.register(PythagoreanSquareCVCell.self, forCellWithReuseIdentifier: PythagoreanSquareCVCell().cardCollectionID)
        // Header
        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
    }
    
}


// MARK: Delegate
extension PythagoreanSquareCV: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //  Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            sectionHeader?.label.text = "Psychomatrix"
            return sectionHeader ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: pythagoreanSquareCVCell.cardCollectionID,
            for: indexPath as IndexPath) as! PythagoreanSquareCVCell
        

        return cell
        
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard 
            indexPath.row == 0 &&
            pythagoreanSquareCVCell.content.pythagoreanDetailDataModels.isEmpty == false
        else { return }
        
        let vc = PythagoreanSquareDetailVC()
        vc.configureHandleDataModels(
            models: pythagoreanSquareCVCell.content.pythagoreanDetailDataModels
        )
        vc.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .overFullScreen
        self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
        
    }
}
