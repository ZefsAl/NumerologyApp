//
//  CustomDateTextfield.swift
//  Numerology
//
//  Created by Serj on 10.08.2023.
//

import UIKit

class PersonalMonthTF: RegularTextField, PersonalMonthProtocol {

    
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
        self.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.09019607843, blue: 0.1725490196, alpha: 1)
        self.layer.borderColor = UIColor.clear.cgColor
        
        self.inputView = customDatePicker
        customDatePicker.valueDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
