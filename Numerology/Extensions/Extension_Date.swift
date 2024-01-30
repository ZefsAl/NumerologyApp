//
//  File.swift
//  Numerology
//
//  Created by Serj on 30.01.2024.
//

import Foundation

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
