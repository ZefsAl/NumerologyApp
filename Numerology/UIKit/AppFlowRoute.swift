//
//  AppRouter.swift
//  Numerology
//
//  Created by Serj_M1Pro on 17.08.2024.
//

import UIKit
import SwiftUI

class AppFlowRoute {
    
    static let shared = AppFlowRoute()
    
    var window: UIWindow? = nil
    
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
            
            let settings: UIHostingController = UIHostingController(rootView: SettingsView())
            window.rootViewController = settings
            
            //window.rootViewController = CustomNavController(rootViewController: MainTabBarController())
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
