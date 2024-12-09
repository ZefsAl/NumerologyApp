//
//  DateFormat.swift
//  Numerology
//
//  Created by Serj on 22.07.2023.
//

import Foundation
import UIKit

// For display UI
func setDateFormat(date: Date, format: String = "dd / MMMM / yyyy") -> String {
    let df = DateFormatter()
    df.dateFormat = format
    return df.string(from: date)
}

func makeTimeString(date: Date, AMPM: Bool = true ) -> String {
    let df = DateFormatter()
    
    let ampm = AMPM ? "a" : ""
    let Hours = AMPM ? "hh" : "HH"
    
    df.dateFormat = "\(Hours) : mm \(ampm)"
    if AMPM {
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
    }
    return df.string(from: date)
}

func makeTimeDate(string: String) -> Date? {
    let df = DateFormatter()
    df.dateFormat = "hh : mm a"
    df.amSymbol = "AM"
    df.pmSymbol = "PM"
    return df.date(from: string)
}

func makeTimeFromTodayDate(at: (hour: Int, minute: Int)) -> Date? {
    var dateComponents = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: Date())
    dateComponents.hour = at.hour
    dateComponents.minute = at.minute
    return Calendar.autoupdatingCurrent.date(from: dateComponents)
}
