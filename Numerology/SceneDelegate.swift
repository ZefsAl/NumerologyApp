//
//  SceneDelegate.swift
//  Numerology
//
//  Created by Serj on 17.07.2023.
//

import UIKit
import RevenueCat

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let winScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: winScene)
        UIBarButtonItem.appearance().tintColor = UIColor.white
        
        // Data
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            // желательно обновлять status d UserDefaults
            print("⚠️🟢 request CustomerInfo Access ==", customerInfo?.entitlements["Access"]?.isActive as? Bool as Any)
        }
        print("🟠 UD - Access ==", UserDefaults.standard.object(forKey: "UserAccessObserverKey") as? Bool)
        
//        // MARK: App Config
        setAppFlow()
        
        // test
//        let nav = CustomNavController(rootViewController: TrendsArticlesVC())
//        self.window?.rootViewController = nav
//        self.window?.makeKeyAndVisible()
        //
        
        
        
        print("🔴scene🔴")
    }
    
    private func setAppFlow() {
        let dataName = UserDefaults.standard.object(forKey: "nameKey")
        let dataSurname = UserDefaults.standard.object(forKey: "surnameKey")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
        
        if
            (dataName != nil && dataSurname != nil && dateOfBirth != nil) &&
                (dataName as? String != "" || dataSurname as? String != "")
        {
            print(dataName as Any)
            print(dataSurname as Any)
            print(dateOfBirth as Any)
            self.window?.rootViewController = MainTabBarController()
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: OnboardingVC_v2())
        }
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("🔴sceneDidDisconnect🔴")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("🔴sceneDidBecomeActive🔴")
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("🔴sceneWillResignActive🔴")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("🔴sceneWillEnterForeground🔴")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("🔴sceneDidEnterBackground🔴")
    }
    
}
