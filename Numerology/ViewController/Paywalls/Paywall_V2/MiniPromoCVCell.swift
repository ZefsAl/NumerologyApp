//
//  MiniPromoCVCell.swift
//  Numerology
//
//  Created by Serj on 18.09.2023.
//

import UIKit


final class MiniPromoCVCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.alpha = isSelected ? 1 : 0.3
            self.contentView.layer.borderColor = isSelected ? DesignSystem.PaywallTint.cellActiveBorder.cgColor : DesignSystem.PaywallTint.cellDisabledBorder.cgColor
        }
    }
    
    // MARK: Main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        return l
    }()
    
    // MARK: Price Title
    private let priceTitle: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.textAlignment = .center
        return l
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setup
        setupStack()
        // Style
        setAdaptiveStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, price: String) {
        self.mainTitle.text = title
        self.priceTitle.text = price
    }

    // MARK: - set Adaptive Style
    private func setAdaptiveStyle() {
        // Self Card Style
        self.contentView.alpha = 0.3
        self.contentView.backgroundColor = DesignSystem.PaywallTint.cellActiveBG
        // Border
        self.contentView.layer.borderColor = DesignSystem.PaywallTint.cellDisabledBorder.cgColor
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.cornerRadius = DeviceMenager.isSmallDevice ? DesignSystem.midCornerRadius : DesignSystem.maxCornerRadius
        self.contentView.clipsToBounds = true
        // Font
        self.mainTitle.font = UIFont.setSourceSerifPro(weight: .semiBold, size: DeviceMenager.isSmallDevice ? 17 : 20)
        self.priceTitle.font = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        // Card Content
        let cardContentStack = UIStackView(arrangedSubviews: [mainTitle,priceTitle])
        // config
        cardContentStack.translatesAutoresizingMaskIntoConstraints = false
        cardContentStack.axis = .vertical
        cardContentStack.alignment = .center
        cardContentStack.distribution = .fill
        cardContentStack.spacing = 0
        
        self.contentView.addSubview(cardContentStack)

        NSLayoutConstraint.activate([
            cardContentStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: DeviceMenager.isSmallDevice ? 8 : 18),
            cardContentStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 18),
            cardContentStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -18),
            cardContentStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: DeviceMenager.isSmallDevice ? -10 : -16),
        ])
    }
}


