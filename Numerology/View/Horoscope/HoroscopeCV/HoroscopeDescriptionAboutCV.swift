//
//  HoroscopeDescriptionAboutCV.swift
//  Numerology
//
//  Created by Serj on 29.11.2023.
//

import Foundation
import UIKit

class HoroscopeDescriptionAboutCV: AboutYouCV {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  Supplementary Element
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            sectionHeader?.isHidden = true
            return sectionHeader ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoroscopeCell.reuseID, for: indexPath as IndexPath) as! HoroscopeCell
        cell.cardIcon.isHidden = true
        //
        let dataName = UserDefaults.standard.object(forKey: "nameKey") as? String
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)
        //
        if indexPath.row == 0 {
            HoroscopeManager.shared.getSigns(zodiacSigns: sign) { model, image1, image2 in
                cell.configure(
                    title: "Hello, \(dataName ?? "" )!",
                    subtitle: "\(setDateFormat(date: dateOfBirth ?? Date() ))",
                    bgImage: image1
                )
            }
            return cell
        }
        return cell
    }
}



