//
//  CarouselCollectionView.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit

final class CustomCarousel_CV: UICollectionView {
    
    let cardContentData: [CardContentModel] = [
        CardContentModel(title: "Awesome App!",
                         date: "July 25.2023",
                         fullname: "John Doe",
                         comment: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"),
        
        CardContentModel(title: "Life-Changing!",
                         date: "August 12.2023",
                         fullname: "Sarah Smith",
                         comment: "I've been using this app for months, and I'm amazed at the precision of its predictions.\nIt's like having a personal numerologist in my pocket!"),
        
        CardContentModel(title: "Amazing!",
                         date: "September 05.2023",
                         fullname: "Emily Davis",
                         comment: "The readings from this app are deeply insightful and thought-provoking. It feels like a guiding light through the mysteries of life. I absolutely love it!"),
    ]

    // MARK: init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        
        self.delegate = self
        self.dataSource = self
        self.register(CarouselCard_CVCell.self, forCellWithReuseIdentifier: CarouselCard_CVCell().carouselCard_CVCell_ID)
        
        setupCV_Layout()
        
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
    private func setupCV_Layout() {
        
//         layout settings 1 // то что нужно
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(165)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        group.accessibilityScroll(.right)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 48)
        
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = -48
        section.orthogonalScrollingBehavior = .groupPaging
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        self.collectionViewLayout = layout
        
        self.alwaysBounceVertical = false
        
        // layout settings 2
//        self.isPagingEnabled = true
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
////        layout.minimumInteritemSpacing = 20
//        layout.minimumLineSpacing = 40
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
//
////        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        self.collectionViewLayout = layout
        
        
        
        
    }
    

}

// MARK: Delegate
extension CustomCarousel_CV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardContentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCard_CVCell().carouselCard_CVCell_ID, for: indexPath as IndexPath) as! CarouselCard_CVCell
        
        
        cell.configure(title: cardContentData[indexPath.row].title,
                       date: cardContentData[indexPath.row].date,
                       fullname: cardContentData[indexPath.row].fullname,
                       comment: cardContentData[indexPath.row].comment
        )
        
        
        
        return cell
    }    
}

extension CustomCarousel_CV {
    
    struct CardContentModel {
        let title: String
        let date: String
        let fullname: String
        let comment: String
    }
}

