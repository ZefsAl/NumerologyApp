//
//  DescriptionVC.swift
//  Numerology
//
//  Created by Serj on 27.07.2023.
//

import UIKit

class DescriptionVC: UIViewController {

    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: title
    let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.title_Sb_24
        l.textAlignment = .left
        return l
    }()
    
    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle_Sb_15
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    let about: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle_Sb_15
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    // cardView + Border
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        // Style
        v.backgroundColor = DesignSystem.Numerology.backgroundColor
        // Border
        v.layer.cornerRadius = DesignSystem.maxCornerRadius
        v.layer.borderWidth = DesignSystem.borderWidth
        v.layer.borderColor = DesignSystem.Numerology.primaryColor.cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 16
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        v.layer.shadowColor = DesignSystem.Numerology.shadowColor.cgColor
        return v
    }()
    
    // MARK: 🟢 View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        
        AnimatableBG().setBackground(vc: self)
        setupStack()
    }
    
    // MARK: Configure
    func configure(title: String, info: String?, about: String?) {
        self.mainTitle.text = title
        self.info.text = info
        self.about.text = about
    }
    
    func setStyleWithTint(
        bgImage: String?,
        primaryColor: UIColor?,
        bgColor: UIColor? = DesignSystem.Numerology.backgroundColor
    ) {
        // BG
        self.setBackground(named: bgImage ?? "MainBG2.png")
        cardView.backgroundColor = bgColor
        cardView.layer.borderColor = primaryColor?.cgColor
        cardView.layer.shadowColor = primaryColor?.cgColor
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [mainTitle,info,about])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 8
        
        cardView.addSubview(contentStack)
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(cardView)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            // contentStack
            contentStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: cardView.widthAnchor, constant: -32),
            contentStack.heightAnchor.constraint(equalTo: cardView.heightAnchor, constant: -32),
            
            // Card View
            cardView.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 24),
            cardView.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            cardView.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            cardView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            cardView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }


}
