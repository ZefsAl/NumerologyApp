//
//  TestRealmUI.swift
//  Numerology
//
//  Created by Serj_M1Pro on 08.05.2025.
//

import SwiftUI
//import RealmSwift

//class Dog: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var name: String
//    @Persisted var age: Int
//}
//
//class DogManager: ObservableObject {
//    
//    @ObservedResults(Dog.self) var dogs
//    
//    func add() {
//        let dog = Dog()
//        dog.name = "Rex"
//        dog.age = 1
//        myPrint("name of dog: \(dog.name)")
//
//        // Get the default Realm
//        let realm = try! Realm()
//        // Persist your data easily with a write transaction
//        try! realm.write {
//            realm.add(dog)
//        }
//    }
//}

//struct TestRealmUI: View {
////    @StateObject var vm = DogManager()
//    @ObservedResults(MessageObj.self) var messages
//    @Environment(\.realm) var realm
//    
//    @State var rm_item: MessageObj? = nil
//    
//    var body: some View {
//        VStack {
//            ScrollView {
//                ForEach(self.messages) { object in
//                    Button {
////                        self.rm_item = object
//                    } label: {
//                        Text(object.content)
//                            .foregroundStyle(.orange)
//                            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
//                            .background(.gray.opacity(0.4))
//                    }
//
//                }
////                .onMove(perform: $dogs.move)
////                .onDelete(perform: $dogs.remove)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//            
//            HStack(spacing: 0) {
//                Button(role: .none) {
//                    self.add()
//                } label: {
//                    Text("Add")
//                        .foregroundStyle(.white)
//                        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
//                        .background(.blue)
//                }
//                Button(role: .none) {
//                    if let rm_item {
////                        myPrint(rm_item._id)
////                        self.remove(object: rm_item)
//                    }
//                    
//                } label: {
//                    Text("Remove")
//                        .foregroundStyle(.white)
//                        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
//                        .background(.red)
//                }
//            }
//
//        }
//    
//    }
//    
//    func add() {
//        let message = MessageObj()
//        message.content = "Some\(Int.random(in: 0...100))"
//
//        // Persist your data easily with a write transaction
//        try! realm.write {
//            realm.add(message)
//        }
//    }
//    
//    func remove(object: Dog) {
//        guard let thawedDog = object.thaw(), let realm = thawedDog.realm else { return }
//        try? realm.write {
//            realm.delete(thawedDog)
//        }
//    }
//    
//    
//    
//}


//#Preview {
//    TestRealmUI()
//}
