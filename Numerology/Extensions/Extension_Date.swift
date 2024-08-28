//

//  Numerology
//
//  Created by Serj on 30.01.2024.
//

import Foundation

extension Date {
    // must have
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func getNext(_ component: Calendar.Component, calendar: Calendar = Calendar.current, mock: Date = Date()) -> Int {
        let nextMonth = calendar.date(byAdding: component, value: 1, to: mock)
        return nextMonth?.get(component) ?? Date().get(component)
    }
    
    static func makeDateAsComponents(year: Int, month: Int, day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        //    dateComponents.timeZone = TimeZone(abbreviation: "JST") // Japan Standard Time
        dateComponents.hour = 0
        dateComponents.minute = 0
        // Create date from components
        let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
        let someDateTime = userCalendar.date(from: dateComponents)
        //
        if let someDateTime = someDateTime {
            print("makeDateAsComponents ✅ Unwrapped")
            return someDateTime
        } else {
            print("makeDateAsComponents 🔴 Not Unwrap")
            return Date()
        }
    }
    
    static func makeDate(year: String, month: String, day: String) -> Date {
        let strDate = "\(year)-\(month)-\(day)T00:00:00+0000"
        let df = DateFormatter()
        // full format
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let new = df.date(from: strDate)
        if let new = new {
            print("date ✅ Unwrapped")
            return new
        } else {
            print("date 🔴 Not Unwrap")
            return Date()
        }
    }
}
