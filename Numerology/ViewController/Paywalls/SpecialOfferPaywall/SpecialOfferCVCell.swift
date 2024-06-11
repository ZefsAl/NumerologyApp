//
//  Paywall_BigPromo_CVCell.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit

final class SpecialOfferCVCell: UICollectionViewCell {
    
    // MARK: - id
    static var reuseID: String {
        String(describing: self)
    }
    
    // MARK: Discount Caption
    private let discountCaption: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = .white
        return l
    }()
    
    // MARK: Main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // MARK: subtitle
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Price Title
    private let priceTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 1
        return l
    }()
    
    private let cardContent = UIStackView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Style
        self.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.7921568627, alpha: 1)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        // setup
        setAdapttiveLayout()
        setupStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAdapttiveLayout() {
        // Device
        if DeviceMenager.shared.device == .iPhone_Se2_3Gen_8_7_6S {
            self.mainTitle.font = UIFont(weight: .regular, size: 18)
            self.subtitle.font = UIFont(weight: .regular, size: 11)
            self.priceTitle.font = UIFont(weight: .regular, size: 15)
            self.discountCaption.font = UIFont(weight: .bold, size: 11)
            //
            cardContent.layoutMargins = UIEdgeInsets(top: 5, left: 18, bottom: 5, right: 18)
        } else {
            self.mainTitle.font = UIFont(weight: .regular, size: 20)
            self.subtitle.font = UIFont(weight: .regular, size: 13)
            self.priceTitle.font = UIFont(weight: .regular, size: 17)
            self.discountCaption.font = UIFont(weight: .bold, size: 13)
            //
            cardContent.layoutMargins = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18)
        }
    }
    
    // MARK: Configure
    func configure(discount: String, title: String, subtitle: String?, price: String) {
        self.discountCaption.text = discount
        self.mainTitle.text = title
        self.priceTitle.text = price
        // subtitle
        if let subtitle = subtitle {
            let mutableAttributedString = NSMutableAttributedString.init(string: subtitle)
            mutableAttributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.lightGray,
                range: (subtitle as NSString).range(of: subtitle)
            )
            mutableAttributedString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: 2,
                range: (subtitle as NSString).range(of: subtitle)
            )
            self.subtitle.attributedText = mutableAttributedString
        }
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        cardContent.addArrangedSubview(mainTitle)
        cardContent.addArrangedSubview(priceTitle)
        cardContent.addArrangedSubview(subtitle)
        //
        cardContent.axis = .vertical
        cardContent.alignment = .center
        cardContent.distribution = .fill
        cardContent.spacing = 0
        cardContent.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1)
        cardContent.layer.cornerRadius = 14
        cardContent.isLayoutMarginsRelativeArrangement = true
        
        // Discount Caption Stack
        let discountCaptionStack = UIStackView(arrangedSubviews: [discountCaption])
        discountCaptionStack.axis = .vertical
        discountCaptionStack.alignment = .fill
        discountCaptionStack.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        discountCaptionStack.isLayoutMarginsRelativeArrangement = true
        
        // Promo Border Stack
        let promoBorderStack = UIStackView(arrangedSubviews: [discountCaptionStack, cardContent])
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
