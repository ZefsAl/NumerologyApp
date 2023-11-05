//
//  RegularButton.swift
//  Numerology
//
//  Created by Serj on 03.08.2023.
//

import UIKit

class RegularBigButton: UIButton {

    private let lable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .white
        l.font = UIFont(weight: .regular, size: 23)
        return l
    }()
    
    override var isTouchInside: Bool {
        animateButton()
        return true
    }
    
    
    
    // MARK: Init
    init(frame: CGRect, lable: String) {
        super.init(frame: frame)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1)
        // Shadow
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1).withAlphaComponent(0.7).cgColor

        // config
        self.lable.text = lable
        setUpStack()
    }
    
    
    
    private func setUpStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [lable])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 12
        contentStack.isUserInteractionEnabled = false
        
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
