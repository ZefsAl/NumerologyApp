//
//  CompatibilityCVCell.swift
//  Numerology
//
//  Created by Serj on 18.01.2024.
//

import UIKit

class CompatibilityCVCell: UICollectionViewCell {

    static var reuseID: String {
        String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                UIView.animate(withDuration: 0.35, delay: 0) {
                    self.userView.backgroundColor = self.primaryColor
                }
                
            } else {
                UIView.animate(withDuration: 0.35, delay: 0) {
                    self.userView.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
                }
            }
        }
    }
    
    lazy var userView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        // Border
        v.layer.borderWidth = 2
        v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
        v.layer.borderColor = primaryColor.cgColor
        v.layer.cornerRadius = 16
        // Shadow
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 16
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        v.layer.shadowColor = primaryColor.withAlphaComponent(0.5).cgColor
        
        v.addSubview(self.signImage)
        
        let spacing: CGFloat = 12
        NSLayoutConstraint.activate([
            signImage.topAnchor.constraint(equalTo: v.topAnchor, constant: 12),
            signImage.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 12),
            signImage.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -12),
            signImage.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -12)
        ])
        return v
    }()
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .semiBold, size: 14)
        l.textAlignment = .center
        return l
    }()
    // MARK: - sign Image
    let signImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 45).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 45).isActive = true
        iv.image = UIImage(named: "plug")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .orange
        // Style
//        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
//        // Border
//        self.layer.cornerRadius = 16
//        self.layer.borderWidth = 2
//        self.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
//        self.layer.shadowOpacity = 1
//        self.layer.shadowRadius = 16
//        self.layer.shadowOffset = CGSize(width: 0, height: 4)
//        self.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
        
        // Setup
//        setUpStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var primaryColor: UIColor = .white
    
    // MARK: Configure
    func configure(title: String, signImage: UIImage?, primaryColor: UIColor?) {
        self.title.text = title
        self.signImage.image = signImage
        self.primaryColor = primaryColor ?? self.primaryColor
        setUpStack()
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // MARK: user view
//        let userView: UIView = {
//            let v = UIView()
//            v.translatesAutoresizingMaskIntoConstraints = false
//            // Border
//            v.layer.borderWidth = 2
//            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
//            v.layer.borderColor = primaryColor.cgColor
//            v.layer.cornerRadius = 16
//            // Shadow
//            v.layer.shadowOpacity = 1
//            v.layer.shadowRadius = 16
//            v.layer.shadowOffset = CGSize(width: 0, height: 4)
//            v.layer.shadowColor = primaryColor.withAlphaComponent(0.5).cgColor
//
//            v.addSubview(self.signImage)
//
//            let spacing: CGFloat = 12
//            NSLayoutConstraint.activate([
//                signImage.topAnchor.constraint(equalTo: v.topAnchor, constant: 12),
//                signImage.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 12),
//                signImage.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -12),
//                signImage.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -12)
//            ])
//            return v
//        }()
        
        let contentStack = UIStackView(arrangedSubviews: [userView,title])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
//        contentStack.distribution = .fill
        contentStack.spacing = 8
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
//            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 1),
//            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 1),
//            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1),
//            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
            
//            self.topAnchor.constraint(equalTo: contentStack.topAnchor, constant: 1),
//            self.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 1),
//            self.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -1),
//            self.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: -1)
            
        ])
    }
}
