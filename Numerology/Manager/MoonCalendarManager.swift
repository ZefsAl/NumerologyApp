//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.05.2024.
//

import Foundation
import EKAstrologyCalc
import CoreLocation


final class MoonCalendarManager {

    let location = CLLocation(latitude: 43.000000, longitude: -75.000000) // NY
    lazy var moonPhaseManager: EKAstrologyCalc = EKAstrologyCalc(location: location)
    
    func getAfternoonMoonDay() -> Int {
        let info = moonPhaseManager.getInfo(date: Date())
         let result = info.moonModels.max { $0.age < $1.age }?.age // !!!!
        print("🌕🌚 Afternoon is day is",result as Any)
        print("Current Date",Date())
//        calculateMoon()
        return result ?? 1
    }

    func calculateMoon() {

        moonPhaseManager = EKAstrologyCalc(location: location)

        let info = moonPhaseManager.getInfo(date: mockDate)
        

        print("Current localtion: -", info.location.coordinate)

        print("Moon days at", "current date: -", info.date)
        info.moonModels.forEach {
            print("🔵===========🔵")
            print("Moon Age: -", $0.age)
            print("Moon rise: -", $0.begin)
            print("Moon set: -", $0.finish)
            print("Moon sign: -", $0.sign)
        }
        print("+++++++++++")
        print("Moon phase: -", info.phase)
        print("Moon trajectory: -", info.trajectory)
        print("⚠️ Moon date: -", info.date)
        print("⚠️ moon Models: -", info.moonModels)
        
        print("⚠️⚠️⚠️ mock Date", mockDate)
    }
    
    
    lazy var mockDate: Date = {
        makeDate(strDate: "2024-06-06 18:06:46 +0000")
    }()!
    
    
    func makeDate(strDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure a specific locale for consistent formatting
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: strDate)
    }
    
    func makeStringDay(strDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: strDate)?.day
    }
}


