////
////  Paywall_BigPromo_CVCell.swift
////  Numerology
////
////  Created by Serj on 17.09.2023.
////
//
//import UIKit
//
//final class SpecialOfferCVCell: UICollectionViewCell {
//    
//    // MARK: - id
//    static var reuseID: String {
//        String(describing: self)
//    }
//    
//    // MARK: Discount Caption
//    private let discountCaption: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textAlignment = .center
//        l.numberOfLines = 0
//        l.textColor = .white
//        return l
//    }()
//    
//    // MARK: Main Title
//    private let mainTitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        return l
//    }()
//    
//    // MARK: subtitle
//    private let subtitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.numberOfLines = 0
//        return l
//    }()
//    
//    // MARK: Price Title
//    private let priceTitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.numberOfLines = 1
//        return l
//    }()
//    
//    private let cardContent = UIStackView()
//    
//    // MARK: Init
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        // Style
//        self.backgroundColor = DesignSystem.PaywallTint.primaryPaywall
//        self.layer.cornerRadius = DesignSystem.maxCornerRadius
//        self.clipsToBounds = true
//        // setup
//        setAdapttiveLayout()
//        setupStack()
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setAdapttiveLayout() {
//        //
//        self.mainTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 18 : 20)
//        self.subtitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 11 : 13)
//        self.priceTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)
//        self.discountCaption.font = UIFont.setSourceSerifPro(weight: .bold, size: DeviceMenager.isSmallDevice ? 11 : 13)
//        //
//        cardContent.layoutMargins = UIEdgeInsets(
//            top: DeviceMenager.isSmallDevice ? 5 : 12,
//            left: DeviceMenager.isSmallDevice ? 18 : 18,
//            bottom: DeviceMenager.isSmallDevice ? 5 : 12,
//            right: DeviceMenager.isSmallDevice ? 18 : 18
//        )
//    }
//    
//    // MARK: Configure
//    func configure(discount: String, title: String, subtitle: String?, price: String) {
//        self.discountCaption.text = discount
//        self.mainTitle.text = title
//        self.priceTitle.text = price
//        // subtitle
//        if let subtitle = subtitle {
//            let mutableAttributedString = NSMutableAttributedString.init(string: subtitle)
//            // Color
//            mutableAttributedString.addAttribute(
//                NSAttributedString.Key.foregroundColor,
//                value: UIColor.lightGray,
//                range: (subtitle as NSString).range(of: subtitle)
//            )
//            // Strikethrough Style
//            mutableAttributedString.addAttribute(
//                NSAttributedString.Key.strikethroughStyle,
//                value: 2,
//                range: (subtitle as NSString).range(of: subtitle)
//            )
//            self.subtitle.attributedText = mutableAttributedString
//        }
//    }
//    
//    // MARK: Set up Stack
//    private func setupStack() {
//        
//        cardContent.addArrangedSubview(mainTitle)
//        cardContent.addArrangedSubview(priceTitle)
//        cardContent.addArrangedSubview(subtitle)
//        //
//        cardContent.axis = .vertical
//        cardContent.alignment = .center
//        cardContent.distribution = .fill
//        cardContent.spacing = 0
//        cardContent.backgroundColor = DesignSystem.PaywallTint.cellActiveBG
//        cardContent.layer.cornerRadius = DesignSystem.maxCornerRadius-2
//        cardContent.isLayoutMarginsRelativeArrangement = true
//        
//        // Discount Caption Stack
//        let discountCaptionStack = UIStackView(arrangedSubviews: [discountCaption])
//        discountCaptionStack.axis = .vertical
//        discountCaptionStack.alignment = .fill
//        discountCaptionStack.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
//        discountCaptionStack.isLayoutMarginsRelativeArrangement = true
//        
//        // Promo Border Stack
//        let promoBorderStack = UIStackView(arrangedSubviews: [discountCaptionStack, cardContent])
//        promoBorderStack.translatesAutoresizingMaskIntoConstraints = false
//        promoBorderStack.axis = .vertical
//        promoBorderStack.alignment = .fill
//        promoBorderStack.layoutMargins = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
//        promoBorderStack.isLayoutMarginsRelativeArrangement = true
//        
//        self.addSubview(promoBorderStack)
//        
//        NSLayoutConstraint.activate([
//            promoBorderStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            promoBorderStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            promoBorderStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            promoBorderStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
//        ])
//    }
//}
