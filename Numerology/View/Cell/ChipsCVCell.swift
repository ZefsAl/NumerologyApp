//
//  ButtonCVCell.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

class ChipsCVCell: UICollectionViewCell {
 
    let buttonCVCellID = "buttonCVCellID"
    
    let premiumBadgeManager = PremiumBadgeManager()
    
    var primaryColor: UIColor? = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                // Selected TF state
                self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
                self.backgroundColor = primaryColor
                self.layer.borderWidth = 0
                self.layer.shadowOpacity = 1
                self.layer.shadowRadius = 16
                self.layer.shadowOffset = CGSize(width: 0, height: 4)
                self.layer.shadowColor = primaryColor?.withAlphaComponent(0.5).cgColor ?? #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
            } else {
                self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
                // Default TF state
                self.layer.borderWidth = 1
                self.layer.shadowOffset = CGSize.zero
                self.layer.shadowColor = UIColor.clear.cgColor
            }
        }
    }
    
    // MARK: title
    private let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.ChipsButton.title
        l.textAlignment = .center
        
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = .black.withAlphaComponent(0.5)
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.7).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = UIColor.clear.cgColor
        
        // setup
        setupStack()
        self.premiumBadgeManager.setPremiumBadgeToCard(view: self, imageSize: 18, side: .centerTrailing)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String) {
        self.title.text = title
    }
    func configureBorder(borderColor: UIColor) {
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.withAlphaComponent(0.7).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = UIColor.clear.cgColor
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}

