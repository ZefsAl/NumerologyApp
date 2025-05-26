//
//  AccordionView.swift
//  Numerology
//
//  Created by Serj on 27.11.2023.
//

import Foundation
import UIKit

final class AccordionView: UIView {
    
    let accordionButton: PremiumAccordionButton = {
        let b = PremiumAccordionButton(isPremium: false, didTapState: false)
        b.setIconChange(state: false, isPremium: false)
        b.addTarget(Any?.self, action: #selector(accordionButtonAct), for: .touchUpInside)
        return b
    }()

    @objc private func accordionButtonAct() {
        info.isHidden = info.isHidden ? false : true
    }

    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.subtitle
        l.textAlignment = .left
        l.numberOfLines = 0
        l.isHidden = true
        return l
    }()
    
    // MARK: - init
    init() {
        super.init(frame: .zero)
        
        setupStack()
        self.showAccordion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(title: String, info: String?, about: String?) {
//        self.accordionButton.setAccordionTitle(title) 
//        self.info.text = info
////        self.about.text = about
//    }
    
    func showAccordion() {
        info.isHidden = false
    }

    // MARK: Set up Stack
    private func setupStack() {

        let contentStack = UIStackView(arrangedSubviews: [
            accordionButton,
            info
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 8

        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0),
        ])
    }

}
