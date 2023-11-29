//
//  AboutYouVC.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit

class AboutYouVC: UIViewController {

    let signcharacteristics = AccordionView()
    let learnMore = AccordionView()
//    let theBestQualities = AccordionView()
    
    let signContent = SignContentView()
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        setUpStack()
    }
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [signcharacteristics,learnMore])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 8

        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = 2
            v.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
            return v
        }()
        cardView.addSubview(contentStack)
        //
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(signContent)
        contentScrollView.addSubview(cardView)
        //
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            // contentStack
            contentStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -0),
            contentStack.widthAnchor.constraint(equalTo: cardView.widthAnchor, constant: -32),
            //
            signContent.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 0),
            signContent.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 30),
            signContent.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -30),
            signContent.widthAnchor.constraint(equalTo: scrollViewMargin.widthAnchor, constant: -60),
            signContent.heightAnchor.constraint(equalTo: signContent.widthAnchor),
            // Card View
            cardView.topAnchor.constraint(equalTo: signContent.bottomAnchor, constant: 24),
            cardView.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            cardView.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            cardView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            cardView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            //
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}
