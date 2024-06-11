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
import FirebaseFirestoreSwift
import UIKit


final class HoroscopeManager {
    
    static let shared: HoroscopeManager = HoroscopeManager()
    private let firestore = Firestore.firestore()
    
    // MARK: - Signs
    func getSign(zodiacSign: String, completion: @escaping ((SignsModel, UIImage?, UIImage? ) -> Void) ) {
        let docRef = firestore.collection("Signs").whereField("zodiacSigns", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: SignsModel.self)
                    
                    let storage = Storage.storage()
                    let megaByte = Int64(1 * 1024 * 1024)
                    
                    let ref = val.image[0].ref // Путь
                    let pathReference = storage.reference(withPath: "\(ref)")
                    
                    let ref2 = val.image[1].ref // Путь
                    let pathReference2 = storage.reference(withPath: "\(ref2)")
                    
                    pathReference.getData(maxSize: megaByte) { data1, error in
                        pathReference2.getData(maxSize: megaByte) { data2, error in
                            if let error = error {
                                print("⚠️ Error getting IMAGE: \(error)")
                            } else {
                                guard
                                    let data1 = data1,
                                    let data2 = data2
                                else {
                                    print("⚠️ Error getting IMAGE: \(error)")
                                    return
                                }
                                let image1 = UIImage(data: data1)
                                let image2 = UIImage(data: data2)
                                completion(val,image1,image2)
                            }
                        }
                    }
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }

    // MARK: - Today
    func getTodayHoroscope(completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        let docRef = firestore.collection("Today-tomor-hrscp")
        
        docRef.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            if let error = error { print("⚠️ Error getting documents: \(error)") }
            
            if let random = documents.randomElement() {
                do {
                    let val = try random.data(as: HoroscopeDefaultModel.self)
                    completion(val)
                } catch {
                    print("⚠️ Error decode documents: \(error)")
                }
            }
        }
    }
    
    // MARK: - Week
    func getWeekHoroscope(completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        let docRef = firestore.collection("Week-hrscp")
        
        docRef.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            if let error = error { print("⚠️ Error getting documents: \(error)") }
            // Random
            if let random = documents.randomElement() {
                do {
                    let val = try random.data(as: HoroscopeDefaultModel.self)
                    completion(val)
                } catch {
                    print("⚠️ Error decode documents: \(error)")
                }
            }
        }
    }
    
    // MARK: - Month
    func getMonthHoroscope(zodiacSign: String, completion: @escaping (MonthModel) -> Void) {
        let docRef = firestore.collection("Month-hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: MonthModel.self)
                    completion(val)
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    // MARK: - Year 2023
    func getYear2023Horoscope(zodiacSign: String, completion: @escaping (Year2023Model) -> Void) {
        let docRef = firestore.collection("2023-hrscp").whereField("yearSign", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: Year2023Model.self)
                    completion(val)
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    // MARK: - Year 2024
    func getYear2024Horoscope(zodiacSign: String, completion: @escaping (Year2024Model) -> Void) {
        let docRef = firestore.collection("2024-hrscp").whereField("yearSign", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: Year2024Model.self)
                    completion(val)
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    
    // MARK: - Year 2024
    func getSignСompatibility(zodiacSign: String, completion: @escaping (CompatibilityHrscpModel) -> Void) {
        let docRef = firestore.collection("Compatibility-hrscp").whereField("signOfUser", isEqualTo: zodiacSign)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: CompatibilityHrscpModel.self)
                    completion(val)
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    func getMoonPhase(moonDay: Int, completion: @escaping (MoonPhaseModel) -> Void) {
        let docRef = firestore.collection("MoonPhase").whereField("moonDay", isEqualTo: moonDay)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("⚠️ NOT get doc"); return }
            //
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: MoonPhaseModel.self)
                    completion(val)
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    
    // MARK: - get Modey Calendar
    // Правка 🔴 июнь
    // можно добавить новый праметр SpecificMonth? ->  if Date().get(.day) == 27 -> SpecificMonth? + 1
    // specificMonth? = nil
    // specificMonth ?? .month
    
    // нет ннужно переписать функцию которая будет возвращать запрос текущий месяц или конкретно указанный
    func getMoneyCalendar(zodiacSign: String, completion: @escaping (MonthCalendarModel) -> Void) {
        
//        var docRef: Query {
//            switch Date().get(.month) {
//            case 1:
//                print("1 Month API")
//                return firestore.collection("January-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 2:
//                print("2 Month API")
//                return firestore.collection("February-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 3:
//                print("3 Month API")
//                return firestore.collection("March-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 4:
//                print("4 Month API")
//                return firestore.collection("April-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 5:
//                print("5 Month API")
//                return firestore.collection("May-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 6:
//                print("6 Month API")
//                return firestore.collection("June-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 7:
//                print("7 Month API")
//                return firestore.collection("July-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 8:
//                print("8 Month API")
//                return firestore.collection("August-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 9:
//                print("9 Month API")
//                return firestore.collection("September-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 10:
//                print("10 Month API")
//                return firestore.collection("October-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 11:
//                print("11 Month API")
//                return firestore.collection("November-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            case 12:
//                print("12 Month API")
//                return firestore.collection("December-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            default:
//                return firestore.collection("January-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
//            }
//        }
        
        func makeDocRef(byMonth: Int) -> Query {
            switch byMonth {
            case 1:
                print("1 Month API")
                return firestore.collection("January-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 2:
                print("2 Month API")
                return firestore.collection("February-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 3:
                print("3 Month API")
                return firestore.collection("March-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 4:
                print("4 Month API")
                return firestore.collection("April-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 5:
                print("5 Month API")
                return firestore.collection("May-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 6:
                print("6 Month API")
                return firestore.collection("June-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 7:
                print("7 Month API")
                return firestore.collection("July-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 8:
                print("8 Month API")
                return firestore.collection("August-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 9:
                print("9 Month API")
                return firestore.collection("September-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 10:
                print("10 Month API")
                return firestore.collection("October-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 11:
                print("11 Month API")
                return firestore.collection("November-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            case 12:
                print("12 Month API")
                return firestore.collection("December-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            default:
                return firestore.collection("January-Hrscp").whereField("monthSigns", isEqualTo: zodiacSign)
            }
        }
        
        // cust: change to next horoscope if day "27"
        if Date().get(.day) >= 27 {
            
        }
        let changeHoroscope
        
        // request
        makeDocRef(byMonth: Date().get(.month)).getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: MonthCalendarModel.self)
                    completion(val)
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    
    

}













