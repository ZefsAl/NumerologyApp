//
//  SpecialOfferButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 31.07.2024.
//

import UIKit
import RevenueCat


protocol SpecialOfferButtonDelegate {
    func todayTipAction()
}


final class SpecialOfferButton: UIButton {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    var specialOfferButtonDelegate: SpecialOfferButtonDelegate? = nil
    
    // MARK: - 🟢 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        CustomAnimation.setPulseAnimation(to: self, toValue: 1.1, fromValue: 0.9)
        self.validateConfigState()
        
        // target
        self.addTarget(Any?.self, action: #selector(specialOfferAct), for: .touchUpInside)
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - button Config State
    private func validateConfigState() {
        self.buttonConfigure(isHavePremium: PremiumManager.isUserPremium())
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.notificationConfigState(notification:)),
            name: .premiumBadgeNotificationKey,
            object: nil
        )
    }
    
    // MARK: - Button Action
    @objc private func specialOfferAct(_ sender: SpecialOfferButton) {
        if PremiumManager.isUserPremium() {
            self.specialOfferButtonDelegate?.todayTipAction()
        } else {
            PremiumManager.showSpecialOffer(from: self.remoteOpenDelegate?.openFrom)
        }
    }
    
    // MARK: - target - notification
    @objc private func notificationConfigState(notification: Notification) {
        guard let bool = notification.object as? Bool else { return }
        self.buttonConfigure(isHavePremium: bool)
    }
    
    // MARK: - Config
    private func buttonConfigure(isHavePremium: Bool) {
        self.imageView?.contentMode = .scaleAspectFit
        self.setImage(
            UIImage(named: isHavePremium ? "Info_SF" : "Gift_SF"),
            for: .normal
        )
    }
    
}
