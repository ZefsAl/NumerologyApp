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
        l.font = UIFont.systemFont(ofSize: 100, weight: .semibold)
        l.text = "0"
        l.textAlignment = .center
        l.numberOfLines = 0
        
        return l
    }()
    // MARK: user Lable
    let userLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = "USER"
        l.textAlignment = .center
        l.numberOfLines = 0
        
        return l
    }()
    
    // MARK: partner Number
    let partnerNumber : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 100, weight: .semibold)
        l.text = "0"
        l.textAlignment = .center
        l.numberOfLines = 0
        
        return l
    }()
    // MARK: Partner Lable
    let partnerLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = "Partner"
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    // MARK: Plus lable
    let plusLable : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        l.text = "+"
        l.textAlignment = .center
//        l.numberOfLines = 0
//        l.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            l.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        return l
    }()
    
    // MARK: lableDescription
    private let lableDescription: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = "Hello, NAME Hello, NAME Hello, NAME Hello, NAME Hello, NAME Hello, NAME Hello, NAME "
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "MainBG.png")
//        view.backgroundColor = .black
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
            v.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.09019607843, blue: 0.1725490196, alpha: 1)
            v.layer.cornerRadius = 15
            
            v.addSubview(self.userNumber)
            
            NSLayoutConstraint.activate([
                userNumber.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                userNumber.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 32),
                userNumber.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -32),
                userNumber.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16),
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
            v.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.09019607843, blue: 0.1725490196, alpha: 1)
            v.layer.cornerRadius = 15
            
            v.addSubview(self.partnerNumber)
            
            NSLayoutConstraint.activate([
                partnerNumber.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                partnerNumber.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 32),
                partnerNumber.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -32),
                partnerNumber.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16),
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
//        numbersStack.spacing = 0
//        numbersStack.backgroundColor = .orange
        

       
        
        // cardView + Border
        let descriptionView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false

            v.layer.cornerRadius = 15
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.996, alpha: 1).cgColor
            
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
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

}
