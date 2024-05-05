//
//  DateFormat.swift
//  Numerology
//
//  Created by Serj on 22.07.2023.
//

import Foundation
import UIKit

// For display UI
func setDateFormat(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "dd / MMMM / yyyy"
    return df.string(from: date)
}

func makeTimeString(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "hh : mm a"
    df.amSymbol = "AM"
    df.pmSymbol = "PM"
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
