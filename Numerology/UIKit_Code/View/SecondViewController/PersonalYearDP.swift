//
//  PersonalYearDP.swift
//  Numerology
//
//  Created by Serj on 11.08.2023.
//

import UIKit



protocol PersonalYearDPProtocol: AnyObject {
    func getPickerDate(date: Date)
}

class PersonalYearDP: UIPickerView {
    
    var valueDelegate: PersonalYearDPProtocol?
    
    var yearArr: [String] = {
        var arr = [String]()
        
        for val in 1950...2100 {
            let valStr = String(val)
            arr.append(valStr)
        }
        return arr
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonalYearDP: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let row0 = yearArr[pickerView.selectedRow(inComponent: 0)]
        
        print(row0)
        
        let strDate = "01-01-\(row0)T00:00:00+0000"
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "dd-MM-yyyy'T'HH:mm:ssZ"
        
        let selectedDate = df.date(from: strDate)
        print("selectedDate: \(String(describing: selectedDate))")
        
        if let selectedDate = selectedDate {
            valueDelegate?.getPickerDate(date: selectedDate)
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Year
        return yearArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Year
        return yearArr[row]
    }
    
    
}

