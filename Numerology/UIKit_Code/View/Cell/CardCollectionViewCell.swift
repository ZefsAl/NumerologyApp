//
//  CardCollectionViewCell.swift
//  Numerology
//
//  Created by Serj on 19.07.2023.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
 
    let cardCollectionID = "cardCollectionID"
    
    
    let contentStack = UIStackView()
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.CinzelFont.title_h3
        l.textAlignment = .left
        l.clipsToBounds = false
        return l
    }()
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.CinzelFont.subtitle
        l.textAlignment = .left
        l.numberOfLines = 3
        return l
    }()
    
    // MARK: Icon
    let cardIcon: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        
        let configImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .light)
        )
        iv.image = configImage
        
        iv.heightAnchor.constraint(equalToConstant: 15).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
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
        iv.isHidden = true
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = DesignSystem.maxCornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
        
        // setup
        setupStack()
        
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
    private func setupStack() {
        
        self.addSubview(bgImage)
        let titleStack = UIStackView(arrangedSubviews: [title,cardIcon])
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .horizontal
        titleStack.clipsToBounds = false
        titleStack.alignment = .center
        
        contentStack.addArrangedSubview(titleStack)
        contentStack.addArrangedSubview(subtitle)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .center
        contentStack.spacing = 0
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            titleStack.heightAnchor.constraint(lessThanOrEqualToConstant: 28),
            
            subtitle.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            titleStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            titleStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
        ])
    }
}
