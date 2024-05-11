//
//  RegularPromoCVCell.swift
//  Numerology
//
//  Created by Serj on 18.09.2023.
//

import UIKit


final class RegularPromoCVCell: UICollectionViewCell {
    
    let regularPromoCVCell_ID = "regularPromoCVCell_ID"
    
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
        l.font = UIFont(weight: .regular, size: 20)
//        l.text = "Monthly"
        return l
    }()
    
    // MARK: Price Title
    private let priceTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "9.99 $ / mo"
        l.font = UIFont(weight: .regular, size: 17)
        l.numberOfLines = 1
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
        
        // Card Content
//        let cardContent = UIStackView(arrangedSubviews: [mainTitle,UIView(),priceTitle])
        cardContent.addArrangedSubview(mainTitle)
        cardContent.addArrangedSubview(UIView())
        cardContent.addArrangedSubview(priceTitle)
        
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .horizontal
        cardContent.alignment = .center
        cardContent.distribution = .fill
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


