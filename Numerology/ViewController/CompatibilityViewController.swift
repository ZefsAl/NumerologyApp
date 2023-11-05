//
//  CompatibilityViewController.swift
//  Numerology
//
//  Created by Serj on 07.08.2023.
//

import UIKit

class CompatibilityViewController: UIViewController {
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: user number
    let userNumber : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 80)
        l.text = "0"
        l.textAlignment = .center
        return l
    }()
    // MARK: user Lable
    let userLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "SourceSerifPro-Regular", size: 26)
        l.text = "User"
        l.textAlignment = .center
        
        return l
    }()
    
    // MARK: partner Number
    let partnerNumber : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 80)
        l.text = "0"
        l.textAlignment = .center
        return l
    }()
    // MARK: Partner Lable
    let partnerLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "SourceSerifPro-Regular", size: 26)
        l.text = "Partner"
        l.textAlignment = .center
        return l
    }()
    
    // MARK: Plus lable
    let plusLable : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        l.text = "+"
        l.textAlignment = .center
        
        NSLayoutConstraint.activate([
            l.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        return l
    }()
    
    // MARK: lableDescription
    private let lableDescription: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "SourceSerifPro-Regular", size: 20)
        l.text = "*"
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "EnterDataBG.png")
        setUpStack()
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
                
    }
    
    // MARK: Configure
    func configure(userNumber: String, userLable: String, partnerNumber: String, lableDescription: String) {
        self.userNumber.text = userNumber
        self.userLable.text = userLable
        self.partnerNumber.text = partnerNumber
        self.lableDescription.text = lableDescription
    }
    

    // MARK: Set up Stack
    private func setUpStack() {
        
        // MARK: user view
        let userView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Border
            v.layer.borderWidth = 2
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
            v.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
            v.layer.cornerRadius = 16
            // Shadow
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
            
            v.addSubview(self.userNumber)
            
            NSLayoutConstraint.activate([
                userNumber.topAnchor.constraint(equalTo: v.topAnchor, constant: 10),
                userNumber.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 44),
                userNumber.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -44),
                userNumber.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -8),
            ])

            return v
        }()
        
//         MARK: User Stack
        let userStack = UIStackView(arrangedSubviews: [userView,userLable])
        userStack.axis = .vertical
        userStack.alignment = .center
        userStack.spacing = 10
        
        
        // MARK: user view
        let partnerView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Border
            v.layer.borderWidth = 2
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
            v.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
            v.layer.cornerRadius = 16
            // Shadow
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
            
            v.addSubview(self.partnerNumber)
            
            NSLayoutConstraint.activate([
                partnerNumber.topAnchor.constraint(equalTo: v.topAnchor, constant: 10),
                partnerNumber.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 44),
                partnerNumber.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -44),
                partnerNumber.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -8),
            ])

            return v
        }()
//         MARK: User Stack
        let partnerStack = UIStackView(arrangedSubviews: [partnerView,partnerLable])
        partnerStack.axis = .vertical
        partnerStack.alignment = .center
        partnerStack.spacing = 10
        
    // MARK: numbers Stack
        let numbersStack = UIStackView(arrangedSubviews: [userStack, plusLable, partnerStack])
        numbersStack.translatesAutoresizingMaskIntoConstraints = false
        numbersStack.alignment = .center
        numbersStack.axis = .horizontal
        numbersStack.distribution = .equalSpacing
        
        
        // MARK: description View + Border
        let descriptionView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            
            // Border
            v.layer.borderWidth = 1
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
            v.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
            v.layer.cornerRadius = 16
            
            v.addSubview(lableDescription)
            NSLayoutConstraint.activate([
                lableDescription.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                lableDescription.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
                lableDescription.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
                lableDescription.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16),
            ])
            
            return v
        }()
        
        
        //    MARK: content Stack
        let contentStack = UIStackView(arrangedSubviews: [numbersStack,descriptionView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 40
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 86),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 36),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -36),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -72),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

}
