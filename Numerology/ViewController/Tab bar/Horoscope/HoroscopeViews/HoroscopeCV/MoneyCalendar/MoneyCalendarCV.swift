//
//  File.swift
//  Numerology
//
//  Created by Serj on 01.12.2023.
//

import Foundation
import UIKit



class MoneyCalendarCV: UICollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    private var monthHoroscope: MonthCalendarModel?
    
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
            heightDimension: NSCollectionLayoutDimension.absolute(390)
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
    
    // headerItem layout + used Delegate
    private var headerItem: NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
        )
//        let zeroSize = NSCollectionLayoutSize(widthDimension: .absolute(0.1), heightDimension: .absolute(0.1))

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
        self.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.reuseID)
        // Header
        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
    }
    
}

// MARK: Delegate
extension MoneyCalendarCV: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //  Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            sectionHeader?.label.text = "Money calendar"
            sectionHeader?.label.textColor = #colorLiteral(red: 0.6980392157, green: 0.6901960784, blue: 0.9725490196, alpha: 1)
            
            return sectionHeader ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.reuseID, for: indexPath as IndexPath) as! CalendarCell
        cell.customCalendarCellDelagete = self
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)
        
//        if indexPath.row == 0 {
//            HoroscopeManager.shared.getSign(zodiacSign: sign) { model, image1, image2 in
//                //
//                cell.customCalendarCellDelagete = self
//                cell.configure(
//                    title: model.zodiacSigns,
//                    subtitle: model.dateAboutYou,
//                    bgImage: image1
//                )
//            }
//            return cell
//        }
        return cell
    }
    
    // MARK: did Select ItemAt
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
}

// MARK: - CustomCalendarCellDelagete
extension MoneyCalendarCV: CustomCalendarCellDelagete {
    
    func readMoreAction() {
        let tint = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        let vc = MoneyCalendarDescriptionVC(primaryColor: tint)
        vc.bgImageNamed = "bgHoroscope2"
        
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)
        // Month new
        HoroscopeManager.shared.getMoneyCalendar(zodiacSign: sign) { model in
            self.monthHoroscope = model
            vc.descriptionCardView.configure(
                title: "Your month horoscope",
                info: nil,
                about: model.mainTrends,
                tintColor: tint
            )
        }
        
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .overFullScreen
        self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
        self.remoteOpenDelegate?.openFrom?.requestReview()
        
    }
}
