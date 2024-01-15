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
//        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        configure()
        register()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
        
//        if let collectionViewLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
    }
    
    private func register() {
        self.register(ChipsCVCell.self, forCellWithReuseIdentifier: ChipsCVCell().buttonCVCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
