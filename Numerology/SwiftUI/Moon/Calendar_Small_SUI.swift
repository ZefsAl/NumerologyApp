//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 03.11.2024.
//

import UIKit
import FSCalendar
import SwiftUI

struct CalendarSmall_SUI: UIViewRepresentable {
    @Binding var currentSelectedDate: Date?
    
    func makeUIView(context: Context) -> CalendarSmall {
        return CalendarSmall(currentSelectedDate: self.$currentSelectedDate)
    }
    
    func updateUIView(_ uiView: CalendarSmall, context: Context) {}
}

final class CalendarSmall: FSCalendar, FSCalendarDelegate,FSCalendarDataSource {
    
    @Binding var currentSelectedDate: Date?
    
    required init(currentSelectedDate: Binding<Date?>) {
        _currentSelectedDate = currentSelectedDate
        super.init(frame: .null)
        // Style
        calendarStyle()
        //
        self.dataSource = self
        self.delegate = self
//        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func calendarStyle() {
        // calendar
        self.appearance.calendar.scope = .week
        self.placeholderType = .none // previous/next days
        self.appearance.selectionColor = DS.MoonColors.mediumTint
        // Today
        self.appearance.todayColor = UIColor.clear
        self.appearance.todaySelectionColor = DS.MoonColors.mediumTint
        self.appearance.titleFont = UIFont.systemFont(ofSize: 13)
        // Header Title
        self.appearance.headerMinimumDissolvedAlpha = 0 // previous/next months
        self.appearance.headerTitleFont = DS.CinzelFont.title_h3
        self.appearance.headerTitleColor = DS.MoonColors.brightTint
        // Week Day
        self.firstWeekday = 2 // start week - US, EU ...
        self.appearance.weekdayTextColor = .white
        self.appearance.weekdayFont = UIFont.systemFont(ofSize: 17)
        self.weekdayHeight = 40
        // Syle
        self.appearance.titleDefaultColor = .white
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.currentSelectedDate = date
    }
    
}
extension CalendarSmall: FSCalendarDelegateAppearance {
// https://github.com/Enriquecm/CalendarCellExample/tree/main кастом итд
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        return calendar.today == date ? DS.MoonColors.mediumTint : UIColor.clear
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.updateConstraints()
        calendar.heightAnchor.constraint(equalToConstant: bounds.height).isActive = true
//        calendar.heightAnchor.constraint(lessThanOrEqualToConstant: bounds.height).isActive = true // cust!!
        self.layoutIfNeeded()
    }
    
}
