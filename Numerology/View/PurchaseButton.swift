//
//  PurchaseButton.swift
//  Numerology
//
//  Created by Serj on 22.08.2023.
//

import UIKit

class PurchaseButton: UIButton {
    
    let lable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .white
        l.text = "Try it".uppercased()
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return l
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.contentMode = .scaleAspectFit
        aiv.color = .white
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.3568627451, blue: 0.6431372549, alpha: 1)
        
        
        let btnContentStack = UIStackView(arrangedSubviews: [lable, activityIndicatorView])
        btnContentStack.translatesAutoresizingMaskIntoConstraints = false
        btnContentStack.spacing = 8
        btnContentStack.axis = .horizontal
        btnContentStack.alignment = .center
        btnContentStack.isUserInteractionEnabled = false 
        
        self.addSubview(btnContentStack)
        btnContentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnContentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
