//
//  CardCollectionViewCell.swift
//  Numerology
//
//  Created by Serj on 19.07.2023.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
 
    let cardCollectionID = "cardCollectionID"
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.text = ""
        l.textAlignment = .center
        
        return l
    }()
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = ""
        l.font = UIFont.systemFont(ofSize: 12, weight: .light)
        l.numberOfLines = 0
        
        return l
    }()
    
    // MARK: bgImage
    let bgImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iv.image = UIImage(named: "plug")
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    
    
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
    func configure(title: String, subtitle: String?, bgImage: UIImage?) {
        self.title.text = title
        self.subtitle.text = subtitle
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.bgImage.image = bgImage?.withAlpha(0.3) ?? UIImage(named: "plug")
        }
        
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        self.addSubview(bgImage)
        
        let titleStack = UIStackView(arrangedSubviews: [title])
        titleStack.axis = .vertical
        titleStack.alignment = .center
        
        let contentStack = UIStackView(arrangedSubviews: [titleStack,subtitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false 
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .leading
        
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            
            titleStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            titleStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
