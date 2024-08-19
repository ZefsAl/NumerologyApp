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
    
    // MARK: - Gradient
    private let gradientlayer = CAGradientLayer()
    
    // MARK: - State
    private var isHavePremium: Bool? 
    
    // MARK: - Timer
    private var countDownTimer = Timer()
    private let keyUD = "CountDownSO"
    private let defaultVal: Double = 86400
    private lazy var counter: Double = {
        let fetchedVal = UserDefaults.standard.object(forKey: keyUD) as? Double
        
        guard let fetchedVal = fetchedVal else { return defaultVal}
        if fetchedVal <= 0 {
            self.saveCountDownDefault()
            return defaultVal
        } else {
            return fetchedVal
        }
    }() {
        didSet {
            if counter <= 0 {
                saveCountDownDefault()
                counter = defaultVal
            }
        }
    }
    // User Defaults
    private func saveCountDownDefault() {
        UserDefaults.standard.setValue(defaultVal, forKey: keyUD)
        UserDefaults.standard.synchronize()
    }
    // Convert to Calendar Components
    private func setTimeString(seconds: Double) {
        // ms -> make date seconds
        var dateComponents = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: Date())
        dateComponents.second = Int(seconds)
        guard let dateVal = Calendar.autoupdatingCurrent.date(from: dateComponents) else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        countDownLabel.text = dateFormatter.string(from: dateVal)
    }
    
    // MARK: - count Down Label
    private let countDownLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // MARK: - Icon
    private let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.image = UIImage(named: "GiftBox")
        iv.isHidden = true
        return iv
    }()
    // MARK: - icon constraint
    private lazy var iconHeight = icon.heightAnchor.constraint(equalToConstant: 22)
    private lazy var iconWidth = icon.widthAnchor.constraint(equalToConstant: 22)
    
    // MARK: - layout Subviews
    override func layoutSubviews() {
        self.setGradientBackground()
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.shadowRadius = self.bounds.height/2
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
        self.setPulseAnimation()
        self.validateConfigState()
        // target
        self.addTarget(Any?.self, action: #selector(specialOfferAct), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - button Config State
    private func validateConfigState() {
        // При Onboarding приложение уже проверило и прислало скорее всего Nil purchase delegate
        
        
//        if PremiumManager.isUserPremium() {
//            
//        } else {
//            self.buttonConfigure(isHavePremium: PremiumManager.isUserPremium())
//        }
        self.buttonConfigure(isHavePremium: PremiumManager.isUserPremium())
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.notificationConfigState(notification:)),
            name: .premiumBadgeNotificationKey,
            object: nil
        )
    
    }
    
    // MARK: - setup UI
    private func setupUI() {
        // Shadow
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = DesignSystem.Horoscope.shadowColor.cgColor
        //
        let contentStack = UIStackView(arrangedSubviews: [countDownLabel, icon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 0
        contentStack.isUserInteractionEnabled = false
        
        // add
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            countDownLabel.widthAnchor.constraint(equalToConstant: 60),
            self.heightAnchor.constraint(equalToConstant: 36),
            //
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        ])
    }
    
    // MARK: - Gradient
    private func setGradientBackground() {
        let color0 = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        let color25 = #colorLiteral(red: 0.6431372549, green: 0.4980392157, blue: 0.9764705882, alpha: 1)
        let color50 = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        let color75 = #colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7254901961, alpha: 1)
        let color100 = #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1)
        let colors = [color100,color75,color50,color25,color0].compactMap { $0.cgColor }
        
        gradientlayer.name = "GradientLayerKey"
        gradientlayer.frame = self.bounds
        gradientlayer.colors = colors
        gradientlayer.locations = [0,0.25,0.5,0.75,1]
        gradientlayer.startPoint = CGPoint(x: -0.2, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 1.2, y: 0.5)
        gradientlayer.cornerRadius = 36/2
        self.layer.insertSublayer(gradientlayer, at: 0)
    }
    // MARK: - Animation
    private func setPulseAnimation() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.toValue = 0.95
        pulseAnimation.fromValue = 0.79
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        self.layer.add(pulseAnimation, forKey: "pulse")
    }
    
    // MARK: - Actions
    @objc private func updateCounter() {
        if counter > 0 {
            counter -= 1
            self.setTimeString(seconds: counter)
            // Save
            UserDefaults.standard.setValue(counter, forKey: keyUD)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: - Button Action
    @objc private func specialOfferAct(_ sender: SpecialOfferButton) {
        guard let isHavePremium = sender.isHavePremium else { return }
        
        if isHavePremium {
//            print("🔵⭐️ - Show Day Tip")
            self.specialOfferButtonDelegate?.todayTipAction()
        } else {
            let navVC = UINavigationController(rootViewController: SpecialOfferPaywall())
            navVC.modalPresentationStyle = .overFullScreen
            self.remoteOpenDelegate?.openFrom?.present(navVC, animated: true)
        }   
    }
    
    // MARK: - target - notification
    @objc private func notificationConfigState(notification: Notification) {
        guard let bool = notification.object as? Bool else { return }
        self.buttonConfigure(isHavePremium: bool)
    }
    
    // MARK: - Config
    private func buttonConfigure(isHavePremium: Bool) {
        self.isHavePremium = isHavePremium
        
        if isHavePremium {
            //
            self.countDownTimer.invalidate()
            // Today
            self.countDownLabel.font = UIFont(weight: .bold, size: 15)
            self.countDownLabel.textAlignment = .center
            self.countDownLabel.textColor = .white
            self.countDownLabel.text = "Today"
        } else {
            // SpecialOffer
            self.countDownLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            self.countDownLabel.textAlignment = .left
            self.countDownLabel.textColor = .white
            self.countDownLabel.text = "24:00:00"
            // timer
//            self.countDownTimer.invalidate()
            self.countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
        // Update
        self.gradientlayer.frame = self.bounds
        // icon
        self.icon.isHidden = isHavePremium
        self.iconHeight.isActive = isHavePremium ? false : true
        self.iconWidth.isActive = isHavePremium ? false : true
    }
    
}
