//

//  Numerology
//
//  Created by Serj_M1Pro on 31.05.2024.
//

import Foundation
import UIKit

class DeviceMenager {
    
    // - MARK: Properties
    static let shared = DeviceMenager()
    
    static let isSmallDevice = DeviceMenager.device == .iPhone_Se2_3Gen_8_7_6S
    
    // v1
//    static let device: Device = {
//        switch UIScreen.main.nativeBounds.height {
//        // Iphones
//        case 1334:
//            myPrint("📱 iPhone_Se2_3Gen_8_7_6S")
//            return .iPhone_Se2_3Gen_8_7_6S
//        case 2208:
//            myPrint("📱 iPhone8Plus_7Plus_6Plus")
//            return .iPhone8Plus_7Plus_6Plus
//        case 2340:
//            myPrint("📱 iPhone_Mini_12_13")
//            return .iPhone_Mini_12_13
//        case 2436:
//            myPrint("📱 iPhone_X_XS_11Pro")
//            return .iPhone_X_XS_11Pro
//        case 1792:
//            myPrint("📱 iPhone_XR_11")
//            return .iPhone_XR_11
//        case 2532:
//            myPrint("📱 iPhone_12_13_12Pro_13Pro")
//            return .iPhone_12_13_12Pro_13Pro
//        case 2688:
//            myPrint("📱 iPhone_XSMax_11ProMax")
//            return .iPhone_XSMax_11ProMax
//        case 2778:
//            myPrint("📱 iPhone_12ProMax_13ProMax")
//            return .iPhone_12ProMax_13ProMax
//            // iPads
//        case 2732:
//            myPrint("📱 iPads_12_9")
//            return .iPads_12_9
//        case 2360, 2388:
//            myPrint("📱 iPads_11_10_9")
//            return .iPads_11_10_9
//        case 2224:
//            myPrint("📱 iPads10_5")
//            return .iPads10_5
//        case 2048, 2266, 2160:
//            return .iPads9_7_mini7_9
//        default:
//            myPrint("📱 unknown")
//            return .unknown
//            
//        }
//    }()
    
//    enum Device {
//        // Iphones
//        case iPhone_Se2_3Gen_8_7_6S
//        case iPhone8Plus_7Plus_6Plus
//        case iPhone_Mini_12_13
//        case iPhone_X_XS_11Pro
//        case iPhone_XR_11
//        case iPhone_12_13_12Pro_13Pro
//        case iPhone_XSMax_11ProMax
//        case iPhone_12ProMax_13ProMax
//        // iPads
//        case iPads_12_9
//        case iPads_11_10_9
//        case iPads10_5
//        case iPads9_7_mini7_9
//        
//        case unknown
//    }
    
    // v2
    enum Device {
        case iPhone_Se2_3Gen_8_7_6S
        case iPhone8Plus_7Plus_6Plus
        case iPhone_Mini_12_13
        case iPhone_X_XS_11Pro
        case iPhone_XR_11
        case iPhone_12_13_14
        case iPhone_XSMax_11ProMax
        case iPhone_12ProMax_13ProMax
        case iPhone_15_15Pro_16
        case iPhone_16Pro
        case iPhone_16ProMax
        case iPhone_15Plus_15ProMax_16Plus // 1290×2796
        // iPad
        case iPads_12_9
        case iPads_11_10_9
        case iPads10_5
        case iPads9_7_mini7_9
        case unknown
    }

    static let device: Device = {
        let h = UIScreen.main.nativeBounds.height

        switch h {
        // MARK: – iPhone SE, 8, 7, 6s …
        case 1334:
            myPrint("📱 iPhone_Se2_3Gen_8_7_6S")
            return .iPhone_Se2_3Gen_8_7_6S                      // 750×1334 :contentReference[oaicite:0]{index=0}
        case 2208:
            myPrint("📱 iPhone8Plus_7Plus_6Plus")
            return .iPhone8Plus_7Plus_6Plus                     // 1242×2208 :contentReference[oaicite:1]{index=1}
        // MARK: – Mini (12, 13, 14)
        case 2340:
            myPrint("📱 iPhone_Mini_12_13")
            return .iPhone_Mini_12_13                          // 1080×2340 :contentReference[oaicite:2]{index=2}
        // MARK: – X, XS, 11 Pro
        case 2436:
            myPrint("📱 iPhone_X_XS_11Pro")
            return .iPhone_X_XS_11Pro                          // 1125×2436 :contentReference[oaicite:3]{index=3}
        // MARK: – XR, 11
        case 1792:
            myPrint("📱 iPhone_XR_11")
            return .iPhone_XR_11                               // 828×1792 :contentReference[oaicite:4]{index=4}
        // MARK: – iPhone 12, 13, 14 non-Pro
        case 2532:
            myPrint("📱 iPhone_12_13_14")
            return .iPhone_12_13_14                            // 1170×2532 :contentReference[oaicite:5]{index=5}
        // MARK: – XS Max, 11 Pro Max
        case 2688:
            myPrint("📱 iPhone_XSMax_11ProMax")
            return .iPhone_XSMax_11ProMax                      // 1242×2688 :contentReference[oaicite:6]{index=6}
        // MARK: – 12 Pro Max, 13 Pro Max
        case 2778:
            myPrint("📱 iPhone_12ProMax_13ProMax")
            return .iPhone_12ProMax_13ProMax                   // 1284×2778 :contentReference[oaicite:7]{index=7}
        // MARK: – 15, 15 Pro, 16
        case 2556:
            myPrint("📱 iPhone_15_15Pro_16")
            return .iPhone_15_15Pro_16                         // 1179×2556 :contentReference[oaicite:8]{index=8}
        // MARK: – 16 Pro
        case 2622:
            myPrint("📱 iPhone_16Pro")
            return .iPhone_16Pro                               // 1206×2622 :contentReference[oaicite:9]{index=9}
        // MARK: – 15 Plus, 15 Pro Max, 16 Plus, 16 Pro Max
        case 2796:
            myPrint("📱 iPhone_15Plus_15ProMax_16Plus")
            return .iPhone_15Plus_15ProMax_16Plus     // 1290×2796 :contentReference[oaicite:10]{index=10}
            // MARK: – 16 Pro Max
        case 2868:
            myPrint("📱 iPhone_16ProMax")
            return .iPhone_16ProMax
        // MARK: – iPad
        case 2732:
            myPrint("📱 iPads_12_9")
            return .iPads_12_9                                 // 2048×2732 :contentReference[oaicite:11]{index=11}
        case 2360, 2388:
            myPrint("📱 iPads_11_10_9")
            return .iPads_11_10_9                              // 1640×2360, 1668×2388 :contentReference[oaicite:12]{index=12}
        case 2224:
            myPrint("📱 iPads10_5")
            return .iPads10_5                                  // 1668×2224 :contentReference[oaicite:13]{index=13}
        case 2048, 2266, 2160:
            myPrint("📱 iPads9_7_mini7_9")
            return .iPads9_7_mini7_9                          // 1536×2048, 1640×2266, 1440×2160 :contentReference[oaicite:14]{index=14}

        default:
            return .unknown
        }
    }()
    
}

