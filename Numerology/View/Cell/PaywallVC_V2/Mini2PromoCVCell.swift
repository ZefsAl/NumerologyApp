//
//  Mini2PromoCVCell.swift
//  Numerology
//
//  Created by Serj on 27.09.2023.
//

import UIKit

final class Mini2PromoCVCell: UICollectionViewCell {
    
    let mini2PromoCVCell_ID = "mini2PromoCVCell_ID"
    
        override var isSelected: Bool {
            didSet {
                if self.isSelected {
                    self.layer.borderColor = UIColor.CellColors().cellActiveBorder.cgColor
                    self.cardContent.backgroundColor = UIColor.CellColors().cellActiveBG
                    
                    mainTitle.textColor = UIColor.CellColors().activeText
                    priceTitle.textColor = UIColor.CellColors().activeText
                } else {
                    self.cardContent.backgroundColor = UIColor.CellColors().cellDisableBG
                    self.layer.borderColor = UIColor.CellColors().cellDisableBorder.cgColor
                    
                    mainTitle.textColor = UIColor.CellColors().disabledText
                    priceTitle.textColor = UIColor.CellColors().disabledText
                }
            }
        }
    
    // MARK: Main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .regular, size: 17)
//        l.text = "Monthly"
        l.textColor = UIColor.CellColors().disabledText
        return l
    }()
    
    // MARK: Price Title
    private let priceTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "9.99 $ / mo"
        l.font = UIFont(weight: .regular, size: 15)
        l.numberOfLines = 1
        l.textColor = UIColor.CellColors().disabledText
        return l
    }()
    
    let cardContent = UIStackView()
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.layer.borderWidth = DesignSystem.borderWidth
        self.layer.borderColor = UIColor.CellColors().cellDisableBorder.cgColor
        
        // Setup
        setUpStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, price: String) {
        self.mainTitle.text = title
        self.priceTitle.text = price
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [mainTitle,priceTitle])
        contentStack.spacing = 6
        contentStack.axis = .vertical
        contentStack.alignment = .center
        // Card Content
        cardContent.addArrangedSubview(UIView())
        cardContent.addArrangedSubview(contentStack)
        cardContent.addArrangedSubview(UIView())
        
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .vertical
        cardContent.alignment = .center
        cardContent.distribution = .equalSpacing
        cardContent.spacing = 0
        cardContent.backgroundColor = UIColor.CellColors().cellDisableBG
        cardContent.layer.cornerRadius = 16
        cardContent.layoutMargins = UIEdgeInsets(top: 20, left: 18, bottom: 20, right: 18)
        cardContent.isLayoutMarginsRelativeArrangement = true
        
        self.addSubview(cardContent)
        
        NSLayoutConstraint.activate([
            
            cardContent.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            cardContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cardContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cardContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
        ])
    }
}


