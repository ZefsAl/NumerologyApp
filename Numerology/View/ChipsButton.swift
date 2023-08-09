//
//  ChipsButton.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

class ChipsButton: UIButton {
    
    let title: String?
    
    init(frame: CGRect, title: String) {
        
        self.title = title
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.3568627451, blue: 0.6431372549, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .white
        l.text = title
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        self.addSubview(l)
        l.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        NSLayoutConstraint.activate([
        
            l.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            l.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            l.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            l.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

