//
//  AngelNumbersCV.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.04.2024.
//

import Foundation
import UIKit

class DetailAngelNumbersSignsCV: ContentCollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
 
    let angelNumbersArr: [String] = [
        "111","222","333","444","555","666","777","888","999",
        "1111","2222"
    ]
    
    func register() {
        // Delegate Collection View
        self.delegate = self
        self.dataSource = self
        self.register(AngelNumbersCVCell.self, forCellWithReuseIdentifier: AngelNumbersCVCell.reuseID)
    }
    
}


// MARK: Delegate
extension DetailAngelNumbersSignsCV: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return angelNumbersArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AngelNumbersCVCell.reuseID, for: indexPath as IndexPath) as! AngelNumbersCVCell
        
        cell.label.text = angelNumbersArr[indexPath.row]
        
        if [0, 1, 2].contains(indexPath.row) { // Free content
            cell.premiumBadgeManager.invalidateBadgeAndNotification()
        }

        return cell
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        guard [0, 1, 2].contains(indexPath.row) else {
            guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
            self.сustomizedPresent(indexPath: indexPath)
            return
        }
        self.сustomizedPresent(indexPath: indexPath)
    }
    
    private func сustomizedPresent(indexPath: IndexPath) {
        
        let vc = AngelNumbersDescriptionVC()
        NumerologyManager.shared.getAngelNumbers(stringNumber: angelNumbersArr[indexPath.row]) { model in
            vc.configure(
                number: model.number,
                info: model.info
            )
        }
        self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row == 9 || 
           indexPath.row == 10 {
            return CGSize(width: (collectionView.frame.size.width/2)-9.3, height: 60)
            // т.к  decimals после деления
        }

        return CGSize(width: (collectionView.frame.size.width/3)-12, height: 60)
    }
    
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
}


final class AngelNumbersCVCell: UICollectionViewCell {
    
    let premiumBadgeManager = PremiumManager()
    
    
    static var reuseID: String {
        String(describing: self)
    }
    
    var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.textAlignment = .center
        l.font = UIFont(name: "Cinzel-Regular", size: 22)
        l.sizeToFit()
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        //
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
//        self.premiumBadgeManager.setPremiumBadgeToCard(view: self, imageSize: 18) // cust Reject
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = DesignSystem.maxCornerRadius
        self.layer.borderWidth = DesignSystem.borderWidth
        self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
    }
    
    
}
