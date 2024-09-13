//

//  Numerology
//
//  Created by Serj_M1Pro on 01.06.2024.
//

import UIKit

final class PremiumManager {
    
    static let shared = PremiumManager()
    
    public static func isUserPremium() -> Bool {
        let accessVal = UserDefaults.standard.object(forKey: UserDefaultsKeys.userAccessObserverKey) as? Bool
        guard
            let accessVal = accessVal // nil
        else { return false }
        return accessVal
    }
    
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
            name: .premiumBadgeNotificationKey,
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
        let color = DesignSystem.BadgeColor.white
        let configImage = UIImage(
            systemName: "chevron.down.circle", // cust-fix - old -> lock.fill
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
        NotificationCenter.default.removeObserver(self, name: .premiumBadgeNotificationKey, object: nil)
        self.miniCardPremiumIcon.isHidden = true
    }
    
    
    
    // MARK: - show Special Offer
    public static func showSpecialOffer(from vc: UIViewController?) {
        guard let vc = vc else { return }
        
        // v2
        let paywall = BottomSheetContainer(contentVC: SpecialOfferPaywall())
        paywall.preferredContentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / (DeviceMenager.isSmallDevice ? 2.25 : 2.3)
        )
        
        //
        paywall.modalPresentationStyle = .overFullScreen
        vc.present(paywall, animated: false)
        
    }
}
