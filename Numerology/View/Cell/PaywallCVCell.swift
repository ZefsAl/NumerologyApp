//
//  PaywallCVCell.swift
//  Numerology
//
//  Created by Serj on 15.08.2023.
//

import UIKit

class PaywallCVCell: UICollectionViewCell {
 
    let payWallCVCellID = "payWallCVCellID"
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                
                self.cardIcon.tintColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
//                self.cardIcon.layer.cornerRadius = 30
//                self.cardIcon.backgroundColor = .white
                
                // Selected state
                self.layer.borderWidth = DesignSystem.borderWidth
                self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
                self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
                self.layer.shadowOpacity = 1
                self.layer.shadowRadius = 16
                self.layer.shadowOffset = CGSize(width: 0, height: 4)
                self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
            } else {
                // Return state
                self.layer.borderWidth = 0
                self.layer.shadowOffset = CGSize.zero
                self.layer.shadowColor = UIColor.clear.cgColor
                self.backgroundColor = .black.withAlphaComponent(0.5)
                
                self.cardIcon.tintColor = .clear
//                self.cardIcon.backgroundColor = .clear
            }
        }
    }
    
    
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 28)
        l.text = "/"
        return l
    }()
    
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "*"
        l.font = UIFont(name: "Cinzel-Regular", size: 17)
        l.numberOfLines = 0
        
        return l
    }()
    // MARK: Icon
    let cardIcon: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "checkmark.circle.fill")
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.tintColor = .clear
        
        iv.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        return iv
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = .black.withAlphaComponent(0.5)
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        
        
        // setup
        setupStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, subtitle: String?) {
        self.title.text = title
        self.subtitle.text = subtitle
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let lableStack = UIStackView(arrangedSubviews: [title,subtitle])
        lableStack.axis = .vertical
        lableStack.alignment = .fill
//        lableStack.distribution = .fill
        lableStack.spacing = 0
        
        let cardContent = UIStackView(arrangedSubviews: [lableStack, cardIcon])
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .horizontal
        cardContent.alignment = .center
//        subTitleStack.distribution = .fill
        cardContent.spacing = 0
        self.addSubview(cardContent)
        
        NSLayoutConstraint.activate([
        
            cardContent.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            cardContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            cardContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cardContent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
        ])
    }
}
