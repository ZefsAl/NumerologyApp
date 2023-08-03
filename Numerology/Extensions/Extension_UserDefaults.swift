//
//  Extension_UserDefaults.swift
//  Numerology
//
//  Created by Serj on 21.07.2023.
//

import Foundation

extension UserDefaults {
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    
    func setUserData(name: String, surname: String) {
        setValue(name, forKey: "nameKey")
        setValue(surname, forKey: "surnameKey")
        synchronize()
    }
    
    func setDateOfBirth(dateOfBirth: Date) {
        setValue(dateOfBirth, forKey: "dateOfBirthKey")
        synchronize()
    }
    
//    func isHaveUserData() -> Bool {
//        if UserDefaults.standard.object(forKey: "nameKey") ||
//            UserDefaults.standard.object(forKey: "surnameKey")
//    }
    
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
        
    }
}
