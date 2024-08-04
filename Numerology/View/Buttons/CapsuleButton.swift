//
//  ChipsButton.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

class CapsuleButton: UIButton {
    
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle
        l.textAlignment = .left
        l.textColor = .white
        l.text = "Next"
        
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.addTarget(Any?.self, action: #selector(animateAction), for: .touchUpInside)
    }
    
    private func setupUI() {
        self.backgroundColor = DesignSystem.Horoscope.primaryColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = DesignSystem.Horoscope.shadowColor.cgColor
        // add
        self.addSubview(self.title)
        NSLayoutConstraint.activate([
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

