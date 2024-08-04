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
    let readMore: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .semiBold, size: 15)
        l.textAlignment = .center
        l.text = "Read more"
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        return l
    }()
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 14)
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
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
        iv.tintColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setup
        setupStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(subtitle: String) {
        self.subtitle.text = subtitle
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let readMoreBTNStack = UIStackView(arrangedSubviews: [readMore,cardIcon])
        readMoreBTNStack.axis = .horizontal
        readMoreBTNStack.alignment = .center
        readMoreBTNStack.spacing = 6
        
        let contentStack = UIStackView(arrangedSubviews: [subtitle,readMoreBTNStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .center
        contentStack.spacing = 0
        
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
//            readMoreBTNStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
//            readMoreBTNStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
//            readMoreBTNStack.widthAnchor.constraint(equalToConstant: 100),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0)
        ])
    }
}
