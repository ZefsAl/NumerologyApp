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

//HoroscopeManager


class HoroscopeManager {
    
    static let shared: HoroscopeManager = HoroscopeManager()
    private let db = Firestore.firestore()
    
    // MARK: - Signs
    func getSigns(zodiacSigns: String, completion: @escaping ((SignsModel, UIImage?, UIImage? ) -> Void) ) {
        let docRef = db.collection("Signs").whereField("zodiacSigns", isEqualTo: zodiacSigns)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("Error getting documents: \(error)")
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
                                print("Error getting IMAGE: \(error)")
                            } else {
                                let image1 = UIImage(data: data1!)
                                let image2 = UIImage(data: data2!)
                                completion(val,image1,image2)
                            }
                        }
                    }
                }
                catch {
                    print("Error when trying to decode book: \(error)")
                }
            }
        }
    }

    // MARK: - Today
    func getTodayHoroscope(completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        let docRef = db.collection("Today-tomor-hrscp")
        
        docRef.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            if let error = error { print("Error getting documents: \(error)") }
            
            if let random = documents.randomElement() {
                do {
                    let val = try random.data(as: HoroscopeDefaultModel.self)
                    completion(val)
                } catch {
                    print("Error decode documents: \(error)")
                }
            }
        }
    }
    
    // MARK: - Week
    func getWeekHoroscope(completion: @escaping (HoroscopeDefaultModel) -> Void ) {
        let docRef = db.collection("Week-hrscp")
        
        docRef.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            if let error = error { print("Error getting documents: \(error)") }
            // Random
            if let random = documents.randomElement() {
                do {
                    let val = try random.data(as: HoroscopeDefaultModel.self)
                    completion(val)
                } catch {
                    print("Error decode documents: \(error)")
                }
            }
        }
    }
    
    // MARK: - Month
    func getMonthHoroscope(zodiacSigns: String, completion: @escaping (MonthModel) -> Void) {
        let docRef = db.collection("Month-hrscp").whereField("monthSigns", isEqualTo: zodiacSigns)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: MonthModel.self)
                    completion(val)
                }
                catch {
                    print("Error when trying to decode book: \(error)")
                }
            }
        }
    }
    // MARK: - Year 2023
    func getYear2023Horoscope(zodiacSigns: String, completion: @escaping (Year2023Model) -> Void) {
        let docRef = db.collection("2023-hrscp").whereField("yearSign", isEqualTo: zodiacSigns)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: Year2023Model.self)
                    completion(val)
                }
                catch {
                    print("Error when trying to decode book: \(error)")
                }
            }
        }
    }
    // MARK: - Year 2024
    func getYear2024Horoscope(zodiacSigns: String, completion: @escaping (Year2024Model) -> Void) {
        let docRef = db.collection("2024-hrscp").whereField("yearSign", isEqualTo: zodiacSigns)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: Year2024Model.self)
                    completion(val)
                }
                catch {
                    print("Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    
    // MARK: - Year 2024
    func getSignСompatibility(signOfUser: String, completion: @escaping (CompatibilityHrscpModel) -> Void) {
        let docRef = db.collection("Compatibility-hrscp").whereField("signOfUser", isEqualTo: signOfUser)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            //
            if let error = error {
                print("Error getting documents: \(error)")
            }
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: CompatibilityHrscpModel.self)
                    completion(val)
                }
                catch {
                    print("Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    func getMoonPhase(currentDay: Int, completion: @escaping (MoonPhaseModel) -> Void) {
        let docRef = db.collection("MoonPhase").whereField("moonDay", isEqualTo: currentDay)
        //
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("⚠️ NOT get doc"); return }
            //
            if let error = error {
                print("Error getting documents: \(error)")
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
    
    

}













