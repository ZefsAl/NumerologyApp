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
    
    let navOnboardingVC: UINavigationController = {
        let nav = UINavigationController(rootViewController: OnboardingVC_v2())
        return nav
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let winScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: winScene)
        UIBarButtonItem.appearance().tintColor = UIColor.white
        //        window = UIWindow(frame: UIScreen.main.bounds) // Appdelegate
        
        // Data
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            // желательно обновлять status d UserDefaults
            print("🟢 request CustomerInfo Access ==", customerInfo?.entitlements["Access"]?.isActive as Any)
        }
        print("🟢 User Access ==", UserDefaults.standard.object(forKey: "UserAccessObserverKey"))
        let dataName = UserDefaults.standard.object(forKey: "nameKey")
        let dataSurname = UserDefaults.standard.object(forKey: "surnameKey")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
        
//        // MARK: App Config
//        if
//            (dataName != nil && dataSurname != nil && dateOfBirth != nil) &&
//                (dataName as? String != "" || dataSurname as? String != "")
//        {
//            print(dataName as Any)
//            print(dataSurname as Any)
//            print(dateOfBirth as Any)
//            print("UserData - Have")
//            self.window?.rootViewController = MainTabBarController()
//        } else {
//            self.window?.rootViewController = navOnboardingVC
//            
//            print("UserData - Empty")
//        }
        
        // test
        let nav = CustomNavController(rootViewController: NumerologyVC_2024())
        self.window?.rootViewController = nav
        //
        
        self.window?.makeKeyAndVisible()
        
        print("🔴scene🔴")
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


//    private func appScreenConfiguration() {
//        // test
////        window?.rootViewController = UINavigationController(rootViewController: LocationSearchVC())
////        window?.rootViewController = CustomNavController(rootViewController: RegionOfbirthVC())
////        UserDefaults.standard.removeObject(forKey: "nameKey")
////        UserDefaults.standard.removeObject(forKey: "surnameKey")
////        UserDefaults.standard.removeObject(forKey: "dateOfBirthKey")
//
////          Data
//        let dataName = UserDefaults.standard.object(forKey: "nameKey")
//        let dataSurname = UserDefaults.standard.object(forKey: "surnameKey")
//        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
//
//        // MARK: App Config
//        if
//            (dataName != nil && dataSurname != nil && dateOfBirth != nil) &&
//                (dataName as? String != "" || dataSurname as? String != "")
//        {
//            print(dataName as Any)
//            print(dataSurname as Any)
//            print(dateOfBirth as Any)
//            print("UserData - Have")
//            window?.rootViewController = MainTabBarController()
//        } else {
//            window?.rootViewController = navOnboardingVC
//            print("UserData - Empty")
//        }
//        //
//    }
