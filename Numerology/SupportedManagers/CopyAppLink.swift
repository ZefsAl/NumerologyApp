////
////  CopyAppLink.swift
////  Numerology
////
////  Created by Serj_M1Pro on 23.09.2024.
////
//
//import UIKit
//
//class CopyAppLink: UIActivity {
//    var _activityTitle: String
//    var _activityImage: UIImage?
//    var activityItems = [Any]()
//    var action: ([Any]) -> Void
//    private var url = URL(string: "Nil")
//
//    init(title: String, image: UIImage?, performAction: @escaping ([Any]) -> Void) {
//        _activityTitle = title
//        _activityImage = image
//        action = performAction
//        super.init()
//    }
//
//    override var activityTitle: String? {
//        return _activityTitle
//    }
//
//    override var activityImage: UIImage? {
//        return _activityImage
//    }
//
//    override var activityType: UIActivity.ActivityType? {
//        return UIActivity.ActivityType(rawValue: "com.productHunt.copyLink")
//    }
//
//    override class var activityCategory: UIActivity.Category {
//       return .action
//   }
//
//    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
//        for activityItem in activityItems {
//           if let _ = activityItem as? URL {
//              return true
//           }
//        }
//        return false
//    }
//
//   override func prepare(withActivityItems activityItems: [Any]) {
//       for activityItem in activityItems {
//           if let url = activityItem as? URL {
//               self.url = url
//           }
//       }
//       self.activityItems = activityItems
//   }
//
//   override func perform() {
//    myPrint("URL : \(String(describing: url?.absoluteString))")
//    UIPasteboard.general.string = url?.absoluteString
//    action(activityItems)
//    activityDidFinish(true)
//   }
//}
