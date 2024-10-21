//
//  ChipsButton.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

class CapsuleButton: UIButton {
    
    // MARK: - Loader
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.contentMode = .scaleAspectFit
        aiv.color = .white
        aiv.hidesWhenStopped = true
        aiv.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return aiv
    }()
    
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.title_h5
        l.textAlignment = .left
        l.textColor = .white
        l.isUserInteractionEnabled = false
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
        
        
        let contentStack = UIStackView(arrangedSubviews: [title,activityIndicatorView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.distribution = .fill
        contentStack.spacing = 4
        contentStack.isUserInteractionEnabled = false 
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

