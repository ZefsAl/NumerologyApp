//
//  ChatVM.swift
//  Numerology
//
//  Created by Serj_M1Pro on 16.06.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class StarsManager: ObservableObject {
    
    
    @Published var userBalance: Int = 0
    // test
    @Published var total: Int = 0
    @Published var spent: Int = 0
    
    private let db = Firestore.firestore()
    //
    var userRef: DocumentReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return db.collection("users").document(uid)
    }
    // TODO: - Начисление звезд
    // TODO: - Decrease Stars
    // TODO: - Возврат звезд если пустой ответ или URLSessionTimeOut или ошибка
    
    
    // TODO: - Учесть когда ии не прислал ответ
    // TODO: - decrease stars
    //                        if self.stars != 0 {
    //                            self.stars -= 1
    //                        }
//    init() {
//
//    }
    
    init() {
        self.getBalance()
    }
    

    
    
    func spentStars() {
        print("⚠️ SPENT STARS ⭐️")
        DispatchQueue.main.async(qos: .userInteractive) {
            // v1
            // let db2 = Firestore.firestore()
            // guard let uid = Auth.auth().currentUser?.uid else { return }
            // let ref = db2.collection("users").document(uid)
            // v2
            self.userRef?.setData(["spentTokens": FieldValue.increment(Int64(1))], merge: true)
        }
    }
    
    func setStarsPurchesed(_ productID: String?) {
        guard let productID else { return }
        switch productID {
        case IAP_IDs.stars5:
            self.userRef?.setData(["totalTokens": FieldValue.increment(Int64(5))], merge: true)
        case IAP_IDs.stars15:
            self.userRef?.setData(["totalTokens": FieldValue.increment(Int64(15))], merge: true)
        case IAP_IDs.stars25:
            self.userRef?.setData(["totalTokens": FieldValue.increment(Int64(25))], merge: true)
        default: break
        }
    }
    
    func getBalance() {

//                userRef.setData(["totalPurchased": FieldValue.increment(Int64(100))], merge: true)
        
        // TEST
//                userRef.setData(["totalTokens": 2], merge: true)
//                userRef.setData(["spentTokens": 1], merge: true)
//                userRef.setData(["totalPurchased": 0], merge: true)
        
        DispatchQueue.main.async(qos: .userInteractive) {
            self.userRef?.getDocument { snapshot, error in
                let data = snapshot?.data() ?? [:]
                let total = data["totalTokens"] as? Int ?? 0
                let spent = data["spentTokens"] as? Int ?? 0
                let balance = total - spent
                print("Баланс: \(balance) монет")
                
                self.userBalance = balance
                self.total = total
                self.spent = spent
            }
        }
        
    }
}
