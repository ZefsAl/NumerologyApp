//
//  Keys.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.08.2024.
//

import Foundation


struct IAP_IDs {
    // Subscription
    static let month = "Month_9.99"
    static let year = "Year_29.99"
    static let weekly = "Weekly.ID"
    static let lifetime = "Lifetime.Purchase"
    // Consumable
    static let stars5 = "5_Stars"
    static let stars15 = "15_Stars"
    static let stars25 = "25_Stars"
}

struct UserDefaultsKeys {
    static let name = "nameKey";
    static let surname = "surnameKey";
    static let dateOfBirth = "dateOfBirthKey";
    static let userAccessObserverKey = "UserAccessObserverKey";
    //
    static let todayHrscpNumber = "previousDayHrscpNumberKey" // previousDayHrscpNumber == today
    static let tomorrowHrscpNumber = "currentDayHrscpNumberKey" // currentDayHrscpNumber == tomorrow
    static let currentDay = "currentDayKey"
    static let specialOfferCurrentDay = "specialOfferCurrentDay"
    // Music State
    static let bgMusicState = "bgMusicStateKey"
    static let selectedMelody = "selectedMelodyKey"
}

extension Notification.Name {
    // Premium
    static let premiumBadgeNotificationKey = Notification.Name("PremiumBadgeNotificationKey");
    // Horoscope
    static let hrscpTodayDataUpdated = Notification.Name("hrscpTodayDataUpdated");
    static let hrscpImagesDataUpdated = Notification.Name("horoscopeImagesDataUpdated");
    static let userDataDidChangeNotification = Notification.Name("UserDataDidChangeNotification");
    // Numerology
    static let numerologyImagesDataUpdated = Notification.Name("numerologyImagesDataUpdated");
    static let angelNumbersImagesDataUpdated = Notification.Name("angelNumbersImagesDataUpdated");
    
}

struct TechnicalTableKeys {
    // Trends
    static let yourHrscpImages = "YourHrscpImages";
    static let numerologyImages = "NumerologyImages";
    static let angelNumbersImages = "AngelNumbersImages";
}

enum NumerologyImagesKeys: String {
    case psychomatrix = "psychomatrix";
    case soul = "soul";
    case destiny = "destiny";
    case name = "name";
    case power = "power";
    case compatibility = "compatibility";
    case money = "money";
    case day = "day";
    case month = "month";
    case year = "year";
    case lifeStages = "lifeStages";
    case angelNumbers = "angelNumbers";
    case aboutNumerology = "aboutNumerology";   
}

enum AngelNumbersImagesKeys: String {
    case _111 = "psychomatrix";
    case soul = "soul";
    case destiny = "destiny";
    case name = "name";
    case power = "power";
    case compatibility = "compatibility";
    case money = "money";
    case day = "day";
    case month = "month";
    case year = "year";
    case lifeStages = "lifeStages";
    case angelNumbers = "angelNumbers";
    case aboutNumerology = "aboutNumerology";
}

enum AppSupportedLinks: String {
    case terms = "https://numerology-terms.web.app/";
    case privacy = "https://numerology-privacy.web.app/";
    case site = "https://asteria-numerology.tilda.ws/";
}


