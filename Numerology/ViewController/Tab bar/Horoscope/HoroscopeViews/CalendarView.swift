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
        configCalendarStyle()
        
        self.dataSource = self
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configCalendarStyle() {
        
        self.appearance.headerMinimumDissolvedAlpha = 0

        // Today
        self.appearance.todayColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        
        
        // Header Title
        self.appearance.headerTitleFont = DesignSystem.FeedCard.title
        self.appearance.headerTitleColor = DesignSystem.Horoscope.lightTextColor
        
        // Week Day
        self.firstWeekday = 2
        self.appearance.weekdayTextColor = .white
        self.appearance.weekdayFont = UIFont.systemFont(ofSize: 17)
        self.weekdayHeight = 40
        
        placeholderType = .none
        
        
////        self.locale = Locale(identifier: "ru")
        
        
/////       self.appearance.backgroundColors = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        
        // Syle
        self.appearance.titleDefaultColor = .white
        
    }
    

//    private func configureDates() -> [Date] {
//        let mainFormatter: DateFormatter = {
//           let df = DateFormatter()
//            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//            return df
//        }()
//
//        let positive: [String] = [
//        "\(2023)-\(12)-\(2)T00:00:00+0000",
//        "\(2023)-\(12)-\(4)T00:00:00+0000",
//        "\(2023)-\(12)-\(7)T00:00:00+0000",
//        "\(2023)-\(12)-\(9)T00:00:00+0000",
//        "\(2023)-\(12)-\(8)T00:00:00+0000",
//        "\(2023)-\(12)-\(5)T00:00:00+0000",
//        "\(2023)-\(12)-\(11)T00:00:00+0000",
//        "\(2023)-\(12)-\(12)T00:00:00+0000"
//        ]
//
//        let positiveDates: [Date] = positive.map { str in
//            mainFormatter.date(from: str) ?? Date()
//        }
////        self.eventsDateArray = positiveDates
////        self.reloadData()
//        return positiveDates
//    }
    

    
    
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
//        date.
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////// не то
//        let mainFormatter: DateFormatter = {
//           let df = DateFormatter()
//            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//            return df
//        }()
//
//        let positive: [String] = [
//        "\(2023)-\(12)-\(2)T00:00:00+0000",
//        "\(2023)-\(12)-\(4)T00:00:00+0000",
//        "\(2023)-\(12)-\(7)T00:00:00+0000",
//        "\(2023)-\(12)-\(9)T00:00:00+0000",
//        "\(2023)-\(12)-\(8)T00:00:00+0000",
//        "\(2023)-\(12)-\(5)T00:00:00+0000",
//        "\(2023)-\(12)-\(11)T00:00:00+0000",
//        "\(2023)-\(12)-\(12)T00:00:00+0000"
//        ]
//
//        let positiveDates: [Date] = positive.map { str in
//            mainFormatter.date(from: str) ?? Date()
//        }
//        self.eventsDateArray = positiveDates
//        self.reloadData()
//
//        positiveDates.forEach { date in
//            calendar.allowsMultipleSelection = true
//            calendar.appearance.borderSelectionColor = .green
//            calendar.appearance.selectionColor = .clear
//            calendar.select(date, scrollToDate: false)
//        }
//
//
//        let negative: [String] = [
//        "\(2023)-\(12)-\(3)T00:00:00+0000",
//        "\(2023)-\(12)-\(4)T00:00:00+0000",
//        "\(2023)-\(12)-\(10)T00:00:00+0000",
//        "\(2023)-\(12)-\(13)T00:00:00+0000",
//        "\(2023)-\(12)-\(14)T00:00:00+0000",
//        "\(2023)-\(12)-\(15)T00:00:00+0000",
//        "\(2023)-\(12)-\(16)T00:00:00+0000",
//        "\(2023)-\(12)-\(19)T00:00:00+0000"
//        ]
//
//        let negativeDates: [Date] = negative.map { str in
//            mainFormatter.date(from: str) ?? Date()
//        }
//
//        negativeDates.forEach { date in
//            calendar.allowsMultipleSelection = true
//            calendar.appearance.borderSelectionColor = .red
//            calendar.appearance.selectionColor = .clear
//            calendar.select(date, scrollToDate: false)
//        }
        
        
        
//    }
    
//    var eventsDateArray: [Date] = []
}



extension CalendarView: FSCalendarDelegateAppearance {

 // Return UIColor for numbers;

// func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//
//     if self.configureDates().contains(date) {
//           return UIColor.white
//           // Return UIColor for eventsDateArray
//      }
//
//    return UIColor.purple // Return Default Title Color
//}

 // Return UIColor for Background;

//func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//
//    let mainFormatter: DateFormatter = {
//       let df = DateFormatter()
//        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        return df
//    }()
//
////    let str = "\(2023)-\(12)-\(12)T00:00:00+0000"
////    let newDate = mainFormatter.date(from: str) ?? Date()
//
////    if date.get(.day) == 11 {
////        return UIColor.systemPink
////    }
//
////    if mainFormatter.date(from: mainFormatter.string(from: date)) == newDate {
////        return UIColor.systemPink
////    }
//
////    if self.configureDates().contains(date) {
////        return UIColor.blue // Return UIColor for eventsDateArray
////    }
//
//    return #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1) // Return Default UIColor
//}
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
            
        let negative: [Int] = [4,9,14,19,24,29]
        let positive: [Int] = [2,6,7,10,12,15,16,18,20,21,22,23,25,28,30]
        
        // +- отображает
        if positive.contains(date.get(.day)) {
            return #colorLiteral(red: 0.3098039216, green: 0.8156862745, blue: 0.4509803922, alpha: 1)
        }
        if negative.contains(date.get(.day)) {
            return #colorLiteral(red: 0.9215686275, green: 0.4588235294, blue: 0.4117647059, alpha: 1)
        }

        
        
        
        
//        self.configureDates().forEach { date in
////            calendar.allowsMultipleSelection = true
////            calendar.appearance.borderSelectionColor = .green
////            calendar.appearance.selectionColor = .clear
////            calendar.select(date, scrollToDate: false)
////            return UIColor.blue
//        }
        
        return UIColor.clear
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.updateConstraints()
        calendar.heightAnchor.constraint(equalToConstant: bounds.height).isActive = true
        self.layoutIfNeeded()
    }
}
