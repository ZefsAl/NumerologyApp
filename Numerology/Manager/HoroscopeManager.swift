//
//  HoroscopeManager.swift
//  Numerology
//
//  Created by Serj on 25.11.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import UIKit


final class HoroscopeManager {
    
    enum HrscpRequestType {
        case newRandom, oldSpecific
    }
    
    static let shared: HoroscopeManager = HoroscopeManager()
    private let firestore = Firestore.firestore()
    
    // MARK: - Signs
    func getSign(zodiacSign: String, completion: @escaping ((SignsModel, UIImage? ) -> Void) ) {
        let docRef = firestore.collection("Signs-hrscp").whereField("zodiacSigns", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            //
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: SignsModel.self)
                    
                    let storage = Storage.storage()
                    let megaByte = Int64(1 * 1024 * 1024)
                    
                    let ref = val.image?[0].ref // Путь
                    let pathReference = storage.reference(withPath: "\(ref ?? ref!)")
                    
//                    let ref2 = val.image?[1].ref // Путь
//                    let pathReference2 = storage.reference(withPath: "\(ref2 ?? ref2!)")
                    
                    pathReference.getData(maxSize: megaByte) { data1, error in
//                        pathReference2.getData(maxSize: megaByte) { data2, error in
                            if let error = error {
                                myPrint("⚠️ Error getting IMAGE: \(error)")
                            } else {
                                guard
                                    let data1 = data1
//                                    let data2 = data2
                                else {
                                    myPrint("⚠️ Error getting IMAGE: \(String(describing: error))")
                                    return
                                }
                                let image1 = UIImage(data: data1)
//                                let image2 = UIImage(data: data2)
                                completion(val,image1)
                            }
//                        }
                    }
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    // MARK: - Today
    func getTodayHrscp(requestType: HrscpRequestType, completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        // random || specific
        
        let range = Array(1...58) // костыль
        let randomElement = range.randomElement() ?? 1
        // Primary request -> save tomorrowArticleNumber
        // Array(1...58) или let random = documents.randomElement() или let random = documents.count
        // Array(1...58) // временный fix
        
        let todayNumber = UserDefaults.standard.object(forKey: UserDefaultsKeys.todayHrscpNumber) as? Int
        let tomorrowNumber = UserDefaults.standard.object(forKey: UserDefaultsKeys.tomorrowHrscpNumber) as? Int
        
        switch requestType {
        case .newRandom:
            // Unwrap
            guard
                let tomorrowNumber = tomorrowNumber
            else {
                // Not unwraped -> random
                getTodayTomorrHrscp(number: randomElement) { val in
                    completion(val)
                }
                return
            }
            // Unwraped -> old tomorrow like new today
            getTodayTomorrHrscp(number: tomorrowNumber) { val in
                completion(val)
            }
        case .oldSpecific:
            // Unwrap
            guard
                let todayNumber = todayNumber
            else {
                // не извлекли -> random
                getTodayTomorrHrscp(number: randomElement) { val in
                    completion(val)
                }
                return
            }
            // Unwraped -> сохраненный
            getTodayTomorrHrscp(number: todayNumber) { val in
                completion(val)
            }
        }

    }
    
    // MARK: - Tomorrow
    func getTomorrowHrscp(requestType: HrscpRequestType, completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        // random || specific
        
        let range = Array(1...58)
        let randomElement = range.randomElement() ?? 1
        // Primary request -> save tomorrowArticleNumber
        // Array(1...58) или let random = documents.randomElement() или let random = documents.count
        // Array(1...58) // временный fix
        
        let todayNumber = UserDefaults.standard.object(forKey: UserDefaultsKeys.todayHrscpNumber) as? Int
        let tomorrowNumber = UserDefaults.standard.object(forKey: UserDefaultsKeys.tomorrowHrscpNumber) as? Int
        
        switch requestType {
        case .newRandom:
            // unwrap
            guard
                let todayNumber = todayNumber,
                let excludeSameMatch = range.filter({ $0 != todayNumber }).randomElement()
            else {
                // Not unwraped -> random
                getTodayTomorrHrscp(number: randomElement) { val in
                    completion(val)
                }
                return
            }
            // unwraped -> Гороскоп != today
                getTodayTomorrHrscp(number: excludeSameMatch) { val in
                    completion(val)
                }
        case .oldSpecific:
            guard 
                let tomorrowNumber = tomorrowNumber
            else {
                // Not unwraped -> random
                getTodayTomorrHrscp(number: randomElement) { val in
                    completion(val)
                }
                return
            }
            // Unwraped -> сохраненный
            getTodayTomorrHrscp(number: tomorrowNumber) { val in
                completion(val)
            }
        }

    }
    
    private func getTodayTomorrHrscp(number: Int, completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        let docRef = firestore.collection("Today-tomor-hrscp").whereField("number", isEqualTo: number)
        docRef.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            if let error = error { myPrint("⚠️ Error getting documents: \(error)") }
            documents.forEach { doc in
                do {
                    let val = try doc.data(as: HoroscopeDefaultModel.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    // MARK: - Week
    func getWeekHoroscope(completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        
        let fixNotFilledData = Array(1...25).randomElement() ?? 1
        
        let docRef = firestore.collection("Week-hrscp").whereField("number", isEqualTo: fixNotFilledData)
        
        docRef.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            if let error = error { myPrint("⚠️ Error getting documents: \(error)") }
            // Random
//            if let random = documents.randomElement() {
//                do {
//                    let val = try random.data(as: HoroscopeDefaultModel.self)
//                    completion(val)
//                } catch {
//                    myPrint("⚠️ Error decode documents: \(error)")
//                }
//            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: HoroscopeDefaultModel.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    // MARK: - Month
    func getMonthHoroscope(zodiacSign: String, completion: @escaping (MonthModel) -> Void) {
        let docRef = firestore.collection("Month-hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            //
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: MonthModel.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    // MARK: - Year 2023
    func getYear2023Horoscope(zodiacSign: String, completion: @escaping (Year2023Model) -> Void) {
        let docRef = firestore.collection("2023-hrscp").whereField("yearSign", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            //
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: Year2023Model.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    // MARK: - Year 2024
    func getYear2024Horoscope(zodiacSign: String, completion: @escaping (Year2024Model) -> Void) {
        let docRef = firestore.collection("2024-hrscp").whereField("yearSign", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            //
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: Year2024Model.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    
    // MARK: - Year 2024
    func getSignСompatibility(zodiacSign: String, completion: @escaping (CompatibilityHrscpModel) -> Void) {
        let docRef = firestore.collection("Compatibility-hrscp").whereField("signOfUser", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            //
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: CompatibilityHrscpModel.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    // need to remove getMoonPhase
    func getMoonPhase(moonDay: Int, completion: @escaping (MoonPhaseModel) -> Void) {
        let docRef = firestore.collection("MoonPhase").whereField("moonDay", isEqualTo: moonDay)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { myPrint("⚠️ NOT get doc"); return }
            //
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: MoonPhaseModel.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    // MARK: - get Money Calendar
    func getMoneyCalendar(zodiacSign: String, completion: @escaping (MonthCalendarModel) -> Void) {
        
        let changeHoroscope: Int = {
            // cust: change to next horoscope if day "27"
            let date = Date()
            let currentDay = date.get(.day)
            let current = date.get(.month)
            let next = date.getNext(.month)
            return currentDay >= 27 ? next : current
        }()
        
        // request
        makeMoneyCalendarRef(byMonth: changeHoroscope, zodiacSign: zodiacSign).getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { myPrint("NOT get doc"); return }
            //
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: MonthCalendarModel.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    func makeMoneyCalendarRef(byMonth: Int, zodiacSign: String) -> Query {
        // var docRef: Query { switch Date().get(.month) { // old
        
        switch byMonth {
        case 1:
            myPrint("1 Month API")
            return firestore.collection("January-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 2:
            myPrint("2 Month API")
            return firestore.collection("February-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 3:
            myPrint("3 Month API")
            return firestore.collection("March-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 4:
            myPrint("4 Month API")
            return firestore.collection("April-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 5:
            myPrint("5 Month API")
            return firestore.collection("May-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 6:
            myPrint("6 Month API")
            return firestore.collection("June-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 7:
            myPrint("7 Month API")
            return firestore.collection("July-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 8:
            myPrint("8 Month API")
            return firestore.collection("August-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 9:
            myPrint("9 Month API")
            return firestore.collection("September-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 10:
            myPrint("10 Month API")
            return firestore.collection("October-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 11:
            myPrint("11 Month API")
            return firestore.collection("November-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        case 12:
            myPrint("12 Month API")
            return firestore.collection("December-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        default:
            return firestore.collection("January-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        }
    }

}













