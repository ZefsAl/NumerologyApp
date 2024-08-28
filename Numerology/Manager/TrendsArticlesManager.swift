//

//  Numerology
//
//  Created by Serj_M1Pro on 10.06.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift
import Firebase
import UIKit

struct TrendsFieldID {
    // 1 Numerology
    static let numerologyID_1 = "Numerology1";
    static let numerologyID_2 = "Numerology2";
    static let numerologyID_3 = "Numerology3";
    // 2 Astrology
    static let astrologyID_1 = "Astrology1";
    static let astrologyID_2 = "Astrology2";
    static let astrologyID_3 = "Astrology3";
    static let astrologyID_4 = "Astrology4";
    // 3 SymbolsOfLife
    static let symbolsOfLifeID_1 = "SymbolsOfLife1";
    static let symbolsOfLifeID_2 = "SymbolsOfLife2";
    static let symbolsOfLifeID_3 = "SymbolsOfLife3";
    static let symbolsOfLifeID_4 = "SymbolsOfLife4";
    static let symbolsOfLifeID_5 = "SymbolsOfLife5";
    static let symbolsOfLifeID_6 = "SymbolsOfLife6";
    static let symbolsOfLifeID_7 = "SymbolsOfLife7";
    // 4 Chakras
    static let chakrasID_1  = "Chakras1";
    static let chakrasID_2  = "Chakras2";
    static let chakrasID_3  = "Chakras3";
    static let chakrasID_4  = "Chakras4";
    static let chakrasID_5  = "Chakras5";
    static let chakrasID_6  = "Chakras6";
    static let chakrasID_7  = "Chakras7";
    static let chakrasID_8  = "Chakras8";
    static let chakrasID_9  = "Chakras9";
    static let chakrasID_10 = "Chakras10";
    static let chakrasID_11 = "Chakras11";
    static let chakrasID_12 = "Chakras12";
    static let chakrasID_13 = "Chakras13";
    static let chakrasID_14 = "Chakras14";
    static let chakrasID_15 = "Chakras15";
    // 5 Useful
    static let usefulID_1 = "Useful1";
    static let usefulID_2 = "Useful2";
    static let usefulID_3 = "Useful3";
    static let usefulID_4 = "Useful4";
    static let usefulID_5 = "Useful5";
    
}
class TrendsArticlesUserDefaults {

    static func set(likeState: Bool, for articleKey: String) {
        UserDefaults.standard.setValue(likeState, forKey: articleKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getLikeState(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}

final class TrendsArticlesManager {
    
    static let shared: TrendsArticlesManager = TrendsArticlesManager()
    private let firestore = Firestore.firestore()
    
    // MARK: - set Toggle Like
    func setToggleLike(docID: String, bool: Bool) {
        let docRef = firestore.collection("TrendsArticles").document(docID)
        // как проверять что бы случайно не было <0
        if bool {
            docRef.updateData(["likes" : FieldValue.increment(Double(1))])
        } else {
            docRef.updateData(["likes" : FieldValue.increment(Double(-1))])
        }
    }
    
    // MARK: - get Trends Articles
    func getTrendsArticles(articleID: String, completion: @escaping ((TrendsArticlesModel, UIImage?, String) -> Void)) {
        let docRef = firestore.collection("TrendsArticles").whereField("article", isEqualTo: articleID)
        
        
        docRef.getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { print("NOT get doc"); return }
            
            if let error = error {
                print("⚠️ Error getting documents: \(error)")
            }
            
            // Decode
            for doc in documents {
                do {
                    let val = try doc.data(as: TrendsArticlesModel.self)
                    let ref = val.image?.first?.ref // Путь
                    
                    guard let ref = ref else {
                        completion(val, nil, doc.documentID)
                        return
                    }
                        
                    let storage = Storage.storage()
                    let pathReference = storage.reference(withPath: "\(ref)")
                    pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("⚠️ Error getting IMAGE: \(error)")
                        } else {
                            // origin
                            let image = UIImage(data: data!)
                            completion(val, image ?? nil, doc.documentID)
                        }
                    }
                }
                catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        }
    }
    
    /// completion( Model, ID )
    func setLikeListener(articleID: String, completion: @escaping ((TrendsArticlesModel, String) -> Void)) {
        firestore.collection("TrendsArticles").document(articleID)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("🟣⚠️☑️ Document data was empty.")
                    return
                }
                print("✅ Current data: \(data)")

                do {
                    let val = try document.data(as: TrendsArticlesModel.self)
                    print("✅ decoded data: \(val.article)")
                    print("✅ decoded data: \(val.likes)")
                    print("✅ decoded data: \(document.documentID)")
                    completion(val,document.documentID)
                } catch {
                    print("⚠️ Error when trying to decode book: \(error)")
                }
            }
        // https://firebase.google.com/docs/firestore/query-data/listen#swift
    }

}
