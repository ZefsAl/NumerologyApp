//
//  AccordionView.swift
//  Numerology
//
//  Created by Serj on 27.11.2023.
//

import Foundation
import UIKit

final class PremiumAccordionView: UIView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    private var isPremium: Bool? = nil
    
    lazy var accordionButton: AccordionButton = {
        let b = AccordionButton()
        return b
    }()

    
    private var infotHeightConstant: CGFloat = 50
    private lazy var infoHeight = info.heightAnchor.constraint(equalToConstant: infotHeightConstant)
    
    @objc private func showContent() {
        infoHeight.isActive = accordionButton.didTapState
    }
    
    @objc private func showPaywall() {
        guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
        infoHeight.isActive = accordionButton.didTapState
    }
    
    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.TextCard.subtitle
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: - init
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(
        title: String,
        info: String?,
        isPremium: Bool,
        visibleConstant: CGFloat? = nil
    ) {
        self.init()
        // setup
        setupStack()
        configureData(
            title: title,
            info: info,
            isPremium: isPremium,
            visibleConstant: visibleConstant
        )
    }
    
    func configureData(
        title: String,
        info: String?,
        isPremium: Bool,
        visibleConstant: CGFloat? = nil
    ) {
        // important
        self.isPremium = isPremium
        self.infotHeightConstant = visibleConstant ?? infotHeightConstant
        // content
        self.info.text = info
        infoHeight.isActive = true
        // accordion
        self.accordionButton.setAccordionTitle(title)
        
        // default icon state
        self.accordionButton.setIconChange(state: true, isPremium: isPremium)
        
        self.accordionButton.addTarget(
            Any?.self,
            action: isPremium ? #selector(showPaywall) : #selector(showContent),
            for: .touchUpInside
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Set up Stack
    private func setupStack() {
        let divider: UIView = {
            let v = UIView()
            v.backgroundColor = .systemGray.withAlphaComponent(0.5)
            v.heightAnchor.constraint(equalToConstant: 2).isActive = true
            return v
        }()

        let contentStack = UIStackView(arrangedSubviews: [
            accordionButton,
            info,
            divider
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
