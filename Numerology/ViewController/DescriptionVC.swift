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
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.text = String("test")
        l.textAlignment = .left
        
        return l
    }()
    
    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = String("test")
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let about: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = String("test")
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        setBackground(named: "SecondaryBG.png")
        
        setUpStack()
    }
    
    // MARK: Configure
    func configure(title: String, info: String?, about: String?) {
        self.mainTitle.text = title
        self.info.text = info
        self.about.text = about
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [mainTitle,info,about])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 20

        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false

            v.layer.cornerRadius = 15
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.996, alpha: 1).cgColor
            return v
        }()
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
