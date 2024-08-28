//
//  descriptionView.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import UIKit

class DescriptionView: UIView {
    
    private let lableDescription: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 17)
        l.textAlignment = .left
        l.numberOfLines = 0 
        
        return l
    }()
    
    private let numberBG: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.font = UIFont.systemFont(ofSize: 150, weight: .regular)
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 150)
        l.textAlignment = .center
        l.textColor = .white.withAlphaComponent(0.35)
        
        return l
    }()
    
    init(frame: CGRect, description: String, number: Int) {
        
        self.lableDescription.text = description
        self.numberBG.text = String(number)
        
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(numberBG)
        self.addSubview(lableDescription)
        
        NSLayoutConstraint.activate([
            lableDescription.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            lableDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            lableDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            lableDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0),
            
            
            numberBG.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            numberBG.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
