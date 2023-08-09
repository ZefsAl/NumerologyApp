//
//  AppDelegate.swift
//  Numerology
//
//  Created by Serj on 17.07.2023.
//

import UIKit
import FirebaseCore

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
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: FB
        FirebaseApp.configure()
        
        // MARK: Style
        UIBarButtonItem.appearance().tintColor = UIColor.white
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        //        UserDefaults.standard.removeObject(forKey: "nameKey")
        //        UserDefaults.standard.removeObject(forKey: "surnameKey")
        //        UserDefaults.standard.removeObject(forKey: "dateOfBirthKey")
        //        UserDefaults.standard.synchronize()
        
        
        let dataName = UserDefaults.standard.object(forKey: "nameKey")
        let dataSurname = UserDefaults.standard.object(forKey: "surnameKey")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
        
        // MARK: TEST
        let testVC: UINavigationController = {
            let nav = UINavigationController(rootViewController: MainTabBarController())
            return nav 
        }()
        window?.rootViewController = testVC
        
        
        // MARK: Config
//        if
//            (dataName != nil || dataSurname != nil || dateOfBirth != nil) &&
//                (dataName as? String != "" || dataSurname as? String != "")
//
//        {
//            print(dataName)
//            print(dataSurname)
//            print(dateOfBirth)
//            print("UserData - Have")
//            window?.rootViewController = navmainTabBarVC
//        } else {
//            window?.rootViewController = navOnboardingVC
//            print("UserData - Empty")
//        }
//
        
        window?.makeKeyAndVisible()
        return true
    }
    
}

