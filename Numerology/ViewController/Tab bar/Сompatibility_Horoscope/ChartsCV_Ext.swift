//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 05.08.2024.
//

import Foundation
import UIKit


extension DetailCompatibilityHrscpVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setChartsData(model: CompatibilityHrscpModel) {
        
        let valArr = model.compatibilityStats?.components(separatedBy: ",").compactMap({Int($0)}) ?? [0,0,0,0,0]
        
        self.chartsDescriptionDataCV = [
            ChartCVCellModel(
                title: "Generally",
                text: model.aboutThisSign    ,
                percentTitle: "\(valArr[0])",
                progressValue: valArr[0],
                progressColor: DesignSystem.ProgressBarTitnt.green
            ),
            ChartCVCellModel(
                title: "Friendship",
                text: model.friendship ?? "" ,
                percentTitle: "\(valArr[1])",
                progressValue: valArr[1],
                progressColor: DesignSystem.ProgressBarTitnt.cyan
            ),
            ChartCVCellModel(
                title: "Intimacy",
                text: model.intimacy ?? ""   ,
                percentTitle: "\(valArr[2])",
                progressValue: valArr[2],
                progressColor: DesignSystem.ProgressBarTitnt.red
            ),
            ChartCVCellModel(
                title: "Family",
                text: model.family ?? ""     ,
                percentTitle: "\(valArr[3])",
                progressValue: valArr[3],
                progressColor: DesignSystem.ProgressBarTitnt.yellow
            ),
            ChartCVCellModel(
                title: "Work",
                text: model.work ?? ""       ,
                percentTitle: "\(valArr[4])",
                progressValue: valArr[4],
                progressColor: DesignSystem.ProgressBarTitnt.purple
            ),
        ]
        self.chartsCV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chartsDescriptionDataCV.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChartCVCell.reuseID,
            for: indexPath
        ) as! ChartCVCell
        

        let data = self.chartsDescriptionDataCV
        cell.title.text = data[indexPath.row].title
        cell.percentTitle.text = "\(data[indexPath.row].percentTitle)%"
        cell.setProgressValue(value: data[indexPath.row].progressValue)
        cell.setProgressColor(data[indexPath.row].progressColor)
        cell.title.font = UIFont(weight: .semiBold, size: 13)
        cell.percentTitle.font = UIFont(weight: .semiBold, size: 13)
        //
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = self.chartsDescriptionDataCV
        
        self.accordionView.accordionButton.setAccordionTitle(data[indexPath.row].title)
        self.accordionView.info.text = data[indexPath.row].text
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CGSize(
            width: (indexPath.row == 0) ? width : (width/2)-3,
            height: 52
        )
    }
//    
//     Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
//     Horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    
}


