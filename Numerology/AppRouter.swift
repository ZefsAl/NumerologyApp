//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 17.08.2024.
//

import UIKit

class AppRouter {
    
    static let shared = AppRouter()
    
    var window: UIWindow? = nil
    
//    private let onboardingNav: UINavigationController = UINavigationController(rootViewController: OnboardingVC_v2())
//    private let appNav: CustomNavController = CustomNavController(rootViewController: MainTabBarController())
    
    
    enum FlowType {
        case onboarding
        case app
    }
    
    func setWindow(window: UIWindow) {
        self.window = window
    }
    
    func setAppFlow(_ type: FlowType, animated: Bool) {
        guard let window = self.window else { return }
        self.withTransition(animate: animated, window: window)
        
        switch type {
        case .onboarding:
            window.rootViewController = UINavigationController(rootViewController: OnboardingVC_v2())
        case .app:
            window.rootViewController = CustomNavController(rootViewController: MainTabBarController())
        }
        window.makeKeyAndVisible()
    }
    
    private func withTransition(animate: Bool, window: UIWindow) {
        guard animate else { return }
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        transition.fillMode = .both
        window.layer.add(transition, forKey: kCATransition)
    }
    
}
