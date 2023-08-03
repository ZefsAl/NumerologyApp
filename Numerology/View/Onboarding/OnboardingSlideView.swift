//
//  OnboardingSlideView.swift
//  Numerology
//
//  Created by Serj on 01.08.2023.
//

import UIKit

class OnboardingSlideView: UIView {
    
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        l.text = String("test")
        l.textAlignment = .center
        
        return l
    }()
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "TEST2 TEST2 TEST2 TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2TEST2 TEST2 TEST2"
        l.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        l.numberOfLines = 0
        l.textAlignment = .center
        
        return l
    }()

    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUpStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, subtitle: String) {
        self.title.text = title
        self.subtitle.text = subtitle
        
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        
//        let titleStack = UIStackView(arrangedSubviews: [title])
//        titleStack.axis = .vertical
//        titleStack.alignment = .center
        
        let contentStack = UIStackView(arrangedSubviews: [title,subtitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .center
        contentStack.spacing = 10
        
        
    
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            

//            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -0),
            
//            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
//            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    

}
