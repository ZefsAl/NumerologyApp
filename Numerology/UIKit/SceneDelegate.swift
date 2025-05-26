//
//  SceneDelegate.swift
//  Numerology
//
//  Created by Serj on 17.07.2023.
//

import UIKit
import RevenueCat
import SwiftUI
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @ObservedObject var musicManager = MusicManager.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Style
        UIBarButtonItem.appearance().tintColor = UIColor.white
        
        // MARK: App Config
        guard let winScene = (scene as? UIWindowScene) else { return }
        AppFlowRoute.shared.setWindow(window: UIWindow(windowScene: winScene))
        AppFlowRoute.shared.setAppFlow(
            UserDataKvoManager.shared.isAllUserDataAvailable() ? .app : .onboarding,
            animated: false
        )
        
        // Test Check
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            // желательно обновлять status d UserDefaults
            print("⚠️🟢 request CustomerInfo Access ==", customerInfo?.entitlements["Access"]?.isActive as? Bool as Any)
        }
        print("🟠 UD - Access ==", UserDefaults.standard.object(forKey: "UserAccessObserverKey") as? Bool)
        print("🔄 scene")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("🔄sceneDidDisconnect")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("🔄 sceneDidBecomeActive")
        UIApplication.shared.applicationIconBadgeNumber = 0
        musicManager.playSound()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("🔄 sceneWillResignActive")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("🔄 sceneWillEnterForeground")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        musicManager.stopSound()
        print("🔄 sceneDidEnterBackground")
    }
    
    // Facebook
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
        
        // В самом начале, до любых вызовов SDK:
        Settings.shared.loggingBehaviors = []
        // или по-отдельности отключить:
        Settings.shared.disableLoggingBehavior(.appEvents)
        Settings.shared.disableLoggingBehavior(.performanceCharacteristics)
        Settings.shared.disableLoggingBehavior(.networkRequests)
    }
    
}
