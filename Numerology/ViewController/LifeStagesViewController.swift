//
//  LifeStagesViewController.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

class LifeStagesViewController: UIViewController {
    
    
    // MARK: Date title
    private let yearsTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.text = String("test")
        l.textAlignment = .left
        
        return l
    }()
    
    // MARK: contentTitle
    private let contentTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.text = String("test")
        l.textAlignment = .left
        
        return l
    }()
    
    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = "test testtest testtesttes ttest testtes ttesttest testte sttesttest testt esttesttest testtest testtest testtest testtest testtest"
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let about: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = String("test")
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    

    let buttonsCollectionView: ContentCollectionView = {
        var cv = ContentCollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        if let collectionViewLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        cv.backgroundColor = .systemBlue
        return cv
    }()
    
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
//    let firstBTN = ChipsButton(frame: .zero, title: "TITLE")
    
    
    // MARK: Description ScrollView
    private let descriptionScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .systemGray
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false

        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpStack()
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        
        self.view.backgroundColor = .systemPink
        
        buttonsCollectionView.delegate = self
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.register(ButtonCVCell.self, forCellWithReuseIdentifier: ButtonCVCell().buttonCVCellID)
        
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        // MARK: description
//        let descriptionStack = UIStackView(arrangedSubviews: [info,about])
//        descriptionStack.alignment = .fill
//        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
//        descriptionStack.spacing = 16
//        descriptionStack.axis = .vertical
//
//        // MARK: Card View + Border
//        let cardView: UIView = {
//            let v = UIView()
//            v.translatesAutoresizingMaskIntoConstraints = false
//            v.layer.cornerRadius = 15
//            v.layer.borderWidth = 1
//            v.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.996, alpha: 1).cgColor
//            return v
//        }()
//        cardView.addSubview(descriptionStack)
        
        
        // [buttonsCollectionView, descriptionScrollView, cardView
        let contentStack = UIStackView(arrangedSubviews: [ descriptionScrollView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .fill
        contentStack.spacing = 24
        contentStack.backgroundColor = .systemOrange
        
//        descriptionScrollView.frame = CGRect(x: 0, y: 0, width: descriptionScrollView.frame.size.width, height: descriptionScrollView.frame.size.height)
        descriptionScrollView.contentSize = CGSize(width: descriptionScrollView.frame.size.width*3, height: descriptionScrollView.frame.size.height)
        descriptionScrollView.isPagingEnabled = true
        
        for slide in 0..<3 {
            let page = UIView(frame: CGRect( x: CGFloat(slide) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            if slide == 0 {
                page.backgroundColor = .systemPurple
            }
            if slide == 1 {
                page.backgroundColor = .systemPink
            }
            if slide == 2 {
                page.backgroundColor = .systemBlue
            }
            descriptionScrollView.addSubview(page)
        }
        
        
        
        
        
//        self.view.addSubview(contentScrollView)
//        contentScrollView.addSubview(contentStack)
//        contentScrollView.addSubview(descriptionScrollView)
        
        let horizontalScrollView = UIScrollView(frame: CGRectMake(40.0, 40.0, 300.0, 300.0))
        horizontalScrollView.backgroundColor = UIColor.white
        horizontalScrollView.contentSize = CGSizeMake(2000.0, 300.0)
        self.view.addSubview(horizontalScrollView)

        let verticalScrollView = UIScrollView(frame: CGRectMake(40.0, 40.0, 220.0, 220.0))
        verticalScrollView.backgroundColor = UIColor.green
        verticalScrollView.contentSize = CGSizeMake(220.0, 2000.0)
        horizontalScrollView.addSubview(verticalScrollView)
        
        
        
//        view.addSubview(descriptionScrollView)
        
        let margin = self.view.layoutMarginsGuide
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        let descriptionScrollViewMargin = descriptionScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            
//            descriptionScrollView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
//            descriptionScrollView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
            
            
//            descriptionScrollView.widthAnchor.constraint(equalToConstant: 400),
//            descriptionScrollView.heightAnchor.constraint(equalToConstant: 400),
            
            
            
//            descriptionScrollView.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 0),
//            descriptionScrollView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: 0),
//            descriptionScrollView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: 0),
//            descriptionScrollView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -0),
//            descriptionScrollView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
//            descriptionScrollView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor, constant: 0),
            
            
//            descriptionStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
//            descriptionStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
//            descriptionStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
//            descriptionStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
//
//            buttonsCollectionView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
//            buttonsCollectionView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
//
//            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 0),
//            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
//            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
//            contentStack.bottomAnchor.constraint(equalTo: scrollViewMargin.bottomAnchor, constant: -24),
//            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
////
//            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
//            horizontalScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            horizontalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            
            
        ])
    }
    

}

// MARK: Collection View Delegate
extension LifeStagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    
    // MARK: Size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: (view.frame.size.width/4)-30, height: 30)
//    }
    
    // vertical Spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    
//  MARK: Horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 4
    }

    // MARK: Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCVCell().buttonCVCellID, for: indexPath as IndexPath) as! ButtonCVCell
        
        cell.configure(title: "ASDAS")

        return cell
    }

    // MARK: Selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCVCell().buttonCVCellID, for: indexPath as IndexPath) as! ButtonCVCell
        
        print("You selected cell #\(indexPath.item)!")
    }

}
