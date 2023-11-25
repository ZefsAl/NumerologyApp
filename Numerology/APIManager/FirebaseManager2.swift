//
//  FirebaseManager2.swift
//  Numerology
//
//  Created by Serj on 09.11.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift
import UIKit

//class FirebaseManager2 {
//    
//    static let shared: FirebaseManager2 = FirebaseManager2()
//    // 1 Config
//    private let db = Firestore.firestore()
//    
//    // MARK: Get Board Of Day //  0
//    func getBoardOfDay(completion: @escaping (BoardOfDayModel) -> Void ) {
//        let docRef = db.collection("BoardOfDay")
//        
//        docRef.getDocuments { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            if let error = error { print("Error getting documents: \(error)") }
//            
//            if let random = documents.randomElement() {
//                
//                do {
//                    let val = try random.data(as: BoardOfDayModel.self)
//                    completion(val)
//                } catch {
//                    print("Error decode documents: \(error)")
//                }
//            }
//        }
//    }
//    
//    // MARK: Get Numbers Of Soul // 1
//    func getNumbersOfSoul(number: Int, completion: @escaping ((NumbersOfSoulModel, UIImage?) -> Void) ) {
//        let docRef = db.collection("NumbersOfSoul").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: NumbersOfSoulModel.self)
//                    //                   completion(val, nil)
//                    let ref = val.image[0].ref // Путь
//                    
//                    let storage = Storage.storage()
//                    let pathReference = storage.reference(withPath: "\(ref)")
//                    pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if let error = error {
//                            print("Error getting IMAGE: \(error)")
//                        } else {
//                            let image = UIImage(data: data!)
//                            completion(val,image)
//                        }
//                    }
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    // MARK: Get Numbers Of Destiny // 2
//    func getNumbersOfDestiny(number: Int, completion: @escaping ((NumbersOfDestinyModel, UIImage?) -> Void) ) {
//        let docRef = db.collection("NumbersOfDestiny").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: NumbersOfDestinyModel.self)
//
//                    let ref = val.image[0].ref // Путь
//                    
//                    let storage = Storage.storage()
//                    let pathReference = storage.reference(withPath: "\(ref)")
//                    pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if let error = error {
//                            print("Error getting IMAGE: \(error)")
//                        } else {
//                            let image = UIImage(data: data!)
//                            completion(val,image)
//                        }
//                    }
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    
//    // MARK: Get Numbers Of Name // 3
//    func getNumbersOfName(number: Int, completion: @escaping ((NumbersOfNameModel, UIImage?) -> Void) ) {
//        let docRef = db.collection("NumbersOfName").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: NumbersOfNameModel.self)
//                    let ref = val.image[0].ref // Путь
//                    
//                    let storage = Storage.storage()
//                    let pathReference = storage.reference(withPath: "\(ref)")
//                    pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if let error = error {
//                            print("Error getting IMAGE: \(error)")
//                        } else {
//                            let image = UIImage(data: data!)
//                            completion(val,image)
//                        }
//                    }
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    // MARK: Get Numbers Of Money // 4
//    func getNumbersOfMoney(number: Int, completion: @escaping ((NumbersOfMoneyModel, UIImage?) -> Void) ) {
//        let docRef = db.collection("NumbersOfMoney").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: NumbersOfMoneyModel.self)
//                    let ref = val.image[0].ref // Путь
//                    
//                    let storage = Storage.storage()
//                    let pathReference = storage.reference(withPath: "\(ref)")
//                    pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if let error = error {
//                            print("Error getting IMAGE: \(error)")
//                        } else {
//                            let image = UIImage(data: data!)
//                            completion(val,image)
//                        }
//                    }
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    
//    // MARK: Get Power Code // 5
//    func getPowerCode(number: Int, completion: @escaping ((PowerCodeModel, UIImage?) -> Void) ) {
//        let docRef = db.collection("PowerCode").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: PowerCodeModel.self)
//                    let ref = val.image[0].ref // Путь
//                    
//                    let storage = Storage.storage()
//                    let pathReference = storage.reference(withPath: "\(ref)")
//                    pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if let error = error {
//                            print("Error getting IMAGE: \(error)")
//                        } else {
//                            let image = UIImage(data: data!)
//                            completion(val,image)
//                        }
//                    }
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    
//    // MARK: Get Personal Day //  2.1
//    func getPersonalDay(number: Int, completion: @escaping (PersonalDayModel) -> Void ) {
//        let docRef = db.collection("PersonalDay").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: PersonalDayModel.self)
//                    completion(val)
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    
//    // MARK: Get Personal Month //  2.2
//    func getPersonalMonth(number: Int, completion: @escaping (PersonalMonthModel) -> Void ) {
//        let docRef = db.collection("PersonalMonth").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: PersonalMonthModel.self)
//                    completion(val)
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    // MARK: Get Personal Year //  2.3
//    func getPersonalYear(number: Int, completion: @escaping (PersonalYearModel) -> Void ) {
//        let docRef = db.collection("PersonalYear").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: PersonalYearModel.self)
//                    completion(val)
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    // MARK: Get LifeStages //  2.4
//    func getLifeStages(number: Int, completion: @escaping (LifeStagesModel) -> Void ) {
//        let docRef = db.collection("LifeStages").whereField("number", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: LifeStagesModel.self)
//                    completion(val)
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    // MARK: Get Compatibility //  3.0
//    func getCompatibility(number: Int, completion: @escaping (CompatibilityModel) -> Void ) {
//        let docRef = db.collection("Compatibility").whereField("numberOfUser", isEqualTo: number)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//            
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: CompatibilityModel.self)
//                    completion(val)
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//    
//    // MARK: Get NumerologyIs //  4.0
//    func getNumerologyIs(completion: @escaping ([NumerologyIsModel]) -> Void ) {
//        let docRef = db.collection("NumerologyIs")
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            
//            var newArr: [NumerologyIsModel] = [NumerologyIsModel]()
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: NumerologyIsModel.self)
//                    newArr.append(val)
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//            
//            completion(newArr)
//        }
//    }
//
//
//    // MARK: get Information Documents
//    func getInformationDocuments(byName: String, completion: @escaping (InfoDocModel) -> Void ) {
//        let docRef = db.collection(byName)
//        
//        docRef.getDocuments() { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
//
//            if let error = error {
//                print("Error getting documents: \(error)")
//            }
//            // Decode
//            for doc in documents {
//                do {
//                    let val = try doc.data(as: InfoDocModel.self)
//                    completion(val)
//                }
//                catch {
//                    print("Error when trying to decode book: \(error)")
//                }
//            }
//        }
//    }
//
//}













