//
//  HoroscopeCell.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit


class HoroscopeCell: UICollectionViewCell {

    static var reuseID: String {
        String(describing: self)
    }
    
    
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.FeedCard.title
        l.textAlignment = .left
        l.textColor = DesignSystem.Horoscope.feedCardTextColor
        return l
    }()
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.FeedCard.subtitle
        l.numberOfLines = 0
        l.textAlignment = .left
        l.textColor = DesignSystem.Horoscope.feedCardTextColor
        return l
    }()
    // MARK: Icon
    let cardIcon: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = DesignSystem.Horoscope.feedCardTextColor
        
        let configImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        )
        iv.image = configImage
        
        return iv
    }()
    
    
    // MARK: bgImage
    let image: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 85).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 85).isActive = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = DesignSystem.borderWidth
        self.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
        
        // Setup
        setUpStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, subtitle: String?, setImage: UIImage?) {
        self.title.text = title
        self.subtitle.text = subtitle
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.image.image = setImage?.withTintColor(DesignSystem.Horoscope.feedCardTextColor) ?? UIImage(named: "plug")
        }
        
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        self.addSubview(image)
        
        let titleStack = UIStackView(arrangedSubviews: [title,subtitle])
        titleStack.axis = .vertical
        titleStack.alignment = .fill
        titleStack.spacing = 0
        
        let contentStack = UIStackView(arrangedSubviews: [image,titleStack,UIView(),cardIcon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.distribution = .fill
        contentStack.spacing = 8
        
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
