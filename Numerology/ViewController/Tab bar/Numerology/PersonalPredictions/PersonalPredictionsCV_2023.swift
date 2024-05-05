//  PersonalPredictionsCV.swift
//  Numerology
//
//  Created by Serj on 10.11.2023.
//

import UIKit


class PersonalPredictionsCV: UICollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // models instance
//    private var boardOfDayModel: BoardOfDayModel?
    private var personalDayModel: PersonalDayModel?
    private var personalMonthModel: PersonalMonthModel?
    private var personalYearModel: PersonalYearModel?
    private var lifeStagesModel: LifeStagesModel?
    
    // MARK: Page Control
    private let numerologyPC: UIPageControl = {
        let pc = UIPageControl()
        pc .translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 4
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    // MARK: - init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.backgroundColor = .clear
        
        register()
        setupCV_Layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        section.boundarySupplementaryItems = [headerItem,footerItem]
        section.supplementariesFollowContentInsets = false
        section.interGroupSpacing = 18
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.visibleItemsInvalidationHandler = { [weak self] _, offset, environment in
            guard let self else { return }
            let pageWidth = environment.container.contentSize.width
            let currentPage = Int((offset.x / pageWidth).rounded())
            self.numerologyPC.currentPage = currentPage
        }
        
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
    
    private var footerItem: NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottomLeading
        )
    }
    // MARK: - register
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


// MARK: Delegate, DataSource
extension PersonalPredictionsCV: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //  Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            sectionHeader?.label.text = "Personal predictions"
            return sectionHeader ?? UICollectionReusableView()
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooterView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionFooterView
            sectionFooter?.setPageControl(pageControl: self.numerologyPC)
            return sectionFooter ?? UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell().cardCollectionID, for: indexPath as IndexPath) as! CardCollectionViewCell
        
        if indexPath.row == 0 {
            // MARK: Pers. Day
            NumerologyManager.shared.getPersonalDay(number: 1) { model in
                self.personalDayModel = model
                cell.configure(
                    title: "Personal day",
                    subtitle: model.aboutPersDay,
                    bgImage: nil
                )
            }
            return cell
        }
        if indexPath.row == 1 {
            // MARK: Pers. Month
            NumerologyManager.shared.getPersonalMonth(number: 1) { model in
                self.personalMonthModel = model
                cell.configure(
                    title: "Personal month",
                    subtitle: model.aboutPersMonth,
                    bgImage: nil
                )
            }
            return cell
        }
        if indexPath.row == 2 {
            // MARK: Pers. Year
            NumerologyManager.shared.getPersonalYear(number: 1) { model in
                self.personalYearModel = model
                cell.configure(
                    title: "Personal year",
                    subtitle: model.aboutPersYear,
                    bgImage: nil
                )
            }
            return cell
        }
        if indexPath.row == 3 {
            // MARK: Life Stages
            NumerologyManager.shared.getLifeStages(number: 1) { model in
                self.lifeStagesModel = model
                cell.configure(
                    title: "Life Stages",
                    subtitle: model.aboutStages,
                    bgImage: nil
                )
            }
            return cell
        }
        return cell
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        // MARK: pers. Day
        if indexPath.row == 0 {
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            //            guard self.checkAccessContent() == true else { return }
            
            let vc = PersonalDayVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
        }
        
        // MARK: pers. month // 2.2
        if indexPath.row == 1 {
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            //            guard self.checkAccessContent() == true else { return }
            
            let vc = PersonalMonthVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
        }
        
        // MARK: pers. year // 2.3
        if indexPath.row == 2 {
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            //            guard self.checkAccessContent() == true else { return }
            
            let vc = PersonalYearVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
        }
        
        // MARK: life stages // 2.4
        if indexPath.row == 3 {
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            //            guard self.checkAccessContent() == true else { return }
            
            let vc = LifeStagesViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
            
        }
    }
}
