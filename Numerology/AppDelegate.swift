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
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: Firebase
        FirebaseApp.configure()
        
        // MARK: Purchases - Config
        Purchases.logLevel = .info
        Purchases.configure(withAPIKey: "appl_efdMjsZBhJGejrMgmJjkdRRZklE")
        Purchases.shared.delegate = self
        
        // MARK: Push Notification - Config
        self.registerForPushNotifications()
        self.configureTokenFCM()
        
        // preload Data
        
        
        //
        
        
        let dataName = UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as? String
        let dataSurname = UserDefaults.standard.object(forKey: UserDefaultsKeys.surname) as? String
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        print("UD - ✅⚠️",dataName as Any)
        print("UD - ✅⚠️",dataSurname as Any)
        print("UD - ✅⚠️",dateOfBirth as Any)
        
        
//        print("UD - ✅⚠️",UserDataKvoManager.shared.name)
//        print("UD - ✅⚠️",UserDataKvoManager.shared.surname)
//        print("UD - ✅⚠️",UserDataKvoManager.shared.dateOfBirth)
        
        
        self.validateAndPreload()
        
        
       
        
        return true
    }
    
    
    
    
    
    func validateAndPreload() {
        
        
//        if UserDataKvoManager.shared.isAllUserDataAvailable() {
//            print("✅ preload Data")
//            preloadData() // if have
//        }
//        else {
//            print("⚠️ NotificationCenter - ready - preload Data")
//            // if not
//            UserDataKvoManager.shared.setUserDataDidChangeNotification(observer: self, action: #selector(preloadData))
//        }
        
//        if UserDataKvoManager.shared.name == nil || UserDataKvoManager.shared.name == "" &&
//        UserDataKvoManager.shared.surname == nil || UserDataKvoManager.shared.surname == "" &&
//        UserDataKvoManager.shared.dateOfBirth == nil {
//            print("⚠️ NotificationCenter - ready - preload Data")
//            UserDataKvoManager.shared.setUserDataDidChangeNotification(observer: self, action: #selector(preloadData))
//        } else {
//            print("✅ preload Data")
//            preloadData() // if have
//        }
        
        if UserDataKvoManager.shared.isAllUserDataAvailable() {
            print("✅ preload Data")
            preloadData() // if have
        } else {
            print("⚠️🟢 NotificationCenter - ready - preload Data")
            UserDataKvoManager.shared.setUserDataDidChangeNotification(observer: self, action: #selector(preloadData))
        }
        
        
//        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: nil) { notification in
//            guard let defaults = notification.object as? UserDefaults else { return }
//               
//               let excludedKeys: [String] = [
//                   "com.firebase.instanceid.user_defaults.locale",
//                   "AppleMetricUnits",
//                   "AppleLanguagesDidMigrate",
//                   "AppleKeyboardsExpanded",
//                   "com.revenuecat"
//                   // добавьте другие ключи, которые нужно исключить
//               ]
//               
//               let updatedDefaults = defaults.dictionaryRepresentation()
//               
//               // Проверяем, есть ли среди изменившихся ключей те, что нужно исключить
//               let hasExcludedKey = updatedDefaults.keys.contains { key in
//                   excludedKeys.contains(key)
//               }
//               
//               // Если есть исключенные ключи, выходим из функции
//               if hasExcludedKey {
//                   return
//               }
//            
//            
//            //            print("⚠️⚠️⚠️UserDefaults изменились: \(notification.description)")
////            UserDefaults.standard.dictionaryRepresentation()
//            
//                // Здесь можно проверить текущее состояние UserDefaults и сравнить его с предыдущим состоянием.
//                print("⚠️⚠️⚠️UserDefaults changed: \(defaults.dictionaryRepresentation() ?? [:])")
//        }
        

    }
    @objc private func preloadData() {
        
        guard UserDataKvoManager.shared.isAllUserDataAvailable() else { return }
        DispatchQueue.main.async {
            print("1⚠️ request MoneyCalendarManager")
            MoneyCalendarManager.shared.preloadData()
        }
        DispatchQueue.main.async {
            print("2⚠️ request YourHoroscopeManager")
            YourHoroscopeManager.shared.requestData()
        }
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}



// MARK: Purchases Delegate
extension AppDelegate: PurchasesDelegate {
    
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        print("🟠 Purchases delegate")
        DispatchQueue.main.async {
            if customerInfo.entitlements.all["Access"]?.isActive == true {
                print("✅ User have premium! == true")
                UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.userAccessObserverKey)
                UserDefaults.standard.synchronize()
                // unregister // cust logic
                UIApplication.shared.unregisterForRemoteNotifications()
                print("⚠️ was Unregister - RemoteNotifications: \(UIApplication.shared.isRegisteredForRemoteNotifications)")
                NotificationCenter.default.post(name: .premiumBadgeNotificationKey, object: true)
            } else {
                print("‼️⚠️User not subscribe == false")
                UserDefaults.standard.setValue(false, forKey: UserDefaultsKeys.userAccessObserverKey)
                UserDefaults.standard.synchronize()
                //
                NotificationCenter.default.post(name: .premiumBadgeNotificationKey, object: false)
            }
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
                print("⚠️ Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("⚠️ FCM registration token: \(token)")
            }
        }
    }
    
    // MARK: delagate FCM
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
    
    
    // Delegate Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        //          let token = tokenParts.joined
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Push: \(error)")
    }
}


