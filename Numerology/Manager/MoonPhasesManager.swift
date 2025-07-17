//
//  MoonPhasesManager.swift
//  Numerology
//
//  Created by Serj_M1Pro on 30.12.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class MoonPhasesManager {
    
    static let shared: MoonPhasesManager = MoonPhasesManager()
    private let firestore = Firestore.firestore()
    
    func getAllMoonPhases(completion: @escaping ([MoonPhaseModel]) -> Void) {
        let collectionRef = firestore.collection("MoonPhase")
        
        collectionRef.getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                myPrint("⚠️ NOT get documents")
                completion([]) // Возвращаем пустой массив в случае ошибки
                return
            }
            
            if let error = error {
                myPrint("⚠️ Error getting documents: \(error)")
                completion([]) // Возвращаем пустой массив в случае ошибки
                return
            }
            
            // Decode all documents into an array
            var moonPhases: [MoonPhaseModel] = []
            for doc in documents {
                do {
                    let moonPhase = try doc.data(as: MoonPhaseModel.self)
                    moonPhases.append(moonPhase)
                } catch {
                    myPrint("⚠️ Error decoding document \(doc.documentID): \(error)")
                }
            }
            completion(moonPhases)
        }
    }
}
