//
//  PersonalYearTF.swift
//  Numerology
//
//  Created by Serj on 11.08.2023.
//

import UIKit

class PersonalYearTF: CustomTF, PersonalYearDPProtocol {
    
    var receivedDate: Date?
//    delegate
    func getPickerDate(date: Date) {
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        let formatedStrDate = df.string(from: date)
        self.text = formatedStrDate
        receivedDate = date
    }
    
    let customDatePicker = PersonalYearDP()
    
    override init(setPlaceholder: String) {
        super.init(setPlaceholder: setPlaceholder)
      
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
