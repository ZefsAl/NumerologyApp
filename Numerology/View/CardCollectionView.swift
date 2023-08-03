//
//  CardsCollectionView.swift
//  Numerology
//
//  Created by Serj on 19.07.2023.
//

import UIKit

class CardCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
           super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
           commonInit()
        
        self.backgroundColor = .clear
        self.isScrollEnabled = false
        
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }

       private func commonInit() {
           isScrollEnabled = false
       }

       override var contentSize: CGSize {
           didSet {
               invalidateIntrinsicContentSize()
           }
       }

       override func reloadData() {
           super.reloadData()
           self.invalidateIntrinsicContentSize()
       }

       override var intrinsicContentSize: CGSize {
           return contentSize
       }
}
