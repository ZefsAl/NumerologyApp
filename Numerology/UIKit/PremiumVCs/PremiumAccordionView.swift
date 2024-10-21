//
//  AccordionView.swift
//  Numerology
//
//  Created by Serj on 27.11.2023.
//

import SwiftUI
import UIKit

final class PremiumAccordionView: UIView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    let premiumBadgeManager = PremiumManager()
    
    lazy var accordionButton: PremiumAccordionButton = {
        let b = PremiumAccordionButton()
        return b
    }()

    
    private var infotHeightConstant: CGFloat = 50
    private lazy var infoHeight = self.premiumTextViewHost.view.heightAnchor.constraint(equalToConstant: self.infotHeightConstant)
    
    @objc private func showContent() {
        self.premiumTextViewHost.view.fadeTransition()
        infoHeight.isActive = accordionButton.didTapState
    }
    
    @objc private func showPaywall() {
        guard self.remoteOpenDelegate?.openFrom?.checkAndShowPaywall() == true else { return }
        infoHeight.isActive = accordionButton.didTapState
    }

    let sharedData = PremiumTextManager()
    
    lazy var premiumTextViewHost: UIHostingController = {
        let contentView = PremiumTextView_SUI(sharedText: sharedData)
        let h = UIHostingController(rootView: contentView)
        return h
    }()
    
    // MARK: - init
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupStack()
    }
    
    init(
        title: String,
        info: String?,
        isPremium: Bool,
        visibleConstant: CGFloat? = nil
    ) {
        self.init()
        // setup
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
        self.infotHeightConstant = visibleConstant ?? infotHeightConstant
        // content
        self.sharedData.data = info
        self.sharedData.isPremium = isPremium ? !PremiumManager.isUserPremium() : isPremium
        
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

        self.premiumBadgeManager.setPremiumBadgeObserver(observer: self, action: #selector(self.notificationAllowPremiumContent(notification:)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Notification action
    @objc private func notificationAllowPremiumContent(notification: Notification) {
        guard let premiumState = notification.object as? Bool else { return }
        self.sharedData.isPremium = !premiumState
    }
    
    

    // MARK: Set up Stack
    private func setupStack() {

        let contentStack = UIStackView(arrangedSubviews: [
            accordionButton,
            premiumTextViewHost.view,
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .fill
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
