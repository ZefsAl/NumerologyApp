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
        
        // Original
        self.withTransition(animate: animated, window: window)
        switch type {
        case .onboarding:
            window.rootViewController = UINavigationController(rootViewController: OnboardingVC_v2())
        case .app:
            window.rootViewController = CustomNavController(rootViewController: MainTabBarController())
        }
        window.makeKeyAndVisible()

        // MARK: - ⚠️ TEST
//        let host: UIHostingController = UIHostingController(rootView: ChatView(expertModel: ExpertViewModel().expertsList[0], closeAction: {}))
//        let host: UIHostingController = UIHostingController(rootView: HuggingTF3_TESTPREVIEW())

        
//        let host: UIHostingController = UIHostingController(rootView:  ChatRoom(
//            expertModel: ExpertViewModel().expertsList[0],
//            sm: StarsManager(),
//            cpm: ChatPaywallManager(),
//            closeAction: {}
//        ))
//        window.rootViewController = UIHostingController(rootView:  MarkdownTEST())
//        window.makeKeyAndVisible()

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
