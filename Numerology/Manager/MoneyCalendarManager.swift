//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 14.07.2024.
//

import Foundation



final class MoneyCalendarManager {
    
    static let shared: MoneyCalendarManager = MoneyCalendarManager()
    
    var monthCalendarModel: MonthCalendarModel? = nil
    lazy var positive = [Int]()
    lazy var negative = [Int]()
    
    
    init() {
        preloadData()
    }
    
    func preloadData() {
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)
        
        print("🔴 find Horoscope Sign = ",sign)
        DispatchQueue.main.async {
            HoroscopeManager.shared.getMoneyCalendar(zodiacSign: sign) { model in
                    
                print("🔴 get Money Calendar = ",model.monthSigns)
                print("🔴 badDays = ",model.badDays)
                print("🔴 goodDays = ",model.goodDays)
                self.monthCalendarModel = model
                self.positive = model.goodDays.components(separatedBy: ",").compactMap { Int($0) }
                self.negative = model.badDays.components(separatedBy: ",").compactMap { Int($0) }
            }
        }
    }
    
}
