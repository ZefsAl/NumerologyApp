//
//  AccordionButton.swift
//  Numerology
//
//  Created by Serj on 27.11.2023.
//

import UIKit

class PremiumAccordionButton: UIButton {
    
    let premiumBadgeManager = PremiumManager()
    private var isPremium: Bool? = nil
    
    var didTapState: Bool = true {
        didSet {
            setIconChange(state: didTapState, isPremium: isPremium)
        }
    }
    
    // MARK: - isTouchInside
    override var isTouchInside: Bool {
        didTapState = didTapState ? false : true
        return true
    }
    // MARK: - main Title
    let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.title_h3
        l.textAlignment = .left
        return l
    }()
    // MARK: - Icon
    private let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        return iv
    }()
    
    // MARK: - change Icon
    func setIconChange(state: Bool, isPremium: Bool? = nil) {
        guard let isPremium = isPremium else { return }
        self.isPremium = isPremium
        
        if isPremium {
            let premiumImage = PremiumManager().getPremiumImageForAccordion(imageSize: 20)
            if let premiumImage = premiumImage {
                icon.image = premiumImage
            } else {
                setPremiumToggle(state: state)
            }
        } else {
            setPremiumToggle(state: state)
        }
    }
    
    private func setPremiumToggle(state: Bool) {
        let configImage = UIImage(
            systemName: state ? "chevron.down.circle" : "chevron.up.circle",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 19,
                weight: .regular
            )
        )
        icon.image = configImage
    }
    
    convenience init(isPremium: Bool?, didTapState: Bool = true) {
        self.init()
        self.isPremium = isPremium
        self.didTapState = didTapState
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        // Добавтьб в инит isLocked и var для разного конфига
        super.init(frame: frame)
        setupUI()
        
        self.premiumBadgeManager.setPremiumBadgeObserver(observer: self, action: #selector(self.notificationAllowPremiumContent(notification:)))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Notification action
    @objc private func notificationAllowPremiumContent(notification: Notification) {
        guard let premiumState = notification.object as? Bool else { return }
        self.setIconChange(state: self.didTapState, isPremium: premiumState)
    }
    // MARK: - configure
    func setAccordionTitle(_ title: String) {
        self.mainTitle.text = title
    }
    // MARK: - setupUI
    private func setupUI() {
        //
        let contentStack = UIStackView(arrangedSubviews: [mainTitle,UIView(),icon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 4
        //
        contentStack.isUserInteractionEnabled = false
        //
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
