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
        l.font = UIFont(name: "Cinzel-Regular", size: 48)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        // Line height: 67.2 pt
        l.textAlignment = .center
        
        return l
    }()
    // MARK: subtitle
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.text = "*"
        l.font = UIFont(name: "Cinzel-Regular", size: 28)
        l.textAlignment = .center
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.04
        
        return l
    }()
    // MARK: promo Subtitle
    private let promoSubtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "*"
        // Style
        l.font = UIFont(name: "SourceSerifPro-Light", size: 24)
        l.lineBreakMode = .byWordWrapping
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.2
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
//    let imageView: UIImageView = {
//        var imageView = UIImageView(frame: self.bounds)
//        return imageView
//    }()
//    var imageView : UIImageView!
//    imageView = UIImageView(frame: self.bounds)
//    imageView.contentMode =  UIView.ContentMode.scaleAspectFill
//    imageView.clipsToBounds = true
//    imageView.image = background
//    imageView.center = self.center

    
    // MARK: Init
    init(frame: CGRect, namedBG: String) {
        super.init(frame: frame)
        
        setOnboardingBG(named: namedBG) // First
        setUpStack() // Second
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, subtitle: String, promoSubtitle: String) {
        self.title.text = title
        self.subtitle.text = subtitle
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
    private func setUpStack() {
        
        
        let contentStack = UIStackView(arrangedSubviews: [title,subtitle,promoSubtitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .center
        contentStack.spacing = 10
        
        
    
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -0),
            
//            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
//            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    

}
