//
//  CustomDateTextfield.swift
//  Numerology
//
//  Created by Serj on 10.08.2023.
//

import UIKit

class PersonalMonthTF: CustomTF, PersonalMonthProtocol {

    
    var receivedDate: Date?
//    delegate
    func getPickerDate(date: Date) {
        let df = DateFormatter()
        df.dateFormat = "MMMM / yyyy"
        let formatedStrDate = df.string(from: date)
        self.text = formatedStrDate
        receivedDate = date
    }
    
    let customDatePicker = PersonalMonthDatePicker()
    
    override init(frame: CGRect, setPlaceholder: String) {
        super.init(frame: frame, setPlaceholder: setPlaceholder)
      
        self.textAlignment = .center
        self.rightViewMode = .never
        self.leftViewMode = .never
        
        self.inputView = customDatePicker
        customDatePicker.valueDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
