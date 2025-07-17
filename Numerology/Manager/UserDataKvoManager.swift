//

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
    
    // MARK: - KVO
    @objc dynamic var name: String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.name) {
        didSet {
//            myPrint("➡️ didSet ",self.name)
            saveDidSetAction(value: self.name, key: UserDefaultsKeys.name)
        }
    }
    
    @objc dynamic var surname: String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.surname) {
        didSet {
//            myPrint("➡️ didSet ",self.surname)
            saveDidSetAction(value: self.surname, key: UserDefaultsKeys.surname)
        }
    }
    
    @objc dynamic var dateOfBirth: Date? = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date {
        didSet {
//            myPrint("➡️ didSet ",self.dateOfBirth)
            saveDidSetAction(value: self.dateOfBirth, key: UserDefaultsKeys.dateOfBirth)
        }
    }
    
    
    
//    private var token: NSKeyValueObservation? = nil
//    func setObserver() {
//        token = UserDataKvoManager.shared.observe(\.name) { object, change in  // the `[weak self]` is to avoid strong reference cycle; obviously, if you don't reference `self` in the closure, then `[weak self]` is not needed
//            myPrint("bar property is now \(object.name)")
//        }
//    }
    
    func setUserDataDidChangeNotification(observer: Any, action: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: action,
            name: .userDataDidChangeNotification,
            object: nil
        )
        
        
        NotificationCenter.default.addObserver(forName: .userDataDidChangeNotification, object: nil, queue: .main) { notification in
            // 🔴 тут баг реагирует 2 раза // был
//            myPrint(
//                "🔴🔴⚠️ check userDataDidChangeNotification",
//                notification.description,
//                notification.debugDescription,
//                notification.userInfo as Any,
//                notification.object as Any
//            )
        }
        
    }
    
    private func saveDidSetAction(value: Any?, key: String) {
        UserDefaults.standard.setValue(value, forKey: key) // 1 
        UserDefaults.standard.synchronize() // 2
        
        guard self.isAllUserDataAvailable() else { return }
        NotificationCenter.default.post(name: .userDataDidChangeNotification, object: nil) // 3
    }
    
    func set(type userDataType: UserDataType, value: Any?) {
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
        guard
        UserDataKvoManager.shared.name == nil || UserDataKvoManager.shared.name == "" &&
        UserDataKvoManager.shared.surname == nil || UserDataKvoManager.shared.surname == "" &&
        UserDataKvoManager.shared.dateOfBirth == nil
        else {
            myPrint("🌕 isAllUserDataAvailable", true)
            return true
        }
        myPrint("🌕 isAllUserDataAvailable", false)
        return false
    }
}
