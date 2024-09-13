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
        self.chartsCV.register(ChartButtonCell.self, forCellWithReuseIdentifier: ChartButtonCell.reuseID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.charismaCVViewModel?.chartsDataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        guard let data = self.charismaCVViewModel?.chartsDataSource else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChartCVCell.reuseID,
            for: indexPath
        ) as! ChartCVCell
        
        let cell2 = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChartButtonCell.reuseID,
            for: indexPath
        ) as! ChartButtonCell
        
        let initialIndex = IndexPath(item: 0, section: 0)
        self.chartsCV.selectItem(at: initialIndex, animated: true, scrollPosition: [])
        self.setCardText(model: data[initialIndex.row])
        
        

        
        if indexPath.row == 0 {
            cell2.cellConfigure(data: data, indexPath: indexPath)
            return cell2
        } else {
            cell.title.text = data[indexPath.row].title
            cell.percentTitle.text = "\(data[indexPath.row].percentTitle)%"
            cell.setProgressValue(value: data[indexPath.row].progressValue)
            cell.setProgressColor(data[indexPath.row].progressColor)
            cell.title.font = DesignSystem.SourceSerifProFont.title_h6
            cell.title.adjustsFontSizeToFitWidth = true
            cell.percentTitle.font = DesignSystem.SourceSerifProFont.title_h6
            return cell
        } 
                
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


