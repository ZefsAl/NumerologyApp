//
//  OnboardingSlideView.swift
//  Numerology
//
//  Created by Serj on 01.08.2023.
//

import UIKit

class OnboardingSlideView: UIView {
    
    
    // MARK: title
    private let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.font = DesignSystem.CinzelFont.title_Extra
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.textAlignment = .center
        
        return l
    }()
    // MARK: subtitle
//    private let subtitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
//        l.numberOfLines = 0
//        l.text = "*"
//        l.font = UIFont(name: "Cinzel-Regular", size: 28)
//        l.textAlignment = .center
//        return l
//    }()
    // MARK: promo Subtitle
    private let promoSubtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        // Style
        l.font = UIFont(name: "SourceSerifPro-Light", size: 24)
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.textAlignment = .center
        l.adjustsFontSizeToFitWidth = true
        
        return l
    }()
    
    // MARK: Init
    init(frame: CGRect, namedBG: String) {
        super.init(frame: frame)
        
        setOnboardingBG(named: namedBG) // First
        setupStack() // Second
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, promoSubtitle: String) {
        self.title.text = title
        self.promoSubtitle.text = promoSubtitle
        
    }
    
    private func setOnboardingBG(named: String) {
        let background = UIImage(named: named)

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = self.center

        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [title,promoSubtitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .center
        contentStack.spacing = 24
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            
//            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 76),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    

}
