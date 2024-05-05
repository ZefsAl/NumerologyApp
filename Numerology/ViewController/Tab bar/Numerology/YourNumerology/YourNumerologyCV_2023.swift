//
//  YourNumerologyCV.swift
//  Numerology
//
//  Created by Serj on 09.11.2023.
//

import UIKit


class YourNumerologyCV: UICollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // models instance
//    private var boardOfDayModel: BoardOfDayModel?
    private var numbersOfSoulModel: NumbersOfSoulModel?
    private var numbersOfDestinyModel: NumbersOfDestinyModel?
    private var numbersOfNameModel: NumbersOfNameModel?
    private var numbersOfMoneyModel: NumbersOfMoneyModel?
    private var powerCodeModel: PowerCodeModel?
    
    // MARK: Page Control
    private let numerologyPC: UIPageControl = {
        let pc = UIPageControl()
        pc .translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 5
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
extension YourNumerologyCV: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //  Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            sectionHeader?.label.text = "Your Numerology"
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
        // 👎
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell().cardCollectionID, for: indexPath as IndexPath) as! CardCollectionViewCell
        
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let name = UserDefaults.standard.object(forKey: "nameKey") as? String
        let surname = UserDefaults.standard.object(forKey: "surnameKey") as? String
        
        if indexPath.row == 0 {
            // MARK: SOUL
            let number = CalculateNumbers().calculateNumberOfSoul(date: dateOfBirth)
            NumerologyManager.shared.getNumbersOfSoul(number: number) { model, img in
                self.numbersOfSoulModel = model
                cell.configure(
                    title: "Soul",
                    subtitle: model.infoSoul,
                    bgImage: img
                )
            }
            return cell
        }
        if indexPath.row == 1 {
            // MARK: Destiny
            let number = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
            NumerologyManager.shared.getNumbersOfDestiny(number: number) { model, img in
                self.numbersOfDestinyModel = model
                cell.configure(
                    title: "Destiny",
                    subtitle: model.infoDestiny,
                    bgImage: img
                )
            }
            
            return cell
        }
        if indexPath.row == 2 {
            // MARK: Name
            guard
                let name = name,
                let surname = surname
            else { return cell}
            let number = CalculateNumbers().calculateNumberOfName(name: name, surname: surname)
            NumerologyManager.shared.getNumbersOfName(number: number) { model, img in
                self.numbersOfNameModel = model
                cell.configure(
                    title: "Name",
                    subtitle: model.infoName,
                    bgImage: img
                )
            }
            
            return cell
        }
        if indexPath.row == 3 {
            // MARK: Money
            guard
                let name = name
            else { return cell}
            let number = CalculateNumbers().calculateNumberOfMoney(name: name, date: dateOfBirth)
            NumerologyManager.shared.getNumbersOfMoney(number: number) { model, img in
                self.numbersOfMoneyModel = model
                cell.configure(
                    title: "Money",
                    subtitle: model.infoMoney,
                    bgImage: img
                )
            }
            
            return cell
        }
        if indexPath.row == 4 {
            // MARK: Power Code
            guard
                let name = name,
                let surname = surname
            else { return cell}
            
            let codeName = CalculateNumbers().calculateNumberOfName(name: name, surname: surname)
            let codeDestiny = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
            let number = CalculateNumbers().calculatePowerCode(codeName: codeName, codeDestiny: codeDestiny)
            
            NumerologyManager.shared.getPowerCode(number: number) { model, img in
                self.powerCodeModel = model
                cell.configure(
                    title: "Power Code",
                    subtitle: model.infoPower,
                    bgImage: img
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
        
        // MARK: Soul // 0
        if indexPath.row == 0 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your soul number",
                info: numbersOfSoulModel?.infoSoul,
                about: numbersOfSoulModel?.aboutSoul
            )
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            
            if numbersOfSoulModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
            }
        }
        
        // MARK: Destiny // 1
        if indexPath.row == 1 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your destiny number",
                info: numbersOfDestinyModel?.infoDestiny,
                about: numbersOfDestinyModel?.aboutDestiny
            )
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            
            if numbersOfDestinyModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
            }
        }
        
        // MARK: Name // 2
        if indexPath.row == 2 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your name number",
                info: numbersOfNameModel?.infoName,
                about: numbersOfNameModel?.aboutName
            )
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            
            if numbersOfNameModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
            }
        }
        
        // MARK: Money // 3
        if indexPath.row == 3 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your money number",
                info: numbersOfMoneyModel?.infoMoney,
                about: numbersOfMoneyModel?.aboutMoney
            )
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            
            if numbersOfMoneyModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
            }
        }
        
        // MARK: Power Code // 4
        if indexPath.row == 4 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Power Code",
                info: powerCodeModel?.infoPower,
                about: powerCodeModel?.aboutPower
            )
            
            // MARK: Check
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            
            if powerCodeModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
            }
        }
    }
}
