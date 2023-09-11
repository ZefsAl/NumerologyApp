//
//  AppDelegate.swift
//  Numerology
//
//  Created by Serj on 17.07.2023.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import RevenueCat
import UserNotifications

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
        
        // MARK: App Style
        UIBarButtonItem.appearance().tintColor = UIColor.white
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // MARK: Firebase
        FirebaseApp.configure()
        
        // MARK: Purchases - Config
        Purchases.logLevel = .info
        Purchases.configure(withAPIKey: "appl_efdMjsZBhJGejrMgmJjkdRRZklE")
        Purchases.shared.delegate = self
        
        // MARK: Push Notification - Config
        registerForPushNotifications()
        configureTokenFCM()
        // MARK: App Screen Config
        appScreenConfiguration()
        
        
        window?.makeKeyAndVisible()
        return true
    }
    
    private func appScreenConfiguration() {
        
        // Test
        let dataName = UserDefaults.standard.object(forKey: "nameKey")
        let dataSurname = UserDefaults.standard.object(forKey: "surnameKey")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
        
        // MARK: App Config
        if
            (dataName != nil && dataSurname != nil && dateOfBirth != nil) &&
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
    }
}


// MARK: PurchasesDelegate
extension AppDelegate: PurchasesDelegate {
    
    // Т.к этот метод purchases вызывается 2 раза (как я понял), идея была после 2 вызова -> Сообщить Observer'y и вызвать paywall т.к при определенных условиях paywall не открывается.
    
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        
        print("Check Access")
        if customerInfo.entitlements.all["Access"]?.isActive == true {
            print("User have premium!")
            UserDefaults.standard.setValue(true, forKey: "UserAccessObserverKey")
            UserDefaults.standard.synchronize()
            // unregister
            UIApplication.shared.unregisterForRemoteNotifications()
            print("isRegistered: \(UIApplication.shared.isRegisteredForRemoteNotifications)")
        } else {
            print("User not subscribe")
            UserDefaults.standard.setValue(false, forKey: "UserAccessObserverKey")
            UserDefaults.standard.synchronize()
        }
    }
    
}


// MARK: User Notification Center Delegate
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    // MARK: Register Push Notifications
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .providesAppNotificationSettings]) {
            (granted, error) in
            // 1. Check to see if permission is granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    
    // MARK: Configure Token FCM
    private func configureTokenFCM() {
        Messaging.messaging().delegate = self
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
    }
    // MARK: delagate FCM
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
    }
    
    // Delegate
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
          let token = tokenParts.joined()
          print("Device Token: \(token)")
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Push: \(error)")
    }

}
