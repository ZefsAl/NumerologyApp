//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 31.05.2024.
//

import Foundation
import UIKit

class DeviceMenager {
    
    // - MARK: Properties
    static let shared = DeviceMenager()
    
    lazy var device: Device = {
        switch UIScreen.main.nativeBounds.height {
        // Iphones
        case 1334:
            print("📱 iPhone_Se2_3Gen_8_7_6S")
            return .iPhone_Se2_3Gen_8_7_6S
        case 2208:
            print("📱 iPhone8Plus_7Plus_6Plus")
            return .iPhone8Plus_7Plus_6Plus
        case 2340:
            print("📱 iPhone_Mini_12_13")
            return .iPhone_Mini_12_13
        case 2436:
            print("📱 iPhone_X_XS_11Pro")
            return .iPhone_X_XS_11Pro
        case 1792:
            print("📱 iPhone_XR_11")
            return .iPhone_XR_11
        case 2532:
            print("📱 iPhone_12_13_12Pro_13Pro")
            return .iPhone_12_13_12Pro_13Pro
        case 2688:
            print("📱 iPhone_XSMax_11ProMax")
            return .iPhone_XSMax_11ProMax
        case 2778:
            print("📱 iPhone_12ProMax_13ProMax")
            return .iPhone_12ProMax_13ProMax
            // iPads
        case 2732:
            print("📱 iPads_12_9")
            return .iPads_12_9
        case 2360, 2388:
            print("📱 iPads_11_10_9")
            return .iPads_11_10_9
        case 2224:
            print("📱 iPads10_5")
            return .iPads10_5
        case 2048, 2266, 2160:
            return .iPads9_7_mini7_9
        default:
            print("📱 unknown")
            return .unknown
            
        }
    }()
    
    
    enum Device {
        // Iphones
        case iPhone_Se2_3Gen_8_7_6S
        case iPhone8Plus_7Plus_6Plus
        case iPhone_Mini_12_13
        case iPhone_X_XS_11Pro
        case iPhone_XR_11
        case iPhone_12_13_12Pro_13Pro
        case iPhone_XSMax_11ProMax
        case iPhone_12ProMax_13ProMax
        // iPads
        case iPads_12_9
        case iPads_11_10_9
        case iPads10_5
        case iPads9_7_mini7_9
        
        case unknown
    }
    
    
}

