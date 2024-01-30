//
//  AccordionView.swift
//  Numerology
//
//  Created by Serj on 27.11.2023.
//

import Foundation
import UIKit

final class AccordionView: UIView {

    let accordionButton: AccordionButton = {
        let b = AccordionButton()
        b.addTarget(Any?.self, action: #selector(accordionButtonAct), for: .touchUpInside)
        return b
    }()

    @objc private func accordionButtonAct() {
        about.isHidden = about.isHidden ? false : true
        info.isHidden = info.isHidden ? false : true
    }

    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .semiBold, size: 20)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.isHidden = true
        return l
    }()

    let about: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .regular, size: 17)
        l.isHidden = true
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, info: String?, about: String?) {
        self.accordionButton.mainTitle.text = title
        self.info.text = info
        self.about.text = about
    }
    
    func showAccordion() {
        about.isHidden = false
        info.isHidden = false
    }

    // MARK: Set up Stack
    private func setUpStack() {
        let divider: UIView = {
            let v = UIView()
            v.backgroundColor = .systemGray.withAlphaComponent(0.5)
            v.heightAnchor.constraint(equalToConstant: 2).isActive = true
            return v
        }()

        let contentStack = UIStackView(arrangedSubviews: [accordionButton,info,about,divider])
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
