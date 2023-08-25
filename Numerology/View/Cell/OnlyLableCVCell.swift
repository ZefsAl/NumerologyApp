//
//  OnlyLableCVCell.swift
//  Numerology
//
//  Created by Serj on 19.08.2023.
//

import UIKit

class OnlyLableCVCell: UICollectionViewCell {
 
    let onlyLableCVCellID = "onlyLableCVCellID"
    
//    override var isSelected: Bool {
//        didSet {
//            if self.isSelected {
//                self.layer.borderColor = UIColor.systemPurple.cgColor
//                self.cardIcon.tintColor = .white
//            } else {
//                self.layer.borderColor = UIColor.clear.cgColor
//                self.cardIcon.tintColor = .clear
//            }
//        }
//    }
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        l.text = "/"
        return l
    }()
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
//        self.backgroundColor = .clear
        self.backgroundColor = .systemOrange
        // Border
//        self.layer.cornerRadius = 15
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.clear.cgColor
        
        // Setup
        setUpStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String) {
        self.title.text = title
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
//        let lableStack = UIStackView(arrangedSubviews: [title,subtitle])
//        lableStack.axis = .vertical
//        lableStack.alignment = .fill
////        lableStack.distribution = .fill
//        lableStack.spacing = 10
        
//        let cardContent = UIStackView(arrangedSubviews: [lableStack, cardIcon])
//        cardContent.translatesAutoresizingMaskIntoConstraints = false
//        cardContent.axis = .horizontal
//        cardContent.alignment = .center
////        subTitleStack.distribution = .fill
//        cardContent.spacing = 10
//        self.addSubview(cardContent)
        
        self.addSubview(title)
        
        NSLayoutConstraint.activate([
        
//            title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
//            title.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
        ])
    }
}
