//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 01.06.2024.
//

import UIKit

final class PremiumBadgeManager {
    
    static let notificationKey = "PremiumBadgeNotification"
    
    // MARK: - Icon
    private let miniCardPremiumIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    init() {
        setPremiumBadgeObserver(observer: self, action: #selector(self.notificationAllowPremiumContent(notification:)))
    }
    
    func setPremiumBadgeObserver(observer: Any, action: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: action,
            name: Notification.Name(PremiumBadgeManager.notificationKey),
            object: nil
        )
    }
    
    
    enum AvalibleConstraint {
        case bottomTrailing, centerTrailing, topTrailing
    }
    
    func setPremiumBadgeToCard(
        view: UIView,
        imageSize: CGFloat = 18,
        side: AvalibleConstraint = .bottomTrailing,
        tintColor: UIColor = DesignSystem.BadgeColor.transparent
    ) {
        
        // ✅ check, set if user defaults not have access
        let accessVal = UserDefaults.standard.object(forKey: "UserAccessObserverKey") as? Bool
        guard 
            let accessVal = accessVal,
            accessVal == false 
        else { return }
        
        //
        let configImage = UIImage(
            systemName: "lock.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .medium)
        )?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        
        miniCardPremiumIcon.image = configImage

        view.addSubview(miniCardPremiumIcon)
        NSLayoutConstraint.activate([
            miniCardPremiumIcon.widthAnchor.constraint(equalToConstant: imageSize+4),
            miniCardPremiumIcon.heightAnchor.constraint(equalToConstant: imageSize+4),
        ])
        
        switch side {
            
        case .bottomTrailing:
            NSLayoutConstraint.activate([
                miniCardPremiumIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
                miniCardPremiumIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
        case .centerTrailing:
            NSLayoutConstraint.activate([
                miniCardPremiumIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
                miniCardPremiumIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        case .topTrailing:
            NSLayoutConstraint.activate([
                miniCardPremiumIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                miniCardPremiumIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            ])
        }
        
    }
    
    /// return if user defaults not have access
    func getPremiumImageForAccordion(imageSize: CGFloat) -> UIImage? {
        let accessVal = UserDefaults.standard.object(forKey: "UserAccessObserverKey") as? Bool
        guard
            let accessVal = accessVal,
            accessVal == false
        else { return nil }
        //
        let color = DesignSystem.BadgeColor.transparent
        let configImage = UIImage(
            systemName: "lock.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize, weight: .medium)
        )?.withTintColor(color, renderingMode: .alwaysOriginal)
        return configImage
    }
    
    // MARK: - Notification action
    @objc private func notificationAllowPremiumContent(notification: Notification) {
        guard let bool = notification.object as? Bool else { return }
        self.miniCardPremiumIcon.isHidden = bool

    }
    
    func invalidateBadgeAndNotification() {
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name(PremiumBadgeManager.notificationKey),
            object: nil
        )
        self.miniCardPremiumIcon.isHidden = true
    }
    
    
}
