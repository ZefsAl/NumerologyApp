//
//  RegularButton.swift
//  Numerology
//
//  Created by Serj on 03.08.2023.
//

import UIKit

class RegularBigButton: UIButton {

    private let lable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .white
        l.font = UIFont(name: "Cinzel-Bold", size: 20)
        return l
    }()
    
    private let imageBTN: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    // MARK: button Icon
    let buttonIcon: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let configImage = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold))
        
        iv.image = configImage
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        iv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return iv
    }()
    
    
    // MARK: Init
    init(frame: CGRect, lable: String) {
        super.init(frame: frame)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1)

        // config
        self.lable.text = lable
        setUpStack()
    }
    
    
    
    private func setUpStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [lable,buttonIcon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 12
        contentStack.isUserInteractionEnabled = false
        
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
