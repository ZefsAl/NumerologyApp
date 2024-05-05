//
//  HoroscopeSign.swift
//  Numerology
//
//  Created by Serj on 25.11.2023.
//

import Foundation

final class HoroscopeSign {
    
    // Set format for any received dates
    private let mainFormatter: DateFormatter = {
       let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df
    }()
    
    // Creating dates from date context
    private func create(string: String) -> Date {
        // dictionary date format context -> random format
        let dictFormat: DateFormatter = {
           let df = DateFormatter()
            df.dateFormat = "dd.MM"
            return df
        }()
        // Here we get only one part of the random format date
        guard
            let day = dictFormat.date(from: string)?.get(.day),
            let month = dictFormat.date(from: string)?.get(.month)
        else { return Date() }
        // Again reduce to main format
        let dateString = "\(2000)-\(month)-\(day)T00:00:00+0000" // Shouldn't be optional
        return mainFormatter.date(from: dateString) ?? Date()
    }
    
    // MARK: - horoscope Signs
    private func horoscopeSigns() -> Dictionary<String, [Int:DateInterval]> {
        //
        let horoscopeSigns: Dictionary<String, [Int:DateInterval]> = [
            "Aries"       : [0 : DateInterval(start: create(string: "21.03"), end: create(string: "20.04"))],
            "Taurus"      : [0 : DateInterval(start: create(string: "21.04"), end: create(string: "20.05"))],
            "Gemini"      : [0 : DateInterval(start: create(string: "21.05"), end: create(string: "21.06"))],
            "Cancer"      : [0 : DateInterval(start: create(string: "22.06"), end: create(string: "22.07"))],
            "Leo"         : [0 : DateInterval(start: create(string: "23.07"), end: create(string: "23.08"))],
            "Virgo"       : [0 : DateInterval(start: create(string: "24.08"), end: create(string: "23.09"))],
            "Libra"       : [0 : DateInterval(start: create(string: "24.09"), end: create(string: "23.10"))],
            "Scorpio"     : [0 : DateInterval(start: create(string: "24.10"), end: create(string: "22.11"))],
            "Sagittarius" : [0 : DateInterval(start: create(string: "23.11"), end: create(string: "21.12"))],
            "Capricorn"   : [
                0 : DateInterval(start: create(string: "22.12"), end: create(string: "31.12")),
                1 : DateInterval(start: create(string: "01.01"), end: create(string: "20.01"))
            ],
            "Aquarius"    : [0 : DateInterval(start: create(string: "21.01"), end: create(string: "20.02"))],
            "Pisces"      : [0 : DateInterval(start: create(string: "21.02"), end: create(string: "20.03"))],
        ]
        //
        return horoscopeSigns
    }
    
    // MARK: - find Horoscope Sign
    func findHoroscopeSign(find: Date?) -> String {
        guard
            let find = find,
            let find = mainFormatter.date(from: "\(2000)-\(find.get(.month))-\(find.get(.day))T00:00:00+0000")
        else { return "" }
        //
        for (key, value) in horoscopeSigns() {
            if let interval0 = value[0],
               interval0.contains(find) {
                return key
            } else if let interval1 = value[1],
                      interval1.contains(find) {
                return key
            }
        }
        return ""
    }
    //
}
