//
//  File.swift
//  Numerology
//
//  Created by Serj on 28.11.2023.
//

import Foundation
import UIKit

class HoroscopeButtonsCV: ContentCollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        configure()
        register()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
        
        if let collectionViewLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func register() {
//        self.delegate = self
//        self.dataSource = self
        self.register(ChipsCVCell.self, forCellWithReuseIdentifier: ChipsCVCell().buttonCVCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//// MARK: - buttons Collection View
//extension HoroscopeButtonsCV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    //  MARK: Horizontal spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//    
//    // MARK: Cell
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipsCVCell().buttonCVCellID, for: indexPath as IndexPath) as! ChipsCVCell
//        cell.primaryColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
//        
//        if indexPath.row == 0 {
//            cell.configure(title: "Today")
//        } else if indexPath.row == 1 {
//            cell.configure(title: "Tomorrow")
//        } else if indexPath.row == 2 {
//            cell.configure(title: "Week")
//        } else if indexPath.row == 3 {
//            cell.configure(title: "Month")
//        } else if indexPath.row == 4 {
//            cell.configure(title: "2023")
//        } else if indexPath.row == 5 {
//            cell.configure(title: "2024")
//        }
//        return cell
//    }
//    
//    // MARK: Selected
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        
//        if indexPath.row == 0 {
////            self.yearsTitle.text = "The beginning of your life - \(firstStageNumber) years"
////            self.contentTitle.text = "Your number of the first life stage"
////            self.info.text = firstModel?.infoStages
////            self.about.text = firstModel?.aboutStages
//        }
//        
//        
////        // Second
////        if indexPath.row == 1 {
////            self.yearsTitle.text = "\(firstStageNumber) years - \(secondStageNumber) years"
////            self.contentTitle.text = "Your number of the second life stage"
////            self.info.text = secondModel?.infoStages
////            self.about.text = secondModel?.aboutStages
////        }
////        // Third
////        if indexPath.row == 2 {
////            self.yearsTitle.text = "\(secondStageNumber) years - \(thirdStageNumber) years"
////            self.contentTitle.text = "Your number of the third life stage"
////            self.info.text = thirdModel?.infoStages
////            self.about.text = thirdModel?.aboutStages
////        }
////        // Fourth
////        if indexPath.row == 3 {
////            self.yearsTitle.text = "\(fourthStageNumber) years - the end of your life"
////            self.contentTitle.text = "Your number of the fourth life stage"
////            self.info.text = fourthModel?.infoStages
////            self.about.text = fourthModel?.aboutStages
////        }
//    }
//}
//
