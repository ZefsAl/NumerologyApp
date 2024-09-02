//
//  Paywall_BigPromo_CVCell.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit

final class BigPromoCVCell: UICollectionViewCell {
 
    static var reuseID: String {
        String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.alpha = isSelected ? 1 : 0.3
            self.layer.borderColor = (isSelected ? DesignSystem.PaywallTint.cellActiveBorder : DesignSystem.PaywallTint.cellDisabledBorder).cgColor
        }
    }
    
    // MARK: Discount Caption
    private let discountBadge: PaddingLabel = {
        let l = PaddingLabel(capsuleShape: true)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = .white
        l.backgroundColor = DesignSystem.PaywallTint.discountBadge
        //
        l.topInset = 2
        l.bottomInset = 3
        l.leftInset = 8
        l.rightInset = 8
        l.clipsToBounds = true
        //
        return l
    }()
    
    // MARK: Main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // MARK: subtitle
    private let discountTitle: UILabel = {
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
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Ui
        setupStack()
        // Style
        setAdaptiveStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - set Adaptive Style
    private func setAdaptiveStyle() {
        // Self Card Style
        self.contentView.alpha = 0.3
        self.contentView.backgroundColor = DesignSystem.PaywallTint.cellActiveBG
        // Border
        self.contentView.layer.borderColor = DesignSystem.PaywallTint.cellActiveBorder.cgColor
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.cornerRadius = DeviceMenager.isSmallDevice ? DesignSystem.midCornerRadius_20 : DesignSystem.maxCornerRadius
        self.contentView.clipsToBounds = true
        // Font
        self.discountBadge.font = UIFont.setSourceSerifPro(weight: .bold, size: DeviceMenager.isSmallDevice ? 11 : 13)
        self.mainTitle.font = UIFont.setSourceSerifPro(weight: .semiBold, size: DeviceMenager.isSmallDevice ? 17 : 20)
        self.priceTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)
        self.discountTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 13 : 15)
    }
    
    // MARK: Configure
    func configure(discount: String, title: String, subtitle: String?, price: String) {
        self.discountBadge.text = discount
        self.mainTitle.text = title
        self.discountTitle.text = subtitle
        self.priceTitle.text = price
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // Left Stack
        let leftStack = UIStackView(arrangedSubviews: [mainTitle,priceTitle])
        leftStack.axis = .vertical
        leftStack.alignment = .leading
        leftStack.distribution = .fill
        leftStack.spacing = 0
        
        let rightStack = UIStackView(arrangedSubviews: [discountBadge,discountTitle])
        rightStack.axis = .vertical
        rightStack.alignment = .trailing
        rightStack.distribution = .fill
        rightStack.spacing = 3
        
        // Card Content
        let cardContentStack = UIStackView(arrangedSubviews: [
            leftStack,
            UIView(),
            rightStack,
        ])
        cardContentStack.translatesAutoresizingMaskIntoConstraints = false
        cardContentStack.axis = .horizontal
        cardContentStack.alignment = .center
        cardContentStack.distribution = .fill
        cardContentStack.spacing = 0
        
        self.contentView.addSubview(cardContentStack)
        NSLayoutConstraint.activate([
            cardContentStack.topAnchor.constraint(lessThanOrEqualTo: self.contentView.topAnchor, constant: DeviceMenager.isSmallDevice ? 10 : 18),
            cardContentStack.leadingAnchor.constraint(lessThanOrEqualTo: self.contentView.leadingAnchor, constant: 18),
            cardContentStack.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -18),
            cardContentStack.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: DeviceMenager.isSmallDevice ? -8 : -16),
        ])
    }
}
