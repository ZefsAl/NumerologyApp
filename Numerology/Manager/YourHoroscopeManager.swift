//

//  Numerology
//
//  Created by Serj_M1Pro on 10.08.2024.
//

import Foundation
import UIKit

class YourHoroscopeManager {
    
    static let shared: YourHoroscopeManager = YourHoroscopeManager()
    
    var yourHrscpImages: [String:UIImage?]? {
        didSet {
            NotificationCenter.default.post(name: .hrscpImagesDataUpdated, object: nil)
            print("🔵 hrscpImagesDataUpdated - Notification")
        }
    }
    
    
    var todayHoroscope: HoroscopeDefaultModel? {
        didSet {
            NotificationCenter.default.post(name: .hrscpTodayDataUpdated, object: nil)
            print("🔵 hrscpDataUpdated - Notification")
        }
    }
    
    var tomorrowHoroscope: HoroscopeDefaultModel?
    var weekHoroscope: HoroscopeDefaultModel?
    var monthHoroscope: MonthCalendarModel?
    var year2024Horoscope: Year2024Model?
    
    func todayTomorrHrscpRequest() {
        
        // saved Values
        let savedDay = UserDefaults.standard.object(forKey: UserDefaultsKeys.currentDay) as? Int
        let todayHrscpNumber = UserDefaults.standard.object(forKey: UserDefaultsKeys.todayHrscpNumber) as? Int
        let tomorrowHrscpNumber = UserDefaults.standard.object(forKey: UserDefaultsKeys.tomorrowHrscpNumber) as? Int
        
        // current
        let currntDay = Date().get(.day)
        
        func old() {
            // Old horoscopes
            HoroscopeManager.shared.getTodayHrscp(requestType: .oldSpecific) { model in
                self.todayHoroscope = model
//                print("🔴🔴⚠️ old - todayHoroscope", model.number as Any)
            }
            HoroscopeManager.shared.getTomorrowHrscp(requestType: .oldSpecific) { model in
                self.tomorrowHoroscope = model
//                print("🔴🔴⚠️ old - tomorrowHoroscope", model.number as Any)
            }
        }
        
        func new() {
            // New horoscopes
            
            // обновляем savedDay
            UserDefaults.standard.setValue(currntDay, forKey: UserDefaultsKeys.currentDay)
            
            let serialQueue = DispatchQueue(label: "serialQueue")
            let group = DispatchGroup()
            
            // 1
            serialQueue.async{
                group.wait()
                group.enter()
                HoroscopeManager.shared.getTomorrowHrscp(requestType: .newRandom) { model in
                    self.tomorrowHoroscope = model
//                    print("🔴🔴✅ new - tomorrowHoroscope", model.number as Any)
                    //
                    if let tomorrowHrscpNumber = tomorrowHrscpNumber {
                        UserDefaults.standard.setValue(tomorrowHrscpNumber, forKey: UserDefaultsKeys.todayHrscpNumber)
                        // для todayHrscpNumber нужно сохранить старый tomorrowHrscpNumber
                    }
                    if let number = model.number {
                        UserDefaults.standard.setValue(number, forKey: UserDefaultsKeys.tomorrowHrscpNumber)
                    }
                }
                group.leave()
            }
            // 2
            serialQueue.async {
                group.enter()
                // request
                HoroscopeManager.shared.getTodayHrscp(requestType: .newRandom) { model in
                    self.todayHoroscope = model
//                    print("🔴🔴✅ new - todayHoroscope", model.number as Any)
                    
                    if todayHrscpNumber == nil,
                       let number = model.number {
                        UserDefaults.standard.setValue(number, forKey: UserDefaultsKeys.todayHrscpNumber)
                    }
                }
                group.leave()
            }
        }
        
        guard let savedDay = savedDay else {
            new()
            return
        }
        // Сhange of day
        currntDay == savedDay ? old() : new()
    }
    
    
    func requestData() {
        let sign = HoroscopeSign().findHoroscopeSign(byDate: UserDataKvoManager.shared.dateOfBirth)
        
        todayTomorrHrscpRequest()
        
        // Week
        DispatchQueue.main.async {
            HoroscopeManager.shared.getWeekHoroscope { model in
                self.weekHoroscope = model
            }
        }
        // Month new
        DispatchQueue.main.async {
            HoroscopeManager.shared.getMoneyCalendar(zodiacSign: sign) { model in
                self.monthHoroscope = model
                MoneyCalendarManager.shared.monthCalendarModel = model
            }
        }
        // Year 2024
        DispatchQueue.main.async {
            HoroscopeManager.shared.getYear2024Horoscope(zodiacSign: sign) { model in
                self.year2024Horoscope = model
            }
        }
        
        // Your Hrscp Images
        DispatchQueue.main.async {
            TechnicalManager.shared.getYourHrscpImages_v2 { dict in
                self.yourHrscpImages = dict
            }
        }
        
        
    }
}
