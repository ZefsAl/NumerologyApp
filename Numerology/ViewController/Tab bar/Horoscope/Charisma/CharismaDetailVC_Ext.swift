//
//  CharismaDetailVC_Ext.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.08.2024.
//

import Foundation
import UIKit

extension CharismaDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func registerChartsCV() {
        self.chartsCV.delegate = self
        self.chartsCV.dataSource = self
        self.chartsCV.register(ChartCVCell.self, forCellWithReuseIdentifier: ChartCVCell.reuseID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.charismaCVViewModel?.chartsDataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChartCVCell.reuseID,
            for: indexPath
        ) as! ChartCVCell
        
        guard let data = self.charismaCVViewModel?.chartsDataSource else { return UICollectionViewCell() }
        
        
        let initialIndex = IndexPath(item: 0, section: 0)
        self.chartsCV.selectItem(at: initialIndex, animated: true, scrollPosition: [])
        self.setCardText(model: data[initialIndex.row])
        
        if indexPath.row == 0 {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(
                systemName: "chevron.right",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
            )?.withTintColor(.white)
            let fullString = NSMutableAttributedString(string: "\(data[indexPath.row].title) ")
            fullString.append(NSAttributedString(attachment: imageAttachment))
            cell.title.attributedText = fullString
            cell.title.adjustsFontSizeToFitWidth = true
            cell.changeCellToBigBtn()
        } else {
            cell.title.text = data[indexPath.row].title
            cell.percentTitle.text = "\(data[indexPath.row].percentTitle)%"
            cell.setProgressValue(value: data[indexPath.row].progressValue)
            cell.setProgressColor(data[indexPath.row].progressColor)
            cell.title.font = UIFont.setSourceSerifPro(weight: .semiBold, size: 12)
            cell.title.adjustsFontSizeToFitWidth = true
            cell.percentTitle.font = UIFont.setSourceSerifPro(weight: .semiBold, size: 12)
        }
        
        //
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = self.charismaCVViewModel?.chartsDataSource else { return }
        self.setCardText(model: data[indexPath.row])
    }
    
    // MARK: - layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let state = indexPath.row == 0
        let width = collectionView.bounds.size.width
        
        return CGSize(
            width: state ? width : (width/2)-3,
            height: 52
        )
    }

    // Horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    
}


