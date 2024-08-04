////
////  File.swift
////  Numerology
////
////  Created by Serj_M1Pro on 31.07.2024.
////
//
//import Foundation
//import UIKit
//
//final class CompatibilityHrscpFooter: UICollectionReusableView {
//    
//    static var reuseID: String {
//        String(describing: self)
//    }
//
//    let signsDateTitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.font = DesignSystem.FeedCard.title
//        l.textAlignment = .left
//        l.textColor = DesignSystem.Horoscope.lightTextColor
//        l.numberOfLines = 2
//        l.text = "123 \n 123"
//        return l
//    }()
//    
//    let capsuleHrscpButton: CapsuleButton = {
//        let b = CapsuleButton()
//        b.heightAnchor.constraint(equalToConstant: 36).isActive = true
//        b.widthAnchor.constraint(equalToConstant: 216).isActive = true
//        return b
//    }()
//
//
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        self.backgroundColor = .green
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    private func setupUI() {
//        
//        
//        
//        
//        // MARK: content Stack
//        let contentStack = UIStackView(arrangedSubviews: [
//            signsDateTitle,
//            capsuleHrscpButton
//        ])
//        contentStack.translatesAutoresizingMaskIntoConstraints = false
//        contentStack.alignment = .center
//        contentStack.axis = .vertical
//        contentStack.distribution = .fill
//        contentStack.spacing = 12
//        
//        
//        self.addSubview(contentStack)
//        NSLayoutConstraint.activate([
//            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
////            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            contentStack.topAnchor.constraint(equalTo: self.topAnchor),
//            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
//        ])
//    }
//    
//    
//
//}
