//
//  ButtonCVCell.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

// Rename to Chips *
class ButtonCVCell: UICollectionViewCell {
 
    let buttonCVCellID = "buttonCVCellID"
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.996, alpha: 1).cgColor
            } else {
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    // MARK: title
    private let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        l.text = String("test")
        l.textAlignment = .center
        
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
//        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black.withAlphaComponent(0.5)
        // Border
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        
        // For size cell by content + Constraints
        
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
        
        self.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    
    
}
