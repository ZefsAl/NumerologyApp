//
//  BigCardCVC.swift
//  Numerology
//
//  Created by Serj on 28.07.2023.
//

import UIKit

class BigCardCVCell: UICollectionViewCell {
 
    let bigCardCVCID = "bigCardCVCID"
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        l.text = String("test").uppercased()
        return l
    }()
    
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "*"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.numberOfLines = 0
        
        return l
    }()
    // MARK: Icon
    let cardIcon: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        
        iv.heightAnchor.constraint(equalToConstant: 16).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        return iv
    }()
    
//    // MARK: bgImage
//    let bgImage: UIImageView = {
//       let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        iv.image = UIImage(named: "plug")
//        iv.contentMode = .scaleAspectFit
//
//        return iv
//    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = .black.withAlphaComponent(0.5)
        // Border
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.996, alpha: 1).cgColor
        
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
        let iconStack = UIStackView(arrangedSubviews: [UIView(),cardIcon])
        iconStack.axis = .vertical
        iconStack.alignment = .bottom
        iconStack.distribution = .fill
        
        
        let subTitleStack = UIStackView(arrangedSubviews: [subtitle, iconStack])
        subTitleStack.axis = .horizontal
        subTitleStack.alignment = .top
        subTitleStack.distribution = .fill
        subTitleStack.spacing = 10
        
        let cardContent = UIStackView(arrangedSubviews: [title,subTitleStack])
        cardContent.translatesAutoresizingMaskIntoConstraints = false
        cardContent.axis = .vertical
        cardContent.alignment = .top
        subTitleStack.distribution = .fill
        cardContent.spacing = 10
        self.addSubview(cardContent)
        
        NSLayoutConstraint.activate([
            
            cardIcon.bottomAnchor.constraint(equalTo: subTitleStack.bottomAnchor),
            cardIcon.trailingAnchor.constraint(equalTo: subTitleStack.trailingAnchor),
            
            subTitleStack.trailingAnchor.constraint(equalTo: cardContent.trailingAnchor),
            subTitleStack.leadingAnchor.constraint(equalTo: cardContent.leadingAnchor),

        
            cardContent.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cardContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            cardContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            cardContent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
//            self.heightAnchor.constraint(equalToConstant: 142)
            
            
        ])
    }
}
