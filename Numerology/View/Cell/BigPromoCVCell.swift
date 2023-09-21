//
//  Paywall_BigPromo_CVCell.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit

final class BigPromoCVCell: UICollectionViewCell {
 
    let bigPromoCVCell_ID = "bigPromoCVCell_ID"
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.backgroundColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
            } else {
                self.backgroundColor = UIColor.CellColors().cellDisableBorder
            }
        }
    }
    
    
    // MARK: Discount Caption
    private let discountCaption: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "save 66%".uppercased()
        l.font = UIFont(weight: .bold, size: 13)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = .white
        
        return l
    }()
    
    // MARK: Main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .regular, size: 24)
//        l.text = "Yearly Plan"
        return l
    }()
    
    // MARK: subtitle
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "12 mo - 35.99 $ / year"
        l.font = UIFont(weight: .regular, size: 13)
        l.numberOfLines = 0
        
        return l
    }()
    
    // MARK: Price Title
    private let priceTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "2.99 $ / mo"
        l.font = UIFont(weight: .regular, size: 17)
        l.numberOfLines = 1
        return l
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = UIColor.CellColors().cellDisableBorder
        self.layer.cornerRadius = 16
        self.clipsToBounds = true

        // Setup
        setUpStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(discount: String, title: String, subtitle: String?, price: String) {
        self.discountCaption.text = discount
        self.mainTitle.text = title
        self.subtitle.text = subtitle
        self.priceTitle.text = price
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // Left Stack
        let leftStack = UIStackView(arrangedSubviews: [mainTitle,subtitle])
        leftStack.axis = .vertical
        leftStack.alignment = .fill
        leftStack.spacing = 0
        
        // Card Content
        let cardContent = UIStackView(arrangedSubviews: [leftStack,UIView(),priceTitle])
        cardContent.axis = .horizontal
        cardContent.alignment = .center
        cardContent.distribution = .fill
        cardContent.spacing = 0
        cardContent.backgroundColor = UIColor.CellColors().cellDefaultBG
        cardContent.layer.cornerRadius = 14
        cardContent.layoutMargins = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18)
        cardContent.isLayoutMarginsRelativeArrangement = true
        
        
        // Discount Caption Stack
        let discountCaption_Stack = UIStackView(arrangedSubviews: [discountCaption])
        discountCaption_Stack.axis = .vertical
        discountCaption_Stack.alignment = .fill
        discountCaption_Stack.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        discountCaption_Stack.isLayoutMarginsRelativeArrangement = true
        
        // Promo Border Stack
        let promoBorderStack = UIStackView(arrangedSubviews: [discountCaption_Stack, cardContent])
        promoBorderStack.translatesAutoresizingMaskIntoConstraints = false
        promoBorderStack.axis = .vertical
        promoBorderStack.alignment = .fill
        promoBorderStack.layoutMargins = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        promoBorderStack.isLayoutMarginsRelativeArrangement = true
        
        self.addSubview(promoBorderStack)
        
        NSLayoutConstraint.activate([
        
            promoBorderStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            promoBorderStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            promoBorderStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            promoBorderStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
        ])
    }
}
