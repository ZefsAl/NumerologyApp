//
//  CustomDatePicker.swift
//  Numerology
//
//  Created by Serj on 09.08.2023.
//

import UIKit

protocol PersonalMonthProtocol: AnyObject {
    func getPickerDate(date: Date)
}

class PersonalMonthDatePicker: UIPickerView {
    
    var valueDelegate: PersonalMonthProtocol?
    
    var monthArr: [String] = {
        let df = DateFormatter()
//        df.dateFormat = "MMMM"
        let month = df.standaloneMonthSymbols
        var arr: [String] = month ?? ["error"]
        
        print(arr)
        
        let langStr = Locale.current.languageCode
//        print(langStr)
        if langStr == "ru" {
            let arr = arr.map { $0.capitalized}
            return arr
        }
        
        return arr
    }()
    
    var yearArr: [String] = {
        var arr = [String]()
        
        for val in 1950...2100 {
            let valStr = String(val)
            arr.append(valStr)
        }
        return arr
    }()
    
    
//    var comple
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonalMonthDatePicker: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let row0 = monthArr[pickerView.selectedRow(inComponent: 0)]
        let row1 = yearArr[pickerView.selectedRow(inComponent: 1)]
        
        let strDate = "01-\(row0)-\(row1)T00:00:00+0000"
        
        print(row0)
        print(row1)
        print(strDate)
        
        
        
        
        // DateFormatter не может преобразовать русский месяц в Date
        
        
        let df = DateFormatter()
//        df.locale = Locale(identifier: "en_US")
        
        let langStr = Locale.current.languageCode
        if langStr == "ru" {
            df.dateFormat = "dd-LLLL-yyyy'T'HH:mm:ssZ"
        } else {
            df.dateFormat = "dd-MMMM-yyyy'T'HH:mm:ssZ"
        }
        
        let selectedDate = df.date(from: strDate)
        print("selectedDate: \(String(describing: selectedDate))")
        
        if let selectedDate = selectedDate {
            valueDelegate?.getPickerDate(date: selectedDate)
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            // Month
            return monthArr.count
        } else {
            // Year
            return yearArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            // Month
            return monthArr[row]
        } else {
            // Year
            return yearArr[row]
        }
    }
    
    
}

