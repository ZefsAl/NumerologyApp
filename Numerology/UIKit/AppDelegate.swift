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
import FirebaseAnalytics
import FBSDKCoreKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // cust delay
        Thread.sleep(forTimeInterval: 2.0)
        
        // MARK: Firebase
        FirebaseApp.configure()
        // Firebase Analytics Testing - Debug View
        let settings = FirebaseConfiguration.shared
        settings.setLoggerLevel(.debug)
        
        
        // MARK: Purchases - Config
        Purchases.logLevel = .info
        Purchases.configure(withAPIKey: "appl_efdMjsZBhJGejrMgmJjkdRRZklE")
        Purchases.shared.delegate = self
        
        // Facebook Analytics
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        ApplicationDelegate.shared.initializeSDK()
        
        // ATT
        AnalyticsManager.shared.requestATTForFacebook()
        
        // Push Notification - Config
        self.registerForPushNotifications()
        self.configureTokenFCM()
        
        // preload Data
        self.validateAndPreload()
        
        #warning("add UserDefaults")
        // TODO: - не учитывается отключение .premiumBadgeNotificationKey, object: false)
        if !UserDefaults.standard.bool(forKey: "SetupDailyPush_Key") {
            LocalPushNotofication().setupDailyPush()
        }
        
        
        
        
        // check - test
        //        let dataName = UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as? String
        //        let dataSurname = UserDefaults.standard.object(forKey: UserDefaultsKeys.surname) as? String
        //        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        //        myPrint("UD - ✅⚠️",dataName as Any)
        //        myPrint("UD - ✅⚠️",dataSurname as Any)
        //        myPrint("UD - ✅⚠️",dateOfBirth as Any)
        
        
        return true
    }
    
    private func validateAndPreload() {
        // После заполнения данных
        if UserDataKvoManager.shared.isAllUserDataAvailable() {
            myPrint("✅ preload Data")
            preloadData() // if have
        } else {
            myPrint("⚠️🟢 NotificationCenter - ready - preload Data")
            UserDataKvoManager.shared.setUserDataDidChangeNotification(observer: self, action: #selector(preloadData))
        }
    }
    
    @objc private func preloadData() {
        DispatchQueue.main.async {
            myPrint("1-✅ request YourHoroscopeManager")
            YourHoroscopeManager.shared.requestData()
        }
        DispatchQueue.main.async {
            myPrint("2-✅ request NumerologyImagesManager")
            NumerologyImagesManager.shared.requestData()
        }
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}



// MARK: Purchases Delegate
extension AppDelegate: PurchasesDelegate {
    
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        myPrint("🟠 Purchases delegate")
        
        let access = customerInfo.entitlements.all["Access"]
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if access?.isActive == true {
                myPrint("✅ User have premium!")
                UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.userAccessObserverKey)
                UserDefaults.standard.synchronize()
                
                // unregister // cust logic
                // #warning("вернуть cust logic !!!!!! ")
                UIApplication.shared.unregisterForRemoteNotifications()
                
                myPrint("⚠️ was Unregister - RemoteNotifications: \(UIApplication.shared.isRegisteredForRemoteNotifications)")
                NotificationCenter.default.post(name: .premiumBadgeNotificationKey, object: true)
            } else {
                myPrint("‼️⚠️User not subscribe")
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
                myPrint("⚠️ Error fetching FCM registration token: \(error)")
            } else if let token = token {
                myPrint("⚠️ FCM registration token: \(token)")
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
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        myPrint("🌕 push token",token)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        myPrint("Push: \(error)")
    }
    
}

func myPrint(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n"
) {
    print("ℹ️",items, separator: separator, terminator: terminator)
}
