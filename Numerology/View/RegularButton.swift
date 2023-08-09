//
//  RegularButton.swift
//  Numerology
//
//  Created by Serj on 03.08.2023.
//

import UIKit

class RegularButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.3568627451, blue: 0.6431372549, alpha: 1)
        
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .white
        l.text = "DONE"
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        self.addSubview(l)
        l.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
