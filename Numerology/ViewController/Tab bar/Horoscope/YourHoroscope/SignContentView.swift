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
    
    let wheel: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "HoroscopeWheel")?.withAlpha(0.3)
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.title
        l.textAlignment = .center
        return l
    }()
    // MARK: - subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    // MARK: image
    let image: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 90).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 90).isActive = true
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
    
    func configure(title: String, subtitle: String, image: UIImage) {
        self.title.text = title
        self.subtitle.text = subtitle
        self.image.image = image
    }
    
    private func setupUI() {
        //
        self.addSubview(wheel)
        let wheelSize: CGFloat = 200
        
        let textStack = UIStackView(arrangedSubviews: [title,subtitle])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .center
        textStack.spacing = 4
        
        //
        let contentStack = UIStackView(arrangedSubviews: [image,textStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.spacing = 0
        //
        let contentCircle: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
            v.layer.cornerRadius = wheelSize/2
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = wheelSize/2
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
            return v
        }()
        
        contentCircle.addSubview(contentStack)
        self.addSubview(contentCircle)
        NSLayoutConstraint.activate([
            //
            wheel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            wheel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            wheel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            wheel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            //
            contentStack.centerXAnchor.constraint(equalTo: contentCircle.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: contentCircle.centerYAnchor, constant: -5),
            contentCircle.heightAnchor.constraint(equalToConstant: wheelSize),
            contentCircle.widthAnchor.constraint(equalToConstant: wheelSize),
            contentCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
}
