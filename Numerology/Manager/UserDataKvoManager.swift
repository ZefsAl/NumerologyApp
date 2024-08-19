//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.08.2024.
//

import Foundation

class UserDataKvoManager: NSObject {
    
    static let shared = UserDataKvoManager()
    
    
    
    enum UserDataType {
        case name, surname, dateOfBirth
    }
    
    // Фигня выходит устанавливать через func set
    
    // MARK: - KVO
    @objc dynamic var name: String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.name) {
        didSet {
            print("➡️ didSet ",self.name)
            saveDidSetAction(value: self.name, key: UserDefaultsKeys.name)
        }
    }
    
    @objc dynamic var surname: String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.surname) {
        didSet {
            print("➡️ didSet ",self.surname)
            saveDidSetAction(value: self.surname, key: UserDefaultsKeys.surname)
        }
    }
    
    @objc dynamic var dateOfBirth: Date? = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date {
        didSet {
            print("➡️ didSet ",self.dateOfBirth)
            saveDidSetAction(value: self.dateOfBirth, key: UserDefaultsKeys.dateOfBirth)
        }
    }
    
    
    
//    private var token: NSKeyValueObservation? = nil
//    func setObserver() {
//        token = UserDataKvoManager.shared.observe(\.name) { object, change in  // the `[weak self]` is to avoid strong reference cycle; obviously, if you don't reference `self` in the closure, then `[weak self]` is not needed
//            print("bar property is now \(object.name)")
//        }
//    }
    
    func setUserDataDidChangeNotification(observer: Any, action: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: action,
            name: .userDataDidChangeNotification,
            object: nil
        )
    }
    
    
    private func saveDidSetAction(value: Any?, key: String) {
        UserDefaults.standard.setValue(value, forKey: key) // 1 
        UserDefaults.standard.synchronize() // 2
        NotificationCenter.default.post(name: .userDataDidChangeNotification, object: nil) // 3
    }
    
    func set(type userDataType: UserDataType, value: Any) {
        switch userDataType {
        case .name: 
            let value = value as? String
            self.name = value
            UserDefaults.standard.setValue(value, forKey: UserDefaultsKeys.name)
        case .surname:
            let value = value as? String
            self.surname = value
            UserDefaults.standard.setValue(value, forKey: UserDefaultsKeys.surname)
        case .dateOfBirth:
            let value = value as? Date
            self.dateOfBirth = value
            UserDefaults.standard.setValue(value, forKey: UserDefaultsKeys.dateOfBirth)
        }
        UserDefaults.standard.synchronize()
    }
    
    func isAllUserDataAvailable() -> Bool {
        // kvo v1
//        guard
//        UserDataKvoManager.shared.name != nil && UserDataKvoManager.shared.name != "" &&
//        UserDataKvoManager.shared.surname != nil && UserDataKvoManager.shared.surname != "" &&
//        UserDataKvoManager.shared.dateOfBirth != nil
//        else {
//            return false
//        }
//        return true
        
        guard
        UserDataKvoManager.shared.name == nil || UserDataKvoManager.shared.name == "" &&
        UserDataKvoManager.shared.surname == nil || UserDataKvoManager.shared.surname == "" &&
        UserDataKvoManager.shared.dateOfBirth == nil
        else {
            print("🌕 isAllUserDataAvailable", true)
            return true
        }
        print("🌕 isAllUserDataAvailable", false)
        return false
            
        // 🌕 User defaults v2
//        let dataName = UserDefaults.standard.object(forKey: UserDefaultsKeys.name)
//        let dataSurname = UserDefaults.standard.object(forKey: UserDefaultsKeys.surname)
//        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth)
//        
//        guard
//            (dataName != nil && dataName as? String != "") &&
//            (dataSurname != nil && dataSurname as? String != "") &&
//            dateOfBirth != nil
//        else { return false }
//        return true
//        
//        
        
        
    }
    
    
}


//extension UserDefaults {
//    
//    func setUserData(name: String, surname: String) {
//        setValue(name, forKey: UserDefaultsKeys.name)
//        setValue(surname, forKey: UserDefaultsKeys.surname)
//        synchronize()
//    }
//    
//    func setDateOfBirth(dateOfBirth: Date) {
//        setValue(dateOfBirth, forKey: UserDefaultsKeys.dateOfBirth)
//        synchronize()
//    }
//    
//    func setDayTipModel(model: BoardOfDayModel) {
//        if let encoded = try? JSONEncoder().encode(model) {
//            UserDefaults.standard.set(encoded, forKey: "BoardOfDayModelKey")
//        }
//        synchronize()
//    }
//}
