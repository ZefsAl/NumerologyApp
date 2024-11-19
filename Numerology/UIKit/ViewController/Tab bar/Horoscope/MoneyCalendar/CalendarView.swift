//
//  CalendarView.swift
//  Numerology
//
//  Created by Serj on 30.11.2023.
//

import Foundation
import UIKit
import FSCalendar


final class CalendarView: FSCalendar, FSCalendarDataSource, FSCalendarDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Style
        calendarStyle()
        
        self.dataSource = self
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func calendarStyle() {
        
        self.appearance.headerMinimumDissolvedAlpha = 0

        // Today
        self.appearance.todayColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        
        // Header Title
        self.appearance.headerTitleFont = DesignSystem.CinzelFont.title_h3
        self.appearance.headerTitleColor = DesignSystem.Horoscope.lightTextColor
        
        // Week Day
        self.firstWeekday = 2
        self.appearance.weekdayTextColor = .white
        self.appearance.weekdayFont = UIFont.systemFont(ofSize: 17)
        self.weekdayHeight = 40
        
        //
        placeholderType = .none
        
        // Syle
        self.appearance.titleDefaultColor = .white
    }
}



extension CalendarView: FSCalendarDelegateAppearance {

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        
        if MoneyCalendarManager.shared.positive.contains(date.get(.day)) &&
            !MoneyCalendarManager.shared.positive.isEmpty
        {
            return #colorLiteral(red: 0.3098039216, green: 0.8156862745, blue: 0.4509803922, alpha: 1)
        } else {
            self.reloadData()
        }
        
        if MoneyCalendarManager.shared.negative.contains(date.get(.day)) &&
            !MoneyCalendarManager.shared.negative.isEmpty
        {
            return #colorLiteral(red: 0.9215686275, green: 0.4588235294, blue: 0.4117647059, alpha: 1)
        } else {
            self.reloadData()
        }
        
        self.reloadData()
        
        return UIColor.clear
    }
    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.updateConstraints()
        calendar.heightAnchor.constraint(equalToConstant: bounds.height).isActive = true
        self.layoutIfNeeded()
    }
}
