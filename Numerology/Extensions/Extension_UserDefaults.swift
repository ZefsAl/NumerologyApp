//
//  Extension_UserDefaults.swift
//  Numerology
//
//  Created by Serj on 21.07.2023.
//

import Foundation

extension UserDefaults {
    
    func setUserData(name: String, surname: String) {
        setValue(name, forKey: "nameKey")
        setValue(surname, forKey: "surnameKey")
        synchronize()
    }
    
    func setDateOfBirth(dateOfBirth: Date) {
        setValue(dateOfBirth, forKey: "dateOfBirthKey")
        synchronize()
    }
    
    func setDayTipModel(model: BoardOfDayModel) {
        if let encoded = try? JSONEncoder().encode(model) {
            UserDefaults.standard.set(encoded, forKey: "BoardOfDayModelKey")
        }
        synchronize()
    }
}
