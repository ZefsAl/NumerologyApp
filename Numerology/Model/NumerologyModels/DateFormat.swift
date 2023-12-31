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

