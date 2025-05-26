//

//  Numerology
//
//  Created by Serj_M1Pro on 14.08.2024.
//

import UIKit


extension HoroscopeDescriptionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func registerChartsCV() {
        self.chartsCV.delegate = self
        self.chartsCV.dataSource = self
        self.chartsCV.register(ChartCVCell.self, forCellWithReuseIdentifier: ChartCVCell.reuseID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.horoscopeCellViewModel.chartsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChartCVCell.reuseID,
            for: indexPath
        ) as! ChartCVCell
        
        let data = self.horoscopeCellViewModel.chartsDataSource
        cell.title.text = data[indexPath.row].title
        cell.percentTitle.text = "\(data[indexPath.row].percentTitle)%"
        cell.setProgressValue(value: data[indexPath.row].progressValue)
        cell.setProgressColor(data[indexPath.row].progressColor)
        cell.title.font = DS.SourceSerifProFont.title_h6
        cell.title.adjustsFontSizeToFitWidth = true
        cell.percentTitle.font = DS.SourceSerifProFont.title_h6
        
        //
        if ![3, 4].contains(self.segmentedControl.selectedSegmentIndex) {
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
            collectionView.isUserInteractionEnabled = true
        } else {
            collectionView.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.setSingleCardText(model: self.horoscopeCellViewModel.chartsDataSource[indexPath.row])
        self.mainInfo.accordionButton.mainTitle.fadeTransition()
        self.mainInfo.info.fadeTransition()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fourItems = self.horoscopeCellViewModel.chartsDataSource.count == 4
        let width = collectionView.bounds.size.width/(fourItems ? 2 : 3.1) - 3
        return CGSize(width: width,height: 52)
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


