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
        
        FirebaseApp.configure()
        
        
        UIBarButtonItem.appearance().tintColor = UIColor.white
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // TEst request
//        FirebaseManager.shared.getBoardOfDay { model in
////            print(model.short)
////            
////            print(model.short.count)
//        }
        
//        UserDefaults.standard.removeObject(forKey: "nameKey")
//        UserDefaults.standard.removeObject(forKey: "surnameKey")
//        UserDefaults.standard.removeObject(forKey: "dateOfBirthKey")
//        UserDefaults.standard.synchronize()
        

        let dataName = UserDefaults.standard.object(forKey: "nameKey")
        let dataSurname = UserDefaults.standard.object(forKey: "surnameKey")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
        
        
//        let editProfileVC: UINavigationController = {
//           let nav = UINavigationController(rootViewController: EditProfileVC())
//            return nav
//        }()
//        window?.rootViewController = editProfileVC
        // Config
        if
            (dataName != nil || dataSurname != nil || dateOfBirth != nil) &&
                (dataName as? String != "" || dataSurname as? String != "")

        {
            print(dataName)
            print(dataSurname)
            print(dateOfBirth)
            print("UserData - Have")
//            window?.rootViewController = mainTabBarController
            window?.rootViewController = navmainTabBarVC
        } else {
            window?.rootViewController = navOnboardingVC
//            window?.rootViewController = MainTabBarController()
            print("UserData - Empty")
        }
        
        
        
        
//        NotificationCenter.default.addObserver(self, selector:#selector(done(notification:)),name: UserEnterDataVC.notificationDone,object: nil)
        
    
        window?.makeKeyAndVisible()
        
        return true
    }
    
//    @objc func done(notification: Notification) {

        
//        self.window?.rootViewController = mainTabBarController
        
//        self.window?.rootViewController?.show(mainTabBarController, sender: userEnterDataVC) + // Без анимации
        
        
        // Скорее всего есть утечка памяти
//        let navMainTabBarController = UINavigationController(rootViewController: MainTabBarController())
//        self.window?.rootViewController?.present(navTransactionVC, animated: true, completion: nil)
        
//        self.window?.rootViewController?.present(MainTabBarController(), animated: true, completion: {
//            self.window?.rootViewController = MainTabBarController()
//        })
        
        
        
//        let presentedViewController = userEnterDataVC.present
        
//        let presentedViewController = self.window?.rootViewController?.presentedViewController
////
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            presentedViewController?.present(MainTabBarController(), animated: true) {
//
//                self.window?.rootViewController = MainTabBarController()
//                self.window?.makeKeyAndVisible()
//
//            }
//        }
//
//        let rootVC = UIApplication.shared.windows.first?.rootViewController = vc
//        rootVC.
//
//        self.window?.rootViewController?.presentedViewController?.transition(from: userEnterDataVC, to: mainTabBarController, duration: 0.0, options: .allowAnimatedContent, animations: {
//
//        }, completion: { _ in
//
//        })
//
//
//        print("Done")
//    }


}

