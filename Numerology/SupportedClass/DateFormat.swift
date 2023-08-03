//
//  DateFormat.swift
//  Numerology
//
//  Created by Serj on 22.07.2023.
//

import Foundation
import UIKit

func setDateFormat(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "dd / MMMM / yyyy"
    return df.string(from: date)
}

//func convertStringDate(from dateStr: String) -> Date {
//    let df = DateFormatter()
//    df.dateFormat = "MMddyyyy"
//    return df.date(from: dateStr) ?? Date()
//}
