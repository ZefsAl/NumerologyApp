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
        l.font = UIFont(weight: .bold, size: 20)
        l.text = "Try it".uppercased()
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
        // Style
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.backgroundColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        
        
        let btnContentStack = UIStackView(arrangedSubviews: [lable, activityIndicatorView])
        btnContentStack.translatesAutoresizingMaskIntoConstraints = false
        btnContentStack.spacing = 8
        btnContentStack.axis = .horizontal
        btnContentStack.alignment = .center
        btnContentStack.isUserInteractionEnabled = false 
        
        self.addSubview(btnContentStack)
        btnContentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnContentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
