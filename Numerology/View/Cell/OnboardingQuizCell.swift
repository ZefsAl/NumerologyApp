//
//  OnboardingQuizCell.swift
//  Numerology
//
//  Created by Serj on 24.10.2023.
//

import UIKit

final class OnboardingQuizCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    
    // MARK: - isSelected
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                
                self.selectedIcon.tintColor = .white
                
                // Selected state
                self.layer.borderWidth = DesignSystem.borderWidth
                self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
                self.layer.shadowOpacity = 1
                self.layer.shadowRadius = 16
                self.layer.shadowOffset = CGSize(width: 0, height: 4)
                self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
                
                mainTitle.textColor = .white
            } else {
                self.selectedIcon.tintColor = .clear
                // Default state
                self.layer.borderWidth = 1
                self.layer.shadowOffset = CGSize.zero
                self.layer.shadowColor = UIColor.clear.cgColor
                self.backgroundColor = .black.withAlphaComponent(0.5)
                self.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
                
                mainTitle.textColor = .systemGray
            }
        }
    }
    
    
    // MARK: Main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 20)
        l.textColor = .systemGray
        return l
    }()
    
    // MARK: Icon
    let selectedIcon: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        
        iv.image = config
        
        
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.tintColor = .clear
//        iv.tintColor = .white
        
//        iv.heightAnchor.constraint(equalToConstant: 32).isActive = true
//        iv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        return iv
    }()
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.layer.cornerRadius = 16
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
    func configure(title: String) {
        self.mainTitle.text = title
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // Card Content
        let cardContent = UIStackView(arrangedSubviews: [mainTitle,UIView(),selectedIcon])
        
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .horizontal
        cardContent.alignment = .center
        cardContent.distribution = .fill
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


