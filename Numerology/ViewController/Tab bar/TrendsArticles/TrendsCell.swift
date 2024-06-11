//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.06.2024.
//

import UIKit

class TrendsCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    let premiumBadgeManager = PremiumBadgeManager()
    
    // MARK: title
    let imageTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 26)
        l.textAlignment = .left
        l.textColor = DesignSystem.TrendsArticles.textColor
        return l
    }()
    
    let shareButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        let configImage = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
        b.setImage(configImage, for: .normal)
        return b
    }()
    
    
    
    let likeButton = LikeButton(type: .system)
    
//    // MARK: Icon
    let bgImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = DesignSystem.TrendsArticles.primaryColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = DesignSystem.TrendsArticles.shadowColor.cgColor
        //
        self.clipsToBounds = true
        // setup
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(
        imageTitle: String,
        bgImage: UIImage?,
        isPremium: Bool,
        likes: Int
    ) {
        self.imageTitle.text = imageTitle
        self.bgImage.image = bgImage
        likeButton.setAmountLikes(amount: likes)
        if isPremium {
            self.premiumBadgeManager.setPremiumBadgeToCard(
                view: self,
                imageSize: 18,
                side: .topTrailing,
                tintColor: .white
            )
        } else {
            self.premiumBadgeManager.invalidateBadgeAndNotification()
        }
    }
    
    
    
    
    // MARK: Set up Stack
    private func setupStack() {
        // add
        self.addSubview(bgImage) // 1
        Gradients().setBlackGradient(forView: self, height: 66, framePosition: .top)
        Gradients().setBlackGradient(forView: self, height: 66, framePosition: .bottom)
        self.addSubview(imageTitle)
        self.addSubview(shareButton)
        self.addSubview(likeButton)
        //
        
        NSLayoutConstraint.activate([
            // bg Image
            bgImage.topAnchor.constraint(      equalTo: self.topAnchor,      constant: 0),
            bgImage.leadingAnchor.constraint(  equalTo: self.leadingAnchor,  constant: 0),
            bgImage.trailingAnchor.constraint( equalTo: self.trailingAnchor, constant: 0),
            bgImage.bottomAnchor.constraint(   equalTo: self.bottomAnchor,   constant: 0),
            // title
            imageTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            imageTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            // share
            shareButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            // like
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
    }
}
