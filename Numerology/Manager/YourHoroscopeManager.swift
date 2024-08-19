//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 10.08.2024.
//

import Foundation
import UIKit

class YourHoroscopeManager {
    
    static let shared: YourHoroscopeManager = YourHoroscopeManager()
    
    
//    var yourHrscpImages: [UIImage?]?
    var yourHrscpImages_v2: [String:UIImage?]? {
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
    
    
    
    
    // Сохранить предыдущий
    // Today -> request by number
    
    // Tomorrow -> (Random if UserDefaults val == nil) ||
    
//    let somese = "сохранять Key(number) поля предыдущего(Tomorrow) случайного запроса"
//    
//    func save(currentDay: Int, ) {
//
//    }
    
    
    
    
    func requestData() {
        let sign = HoroscopeSign().findHoroscopeSign(byDate: UserDataKvoManager.shared.dateOfBirth)

        // random Today-tomor ‼️
        // Today //
        DispatchQueue.main.async {
            HoroscopeManager.shared.getTodayHoroscope { model in
                self.todayHoroscope = model
//                print("🌕‼️🟢 request Today:",
//                """
//                \(self.todayHoroscope?.number),
//                \(self.todayHoroscope?.charts),
//                \(self.todayHoroscope?.love),
//                """
//                )
            }
        }
        // Tomorrow
        DispatchQueue.main.async {
            HoroscopeManager.shared.getTodayHoroscope { model in
                self.tomorrowHoroscope = model
//                print("🌕‼️🟢 request tomorow:",
//                """
//                \(self.tomorrowHoroscope?.number),
//                \(self.tomorrowHoroscope?.charts),
//                \(self.tomorrowHoroscope?.love),
//                """
//                )
            }
        }
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
//                print("🌕‼️🟢 request Week:",
//                """
//                \(self.monthHoroscope?.monthSigns),
//                "Trends" - \(self.monthHoroscope?.mainTrends),
//                "info" - \(self.monthHoroscope?.monthInfo),
//                "Trends" - \(self.monthHoroscope?.charts),
//                """
//                )
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
                self.yourHrscpImages_v2 = dict
            }
        }
        
        
    }
}
