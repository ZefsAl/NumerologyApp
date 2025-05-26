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
        v.layer.borderWidth = DS.borderWidth
        v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
        v.layer.borderColor = primaryColor.cgColor
        v.layer.cornerRadius = DS.maxCornerRadius
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
        l.font = UIFont.setSourceSerifPro(weight: .semiBold, size: 12)
        l.textAlignment = .center
        return l
    }()
    // MARK: - sign Image
    let signImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 35).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 35).isActive = true
        iv.image = UIImage(named: "plug")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        setupStack()
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [userView,title])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.spacing = 8
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
        ])
    }
}
