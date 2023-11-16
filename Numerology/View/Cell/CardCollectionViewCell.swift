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
        l.font = UIFont(weight: .semiBold, size: 22)
        l.textAlignment = .center
        return l
    }()
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .regular, size: 15)
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
        
        let configImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        )
        iv.image = configImage
        
        return iv
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
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
        
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
        
        let titleStack = UIStackView(arrangedSubviews: [title,UIView(),cardIcon])
        titleStack.axis = .horizontal
        titleStack.alignment = .fill
        
        let contentStack = UIStackView(arrangedSubviews: [titleStack,subtitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false 
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .leading
        contentStack.spacing = 8
        
        
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
