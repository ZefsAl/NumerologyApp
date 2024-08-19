//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 28.04.2024.
//

import UIKit

class AngelNumbersDescriptionVC: UIViewController {
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    private let headerTitle: SectionHeaderView = {
        let v = SectionHeaderView()
        v.label.text = "Enigmatic Angelic Signs"
        v.label.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return v
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = false
        iv.image = UIImage(named: "AngelNumbersIMG")
        return iv
    }()
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
        l.font = UIFont.init(weight: .regular, size: 17)
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "MainBG2.png")
        AnimatableBG().setBackground(vc: self)
        //
        setupStack()
    }
    
    func configure(number: String, info: String) {
        self.mainTitle.text = "Angelic number - \(number)"
        self.info.text = info
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let cardContentStack = UIStackView(arrangedSubviews: [
            imageView,
            mainTitle,
            info
        ])
        cardContentStack.translatesAutoresizingMaskIntoConstraints = false
        cardContentStack.axis = .vertical
        cardContentStack.spacing = 8
        cardContentStack.clipsToBounds = false
        
        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
            
            v.addSubview(cardContentStack)
            NSLayoutConstraint.activate([
                cardContentStack.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                cardContentStack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
                cardContentStack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
                cardContentStack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16),
                cardContentStack.widthAnchor.constraint(equalTo: v.widthAnchor, constant: -32),
            ])
            
            return v
        }()
        
        // MARK: content Stack
        let contentStack = UIStackView(arrangedSubviews: [headerTitle,cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 12
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 32),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}
