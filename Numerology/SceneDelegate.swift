//
//  SceneDelegate.swift
//  Numerology
//
//  Created by Serj on 17.07.2023.
//

import UIKit
import RevenueCat

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
//    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Style
        UIBarButtonItem.appearance().tintColor = UIColor.white
        
        // MARK: App Config
        guard let winScene = (scene as? UIWindowScene) else { return }
        AppRouter.shared.setWindow(window: UIWindow(windowScene: winScene))
        AppRouter.shared.setAppFlow(
            UserDataKvoManager.shared.isAllUserDataAvailable() ? .app : .onboarding,
            animated: false
        )
        
        // Test Check
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            // желательно обновлять status d UserDefaults
            print("⚠️🟢 request CustomerInfo Access ==", customerInfo?.entitlements["Access"]?.isActive as? Bool as Any)
        }
        print("🟠 UD - Access ==", UserDefaults.standard.object(forKey: "UserAccessObserverKey") as? Bool)
        // test
//        let vc = UIViewController()
//        vc.setBackground(named: "bgHoroscope2")
//        vc.view.backgroundColor = .systemBlue
//        let nav = UINavigationController(rootViewController: vc)
////        let nav = CustomNavController(rootViewController: HoroscopeVC())
//        AppRouter.shared.window?.rootViewController = nav
//        AppRouter.shared.window?.makeKeyAndVisible()
        print("🔄 scene")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("🔄sceneDidDisconnect")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("🔄 sceneDidBecomeActive")
        UIApplication.shared.applicationIconBadgeNumber = 0
        MusicManager.shared.playSound()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("🔄 sceneWillResignActive")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("🔄 sceneWillEnterForeground")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        MusicManager.shared.stopSound()
        print("🔄 sceneDidEnterBackground")
    }
    
}
