//
//  PurchaseButton.swift
//  Numerology
//
//  Created by Serj on 22.08.2023.
//

import UIKit

class PurchaseButton: UIButton {
    
    private var primaryColor: UIColor = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1)
    
    let lable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .lightGray
        l.font = UIFont(weight: .regular, size: 23)
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
    
    override var isTouchInside: Bool {
        bounceAnimate()
        return true
    }
    
    init(frame: CGRect, title: String, primaryColor: UIColor) {
        self.primaryColor = primaryColor
        lable.text = title
        super.init(frame: frame)
        // Style
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.backgroundColor = .systemGray2
        
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
    
    func stateConfig(state: Bool) {
        let duration: Double = 0.3
        
        if state {
            // Animation
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration) {
                    self.lable.textColor = .white
                    self.backgroundColor = self.primaryColor
                    // Shadow
                    self.layer.shadowOpacity = 1
                    self.layer.shadowRadius = 16
                    self.layer.shadowOffset = CGSize(width: 0, height: 4)
                    self.layer.shadowColor = self.primaryColor.withAlphaComponent(0.7).cgColor 
                }
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration) {
                    self.lable.textColor = .lightGray
                    self.backgroundColor = .systemGray2
                    // Shadow
                    self.layer.shadowOpacity = 1
                    self.layer.shadowRadius = 16
                    self.layer.shadowOffset = CGSize(width: 0, height: 4)
                    self.layer.shadowColor = UIColor.clear.cgColor
                }
            }
        }   
    }
}
