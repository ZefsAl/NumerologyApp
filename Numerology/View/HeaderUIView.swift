//
//  HeaderUIView.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit

class HeaderUIView: UIView {
    
    // MARK: Hello Title
    let helloTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.text = String("Hello, NAME")
        return l
    }()
    // MARK: Profile Icon
    let profileIcon: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "person.crop.circle.fill")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        
        iv.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        return iv
    }()
    
    // MARK: Profile Button
    let profileButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        let configImage = UIImage(systemName: "person.crop.circle.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
        let iv = UIImageView(image: configImage)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        b.addSubview(iv)
        iv.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        
        return b
    }()
    
    
    // MARK: Today Date
    let todayDate: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        l.text = String("Today")
        l.numberOfLines = 0
        return l
    }()
    // MARK: User Date
    let userDate: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        l.text = String("My date ")
        l.numberOfLines = 0
        return l
    }()
    
    
let shapeView = OvalShapeView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
//        self.backgroundColor = .clear
        
        setUpStack()
    }
    
    // MARK: Configure
    func configure(helloTitle: String, todayDate: String, userDate: String) {
        self.helloTitle.text = "Hello, \(helloTitle)"
        self.todayDate.text = "Today\n\(todayDate)"
        self.userDate.text = "My date\n\(userDate)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set up Stack
    private func setUpStack() {
        // FIrst Layer
        self.addSubview(shapeView)
        
        let firstStack = UIStackView(arrangedSubviews: [helloTitle,profileButton])
        firstStack.axis = .horizontal
        firstStack.alignment = .center

        
        let secondStack = UIStackView(arrangedSubviews: [todayDate,userDate])
        secondStack.translatesAutoresizingMaskIntoConstraints = false
        secondStack.axis = .horizontal
        secondStack.distribution = .equalCentering
        secondStack.spacing = 0
        
        let mainStack = UIStackView(arrangedSubviews: [firstStack,secondStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.spacing = 0
        mainStack.alignment = .fill
    
        
        self.addSubview(mainStack)
        
        
        NSLayoutConstraint.activate([
            
            profileButton.widthAnchor.constraint(equalToConstant: 32),
            profileButton.heightAnchor.constraint(equalToConstant: 32),
            
            secondStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 0),
            secondStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: 0),
            
            mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 44),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            
            shapeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            shapeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            shapeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            shapeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0),

        ])
    }
    
}
