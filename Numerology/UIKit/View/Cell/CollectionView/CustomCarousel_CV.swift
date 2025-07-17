////
////  CarouselCollectionView.swift
////  Numerology
////
////  Created by Serj on 17.09.2023.
////
//
//import UIKit
//
//final class CustomCarousel_CV: UICollectionView {
//    
////    let buffer = 2
////    var totalElements = 0
//    
//    
//    
//    var timer = Timer()
//    
//    let cardContentData: [CardContentModel] = [
//        
//        CardContentModel(title: "A Must-Have!",
//                         date: "December 03.2023",
//                         fullname: "Mark Taylor",
//                         comment: "This app is a must-have for anyone interested in numerology. It's user-friendly, insightful, and has become an integral part of my daily routine. Recommend it enough!"),
//        //
//        CardContentModel(title: "Awesome App!",
//                         date: "July 25.2023",
//                         fullname: "John Doe",
//                         comment: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"),
//        
//        CardContentModel(title: "Life-Changing!",
//                         date: "August 12.2023",
//                         fullname: "Sarah Smith",
//                         comment: "I've been using this app for months, and I'm amazed at the precision of its predictions.\nIt's like having a personal numerologist in my pocket!"),
//        
//        CardContentModel(title: "Amazing Insights!",
//                         date: "September 05.2023",
//                         fullname: "Emily Davis",
//                         comment: "The readings from this app are deeply insightful and thought-provoking. It feels like a guiding light through the mysteries of life.\nI absolutely love it!"),
//        
//        CardContentModel(title: "Deeply Insightful",
//                         date: "September 18.2023",
//                         fullname: "Lisa Wilson",
//                         comment: "The insights I've gained through this app are profound. It's like having a wise mentor at your fingertips. I can't recommend it enough for personal growth."),
//        
//        CardContentModel(title: "A Must-Have!",
//                         date: "December 03.2023",
//                         fullname: "Mark Taylor",
//                         comment: "This app is a must-have for anyone interested in numerology. It's user-friendly, insightful, and has become an integral part of my daily routine. Recommend it enough!"),
//        
//        //
//        
//        CardContentModel(title: "Awesome App!",
//                         date: "July 25.2023",
//                         fullname: "John Doe",
//                         comment: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"),
//    ]
//    
//    // MARK: init
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
//        
//        self.backgroundColor = .clear
//        self.isScrollEnabled = true
//        
//        
//        self.delegate = self
//        self.dataSource = self
//        self.register(CarouselCard_CVCell.self, forCellWithReuseIdentifier: CarouselCard_CVCell().carouselCard_CVCell_ID)
//        
//        setupCV_Layout()
//        
//        setTimer()
//        
//        
//        
//    }
//    
//    
//    func setInitialPosition() {
//        let indexPath = IndexPath(item: 0, section: 0)
//        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//    }
////    override func layoutSubviews() {
////        
////    }
//    
//    // MARK: - Auto Scroll
//    var currentItem = 0
//    
//    func setTimer() {
////        self.timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
//    }
//    
//    @objc func autoScroll() {
//        myPrint(currentItem)
//        if self.currentItem < self.cardContentData.count - 1 {
//            self.currentItem += 1
//        } else {
//            self.currentItem = 0
//        }
//        let indexPath = IndexPath(item: currentItem, section: 0)
//        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    // MARK: - Layout
//    private func setupCV_Layout() {
//        let size = NSCollectionLayoutSize(
//            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
//            heightDimension: NSCollectionLayoutDimension.estimated(165)
//        )
//        
//        let item = NSCollectionLayoutItem(layoutSize: size)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
//        group.accessibilityScroll(.right)
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 48)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = -48
//        section.orthogonalScrollingBehavior = .groupPaging
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        
//        self.collectionViewLayout = layout
//        self.alwaysBounceVertical = false
//    }
//    
//    
//    
//}
//
//// MARK: - DataSource
//extension CustomCarousel_CV: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
//    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cardContentData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCard_CVCell().carouselCard_CVCell_ID, for: indexPath as IndexPath) as! CarouselCard_CVCell
//        
//        let currentCell = indexPath.row % cardContentData.count
//
//        
//        
//        cell.configure(
//            title:    cardContentData[currentCell].title,
//            date:     cardContentData[currentCell].date,
//            fullname: cardContentData[currentCell].fullname,
//            comment:  cardContentData[currentCell].comment
//        )
//        return cell
//    }
//    
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
////         if (indexPath.row == cardContentData.count - 1 ) { //it's your last cell
////           //Load more data & reload your collection view
////         }
//        
//        
////        myPrint("✅ did scroll",collectionView.contentOffset.x)
//        myPrint("✅ did scroll",indexPath)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
////            if indexPath.row == 6 {
////                let indexPath = IndexPath(item: 1, section: 0)
////                cell.transform = CGAffineTransform.identity
////                self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
////            }
////            if indexPath.row == 0 {
////                let indexPath = IndexPath(item: 5, section: 0)
////                cell.transform = CGAffineTransform.identity
////                self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
////            }
//        }
//        
//        
//    }
////    
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        myPrint("✅ did scroll",indexPath)
////    }
//    
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        myPrint("✅ did scroll",sourceIndexPath)
//    }
//
//    
//    
//    
//}
//
//extension CustomCarousel_CV: UIScrollViewDelegate {
//// v2
//
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////            totalElements = buffer + cardContentData.count
////            return totalElements
////        }
//
//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
////            let itemSize = self.contentSize.width/CGFloat(totalElements)
////    
////            if scrollView.contentOffset.x > itemSize*CGFloat(cardContentData.count){
////                self.contentOffset.x -= itemSize*CGFloat(cardContentData.count)
////            }
////            if scrollView.contentOffset.x < 0  {
////                self.contentOffset.x += itemSize*CGFloat(cardContentData.count)
////            }
//            
//            myPrint("✅ did scroll",self.contentOffset.x)
//        }
//    
//    
//    
////        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
////
////            if let collectionView = scrollView as? UICollectionView {
////                myPrint("✅ did scroll",collectionView.contentOffset.x)
////
////            } else{
////                myPrint("cant cast")
////            }
////        }
//    
//}
//
//
