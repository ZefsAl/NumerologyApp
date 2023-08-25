//
//  AppDelegate.swift
//  Numerology
//
//  Created by Serj on 17.07.2023.
//

import UIKit
import FirebaseCore
import RevenueCat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    
    let navmainTabBarVC: UINavigationController = {
        let nav = UINavigationController(rootViewController: MainTabBarController())
        return nav
    }()
    
    let navOnboardingVC: UINavigationController = {
        let nav = UINavigationController(rootViewController: OnboardingVC())
        return nav
    }()
    
    private let notificationCenter = NotificationCenter.default
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: FB
        FirebaseApp.configure()
        
        // MARK: App Style
        UIBarButtonItem.appearance().tintColor = UIColor.white
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // MARK: Purchases - Config
        Purchases.logLevel = .info
        Purchases.configure(withAPIKey: "appl_efdMjsZBhJGejrMgmJjkdRRZklE")
        Purchases.shared.delegate = self
        
        
//                UserDefaults.standard.removeObject(forKey: "nameKey")
//                UserDefaults.standard.removeObject(forKey: "surnameKey")
//                UserDefaults.standard.removeObject(forKey: "dateOfBirthKey")
//                UserDefaults.standard.synchronize()
        
        
        let dataName = UserDefaults.standard.object(forKey: "nameKey")
        let dataSurname = UserDefaults.standard.object(forKey: "surnameKey")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
        
        // MARK: TEST
//        let testVC: UINavigationController = {
//            let nav = UINavigationController(rootViewController: MainTabBarController())
//            return nav
//        }()
//        window?.rootViewController = testVC
        
        
//         MARK: Config
        if
            (dataName != nil || dataSurname != nil || dateOfBirth != nil) &&
                (dataName as? String != "" || dataSurname as? String != "")
        {
            print(dataName as Any)
            print(dataSurname as Any)
            print(dateOfBirth as Any)
            print("UserData - Have")
            window?.rootViewController = navmainTabBarVC
        } else {
            window?.rootViewController = navOnboardingVC
            print("UserData - Empty")
        }
        
        
        
        window?.makeKeyAndVisible()
        return true
    }
    
}

extension AppDelegate: PurchasesDelegate {
    
    // Т.к этот метод purchases вызывается 2 раза (как я понял), идея была после 2 вызова -> Сообщить Observer'y и вызвать paywall т.к при определенных условиях paywall не открывается.
    
    // К примеру после прохождения Onboarding
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        
        print("Check Access")
        if customerInfo.entitlements.all["Access"]?.isActive == true {
            print("User have premium!")
//            makeNotification()
//            UserDefaults.standard.userAvailable(available: true)
            
            UserDefaults.standard.setValue(true, forKey: "UserAccessObserverKey")
            UserDefaults.standard.synchronize()
        } else {
            print("User not subscribe")
//            UserDefaults.standard.userAvailable(available: false)
//            makeNotification()
            
            UserDefaults.standard.setValue(false, forKey: "UserAccessObserverKey")
            UserDefaults.standard.synchronize()
        }
    }
    
//    func makeNotification() {
//        let name = Notification.Name(rawValue: "CheckAccessNotification")
//        let notif = Notification(name: name)
//        notificationCenter.post(notif)
//    }
}
