//
//  GenderCVCell.swift
//  Numerology
//
//  Created by Serj on 25.10.2023.
//

import UIKit

final class GenderCVCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    
    // MARK: - isSelected
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                
                self.icon.layer.opacity = 1
                
                // Selected state
                self.layer.borderWidth = DS.borderWidth
                self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
                self.layer.shadowOpacity = 1
                self.layer.shadowRadius = 16
                self.layer.shadowOffset = CGSize(width: 0, height: 4)
                self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
                
                title.textColor = .white
            } else {
                self.icon.layer.opacity = 0.5
                // Default state
                self.layer.borderWidth = 1
                self.layer.shadowOffset = CGSize.zero
                self.layer.shadowColor = UIColor.clear.cgColor
                self.backgroundColor = .black.withAlphaComponent(0.5)
                self.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
                
                title.textColor = .systemGray
            }
        }
    }
    
    
    // MARK: Main Title
    private let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 20)
        l.textColor = .systemGray
        return l
    }()
    
    // MARK: Icon
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.layer.opacity = 0.5
        
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        return iv
    }()
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.layer.cornerRadius = DS.maxCornerRadius
        self.clipsToBounds = false
        self.layer.borderWidth = 1
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7).withAlphaComponent(0.7)
        layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
        
        // setup
        setupStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, iconNamed: String) {
        self.title.text = title
        self.icon.image = UIImage(named: iconNamed)

    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // Card Content
        let cardContent = UIStackView(arrangedSubviews: [icon,title])
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .vertical
        cardContent.alignment = .center
        cardContent.distribution = .fill
        cardContent.layer.cornerRadius = DS.maxCornerRadius
        cardContent.spacing = 16
        
        self.addSubview(cardContent)
        
        NSLayoutConstraint.activate([
            cardContent.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardContent.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}


