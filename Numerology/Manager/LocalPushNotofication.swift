//
//  LocalPushNotofication.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.12.2024.
//

import UIKit
import UserNotifications
import FirebaseCore
import FirebaseFirestore

class LocalPushNotofication {
    
    private let firestore = Firestore.firestore()
    
    func getAllPushMessages() async -> [PushMessagesModel] {
        
        let collectionRef = firestore.collection("PushMessages")
        
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                collectionRef.getDocuments { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("⚠️ NOT get documents - getAllPushMessages")
                        // Возвращаем пустой массив в случае ошибки
                        continuation.resume(returning: [])
                        return
                    }
                    
                    if let error = error {
                        print("⚠️ Error getting documents: \(error)")
                        // Возвращаем пустой массив в случае ошибки
                        continuation.resume(returning: [])
                        return
                    }
                    
                    // Decode all documents into an array
                    var messages: [PushMessagesModel] = []
                    for doc in documents {
                        do {
                            let message = try doc.data(as: PushMessagesModel.self)
                            messages.append(message)
                        } catch {
                            print("⚠️ Error decoding document \(doc.documentID): \(error)")
                        }
                    }
                    continuation.resume(returning: messages)
                }
            }
        }
    }
    
    // MARK: - setup Daily Push
    func setupDailyPush() {
        Task {
            async let model = await self.getAllPushMessages()
            let pushMessages = await model
//            print("✅ getAllPushMessages: ", pushMessages)

            let _: UNUserNotificationCenter = {
                let nc = UNUserNotificationCenter.current()
                nc.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        self.scheduleDailyNotifications(messages: pushMessages)
                    }
                }
                return nc
            }()
        }
    }
    
    // MARK: - schedule Daily Notifications
    private func scheduleDailyNotifications(messages: [PushMessagesModel]) {
        guard !messages.isEmpty else {
            UserDefaults.standard.set(false, forKey: "SetupDailyPush_Key")
            print("⚠️ scheduleDailyNotifications - messages.isEmpty")
            return
        }
        UserDefaults.standard.set(true, forKey: "SetupDailyPush_Key")
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // Удаляем предыдущие запросы
        
        var monthMessages: [String] = []
            
        for _ in 1...3 {
            messages.shuffled().forEach { val in
                monthMessages.append(val.message)
            }
        }
        print("✅ monthMessages: ", monthMessages)
        
        for (index, message) in monthMessages.enumerated() {
            let content = UNMutableNotificationContent()
//            content.title = "Ежедневное уведомление"
            content.body = message
            content.sound = .default

            // Настраиваем дату и время уведомления
            var dateComponents = DateComponents()
            dateComponents.hour = 21
            dateComponents.minute = 50
            dateComponents.day = Calendar.current.component(.day, from: Date()) + index // Specific day if remove will be daily

            // Создаем триггер на основе даты
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // repeats: true daily

            // Создаем запрос
            let request = UNNotificationRequest(
                identifier: "daily_notification_\(index)",
                content: content,
                trigger: trigger
            )

            // Добавляем запрос
            center.add(request) { error in
                if let error = error {
                    print("Ошибка при добавлении уведомления: \(error)")
                }
            }
        }
    }
}
