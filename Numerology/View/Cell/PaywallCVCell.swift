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
                self.layer.borderColor = UIColor.systemPurple.cgColor
                self.cardIcon.tintColor = .white
            } else {
                self.layer.borderColor = UIColor.clear.cgColor
                self.cardIcon.tintColor = .clear
            }
        }
    }
    
    
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        l.text = "/"
        return l
    }()
    
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "*"
        l.font = UIFont.systemFont(ofSize: 16, weight: .light)
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
        
//        iv.frame =
        
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
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        
        // Setup
        setUpStack()
        
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
    private func setUpStack() {
        
        let lableStack = UIStackView(arrangedSubviews: [title,subtitle])
        lableStack.axis = .vertical
        lableStack.alignment = .fill
//        lableStack.distribution = .fill
        lableStack.spacing = 10
        
        let cardContent = UIStackView(arrangedSubviews: [lableStack, cardIcon])
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .horizontal
        cardContent.alignment = .center
//        subTitleStack.distribution = .fill
        cardContent.spacing = 10
        self.addSubview(cardContent)
        
        NSLayoutConstraint.activate([
        
            cardContent.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cardContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            cardContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            cardContent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
        ])
    }
}
