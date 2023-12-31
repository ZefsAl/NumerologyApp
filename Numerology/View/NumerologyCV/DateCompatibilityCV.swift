//
//  DateCompatibilityCV.swift
//  Numerology
//
//  Created by Serj on 11.11.2023.
//

import UIKit

class DateCompatibilityCV: UICollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
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
            heightDimension: NSCollectionLayoutDimension.absolute(160)
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
        self.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell().cardCollectionID)
        // Header
        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
        // Footer
        self.register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterView.reuseID)
    }
    
}


// MARK: Delegate
extension DateCompatibilityCV: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //  Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            sectionHeader?.label.text = "Compatibility"
            return sectionHeader ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell().cardCollectionID, for: indexPath as IndexPath) as! CardCollectionViewCell
        
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let name = UserDefaults.standard.object(forKey: "nameKey") as? String
        let surname = UserDefaults.standard.object(forKey: "surnameKey") as? String
        
        if indexPath.row == 0 {
            cell.configure(
                title: "Unveil your compatibility!",
                subtitle: "Explore the depths of your compatibility with your partner. Discover the secrets hidden within the alignment of your birthdates. The stars have a story to tell, and it's all about your extraordinary connection!",
                bgImage: nil
            )
            return cell
        }

        return cell
        
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        // MARK: Soul // 0
        if indexPath.row == 0 {
            
//            guard self.checkAccessContent() == true else { return }
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            
            
            let vc = ThirdViewController()
            vc.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
            
        }

    }
}
