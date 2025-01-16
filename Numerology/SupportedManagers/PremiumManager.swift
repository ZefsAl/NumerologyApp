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
        //
        //        let paywall = SpecialOfferPaywall()
        let container = BottomSheetContainer(contentVC: SpecialOfferPaywall(type: .modal, isNavBarHidden: true))
        container.preferredContentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / (DeviceMenager.isSmallDevice ? 2.25 : 2.3)
        )
        //
        container.modalPresentationStyle = .overFullScreen
        vc.present(container, animated: false)
        
    }
}
