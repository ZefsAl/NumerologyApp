//
//  Keys.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.08.2024.
//

import Foundation


struct UserDefaultsKeys {
    static let name = "nameKey";
    static let surname = "surnameKey";
    static let dateOfBirth = "dateOfBirthKey";
    static let userAccessObserverKey = "UserAccessObserverKey";
}

extension Notification.Name {
    static let hrscpTodayDataUpdated = Notification.Name("hrscpTodayDataUpdated")
    static let hrscpImagesDataUpdated = Notification.Name("horoscopeImagesDataUpdated")
    static let premiumBadgeNotificationKey = Notification.Name("PremiumBadgeNotificationKey")
    static let userDataDidChangeNotification = Notification.Name("UserDataDidChangeNotification")
}

