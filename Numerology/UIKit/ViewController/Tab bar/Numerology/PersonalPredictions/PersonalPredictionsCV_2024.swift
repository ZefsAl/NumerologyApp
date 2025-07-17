//  PersonalPredictionsCV.swift
//  Numerology
//
//  Created by Serj on 10.11.2023.
//

import UIKit


class PersonalPredictionsCV_2024: ContentCollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // models instance
    private var personalDayModel: PersonalDayModel?
    private var personalMonthModel: PersonalMonthModel?
    private var personalYearModel: PersonalYearModel?
    private var lifeStagesModel: LifeStagesModel?
    
    // MARK: - init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.backgroundColor = .clear
        
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - register
    private func register() {
        // Delegate Collection View
        self.delegate = self
        self.dataSource = self
        self.register(PersonalPredictionsCell.self, forCellWithReuseIdentifier: PersonalPredictionsCell.reuseID)
        // Header
        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
    }
    
}


// MARK: Delegate, DataSource
extension PersonalPredictionsCV_2024: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonalPredictionsCell.reuseID, for: indexPath as IndexPath) as! PersonalPredictionsCell
        
        if indexPath.row == 0 {
            // MARK: Pers. Day
            NumerologyManager.shared.getPersonalDay(number: 1) { model in
                self.personalDayModel = model
                cell.configure(
                    title: "Day",
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
                    title: "Month",
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
                    title: "Year",
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
        myPrint("You selected cell #\(indexPath.item)!")
        
        // MARK: pers. Day
        if indexPath.row == 0 {
            let vc = PersonalDayVC()
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: pers. month // 2.2
        if indexPath.row == 1 {
            let vc = PersonalMonthVC()
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: pers. year // 2.3
        if indexPath.row == 2 {
            let vc = PersonalYearVC()
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: life stages // 2.4
        if indexPath.row == 3 {
            let vc = LifeStagesViewController()
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    // MARK: - Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    //  Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseID,
                for: IndexPath(item: 0, section: 0)
            ) as? SectionHeaderView
            sectionHeader?.label.text = "Personal predictions"
            return sectionHeader ?? UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ((collectionView.frame.size.width-36)/2)-8, height: 112)
    }
    
    
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
