//
//  CarouselCard_CVCell.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit

final class CarouselCard_CVCell: UICollectionViewCell {
 
    let carouselCard_CVCell_ID = "carouselCard_CVCell_ID"
    
    // MARK: Main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .regular, size: 20)
        l.textColor = .white
        return l
    }()
    
    // MARK: Rating Emoji Caption
    private let ratingEmojiCaption: UILabel = {
        // Картинка все ломает по этому Emoji
        let l = UILabel()
        l.text = "⭐️⭐️⭐️⭐️⭐️"
        l.font = UIFont.systemFont(ofSize: 13)
        return l
    }()
    
    // MARK: Date Caption
    private let dateCaption: UILabel = {
        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .regular, size: 11)
        l.numberOfLines = 0
        l.textAlignment = .right
        l.textColor = .lightGray
        
        return l
    }()
    
    // MARK: Full Name
    private let fullNameLable: UILabel = {
        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .regular, size: 13)
        l.numberOfLines = 0
        l.textAlignment = .right
        l.textColor = .white
        return l
    }()
    
    // MARK: Comment Text
    private let commentText: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .regular, size: 13)
        l.numberOfLines = 4
        l.textColor = .white
        
        return l
    }()
    
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = UIColor.CellColors().cellActiveBG.withAlphaComponent(0.8)
//        // Border
        self.layer.cornerRadius = 16
        
        // setup
        setupStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, date: String, fullname: String, comment: String) {
        self.mainTitle.text = title
        self.dateCaption.text = date
        self.fullNameLable.text = fullname
        self.commentText.text = comment
    }
    
    func getFrameSize() -> CGSize {
        return self.frame.size
    }
    
    
    
    
    
    
    // Хороший вариан полностью динимичной высоты и ширины но нужен automaticSize
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        //       let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        let size = self.systemLayoutSizeFitting(layoutAttributes.size)
//
//        var frame = layoutAttributes.frame
//        frame.size.width = ceil(size.width)
//        frame.size.height = ceil(size.height)
//
//        layoutAttributes.frame = frame
//        return layoutAttributes
//   }
    
    
//    // MARK: Configure
//    func configure(title: String, subtitle: String?) {
//        self.title.text = title
//        self.subtitle.text = subtitle
//    }
    
    
    // MARK: Set up Stack
    private func setupStack() {

        
        // Left Title Stack
        let leftStack = UIStackView(arrangedSubviews: [mainTitle,ratingEmojiCaption])
        leftStack.axis = .vertical
        leftStack.alignment = .fill
        leftStack.spacing = 4
        
        // Left Title Stack
        let rightStack = UIStackView(arrangedSubviews: [dateCaption, fullNameLable, UIView()])
        rightStack.axis = .vertical
        rightStack.alignment = .trailing
        rightStack.distribution = .fill
//        rightStack.spacing = 0
        
        // Top Stack
        let topStack = UIStackView(arrangedSubviews: [leftStack,rightStack])
        topStack.axis = .horizontal
        topStack.alignment = .fill
        topStack.distribution = .equalSpacing
//        topStack.spacing = 0
        
        // Card Content
        let cardContent = UIStackView(arrangedSubviews: [topStack, commentText])
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .vertical
        cardContent.alignment = .fill
        cardContent.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        cardContent.isLayoutMarginsRelativeArrangement = true
        cardContent.spacing = 10
        
        self.addSubview(cardContent)
        
        NSLayoutConstraint.activate([
            
        
            cardContent.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            cardContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cardContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cardContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
