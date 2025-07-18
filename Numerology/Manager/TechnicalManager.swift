//
//  TechnicalManager.swift
//  Numerology
//
//  Created by Serj_M1Pro on 07.08.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import UIKit


final class TechnicalManager {
    
    static let shared: TechnicalManager = TechnicalManager()
    private let db = Firestore.firestore()
    
    func getSpecialOfferShowTime(completion: @escaping (TechnicalModel) -> Void) {
        let docRef = db.collection("Technical").whereField("key", isEqualTo: "SpecialOffer")
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
                    let val = try doc.data(as: TechnicalModel.self)
                    completion(val)
                }
                catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    func getTechnicalImages(withKey: String, completion: @escaping ([String:UIImage?]) -> Void ) {

        let docRef = db.collection("Technical").whereField("key", isEqualTo: withKey)
        // test
        
        docRef.getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                myPrint("⚠️ NOT get doc")
                completion([:]) // Возвращаем пустой массив в случае ошибки
                return
            }

            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
                completion([:]) // Возвращаем пустой массив в случае ошибки
                return
            }
            
            var picArray = [String:UIImage?]()
            let dispatchGroup = DispatchGroup()
            
            for doc in documents {
                
                do {
                    let val = try doc.data(as: TechnicalModel.self)
                    
                    let storage = Storage.storage()
                    let megaByte = Int64(1 * 1024 * 1024)
                    
                    // работает но не по индексу
                    
                    func clearString(_ string: String) -> String {
                        let pattern = "\\.(jpg|png|gif)"
                        let regex = try! NSRegularExpression(pattern: pattern, options: [])

                        let modifiedString = regex.stringByReplacingMatches(
                            in: string,
                            options: [],
                            range: NSRange(location: 0, length: string.utf16.count),
                            withTemplate: "")
                        return modifiedString
                    }
                    
                    let ref = val.val2?.compactMap({(key: clearString($0.name), value: $0.ref)}) // имя, пути

                    let pathReference = ref?.compactMap({ (key: String, value: String) in
                        (key: key, value: storage.reference(withPath: "\(value)"))
                    })
                    
                    
                    pathReference?.forEach({ (key: String, value: StorageReference) in
                        dispatchGroup.enter() // Уведомляем о начале задачи
                        value.getData(maxSize: megaByte) { data, error in
                            defer { dispatchGroup.leave() } // Уведомляем о завершении задачи
                            
                            if let error = error {
                                myPrint("⚠️ Error getting IMAGE: \(error)")
                            } else {
                                guard let data = data else {
                                    myPrint("⚠️ Error getting IMAGE: \(String(describing: error))")
                                    return
                                }
                                picArray.updateValue(UIImage(data: data), forKey: key)
                            }
                        }
                        
                    })
                    
                } catch {
                    myPrint("⚠️ Error when trying to decode book: \(error)")
                }
            }

            // Выполняем completion после завершения всех задач в dispatchGroup
            dispatchGroup.notify(queue: .main) {
                completion(picArray)
            }
        }
    }
    //
}
