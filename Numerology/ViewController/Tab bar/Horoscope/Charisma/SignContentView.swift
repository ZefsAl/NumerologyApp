//
//  SignContentView.swift
//  Numerology
//
//  Created by Serj on 27.11.2023.
//

import Foundation
import UIKit

// MARK: - Sign Content
final class SignContentView: UIView {
    
    let wheelBG: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "HoroscopeWheel")?.withAlpha(0.3)
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    // MARK: image
    let image: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 291).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 291).isActive = true
        iv.image = UIImage(named: "plug")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        self.image.image = image
    }
    
    private func setupUI() {
        //
//        let wheelSize: CGFloat = 290
        self.wheelBG.addSubview(image)
        //
        let contentStack = UIStackView(arrangedSubviews: [
            wheelBG,
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.spacing = 0
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            self.wheelBG.heightAnchor.constraint(equalTo: contentStack.widthAnchor),
            self.image.centerYAnchor.constraint(equalTo: self.wheelBG.centerYAnchor),
            self.image.centerXAnchor.constraint(equalTo: self.wheelBG.centerXAnchor),
            //
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
}
