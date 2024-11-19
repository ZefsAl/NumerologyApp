//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.10.2024.
//

import SwiftUI
import UIKit

class DatePickerCustomTF: UITextField {
    
    @Binding var date: Date?
    
    init(date: Binding<Date?>, setPlaceholder: String) {
        self._date = date
        super.init(frame: .null)
        self.setupDatePicker(date: self.date)
        // Setup
        self.clearButtonMode = .whileEditing
        self.addDoneKeyboardAccessoryButton()
        self.attributedPlaceholder = NSAttributedString(string: setPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDatePicker(date: Date?) {
        // MARK: Date Picker
        let datePicker: UIDatePicker = {
            let dp = UIDatePicker()
            dp.datePickerMode = .date
            dp.preferredDatePickerStyle = .wheels
            dp.addTarget(Any?.self, action: #selector(datePickerAction), for: .valueChanged)
            
            var minDateComponents = DateComponents()
            minDateComponents.year = 1950
            var maxDateComponents = DateComponents()
            maxDateComponents.year = 2100
            let userCalendar = Calendar(identifier: .gregorian)
            if let start = userCalendar.date(from: minDateComponents),
               let end = userCalendar.date(from: maxDateComponents) {
                dp.minimumDate = Date(timeInterval: 0, since: start)
                dp.maximumDate = Date(timeInterval: 0, since: end)
            }
            if let date = date {
                dp.date = date
            }
            return dp
        }()
        self.inputView = datePicker
    }
    
    // MARK: Date Picker Action
    @objc func datePickerAction(_ sender: UIDatePicker) {
        self.text = setDateFormat(date: sender.date) // display
        self.date = sender.date
    }
    
}


struct DatePickerTF_SUI: UIViewRepresentable {
    
    @Binding var date: Date?
    var setPlaceholder: String

    func makeUIView(context: Context) -> DatePickerCustomTF {
        let dp = DatePickerCustomTF(date: $date, setPlaceholder: setPlaceholder)
        dp.tintColor = .white
        if let date = date {
            dp.text = setDateFormat(date: date)
        }
        
        return dp
    }

    func updateUIView(_ uiView: DatePickerCustomTF, context: Context) {

    }

}
