//
//  AboutCVCell.swift
//  Numerology
//
//  Created by Serj on 11.11.2023.
//

import UIKit

class AboutCVCell: UICollectionViewCell {
 
    static var reuseID: String {
        String(describing: self)
    }
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .semiBold, size: 15)
        l.textAlignment = .center
        l.text = "Read more"
        return l
    }()
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .semiBold, size: 15)
        l.numberOfLines = 4
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
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        )
        iv.image = configImage
        
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup
        setUpStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(subtitle: String) {
        self.subtitle.text = subtitle
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        let readMoreStack = UIStackView(arrangedSubviews: [title,cardIcon,UIView()])
        readMoreStack.axis = .horizontal
        readMoreStack.alignment = .center
        readMoreStack.spacing = 6
        
        let contentStack = UIStackView(arrangedSubviews: [subtitle,readMoreStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .leading
        contentStack.spacing = 8
        
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            readMoreStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            readMoreStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0)
        ])
    }
}
