//
//  FourthViewController.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import UIKit

class FourthViewController: UIViewController {
    
    private let verticalScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: Description
    let descriptionText: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .regular, size: 17)
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let contentStack = UIStackView()
    
    // MARK: view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground(named: "MainBG2")
        setUpStack()
        requestFB()
        
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func requestFB() {
        
        FirebaseManager.shared.getNumerologyIs { arr in
            for item in arr.sorted(by: { $0.number < $1.number }) {
                if item.number == 123 {
                    self.descriptionText.text = item.infoNumerology
                } else {
                    let descriptionView = DescriptionView(frame: .zero, description: item.infoNumerology, number: item.number)
                    self.contentStack.addArrangedSubview(descriptionView)
                }
            }
        }
    }
    

    
    // MARK: Set up Stack
    private func setUpStack() {
        
        
        self.view.addSubview(verticalScrollView)
        
        // Content Stack
        contentStack.addArrangedSubview(descriptionText)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 60
        verticalScrollView.addSubview(contentStack)
        
        
        let viewMargin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor, constant: -36),

            verticalScrollView.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 0),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
}
