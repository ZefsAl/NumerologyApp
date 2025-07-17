//
//  SelectExpertView_Ext.swift
//  Numerology
//
//  Created by Serj_M1Pro on 01.07.2025.
//

import SwiftUI

extension SelectExpertView {
    func getAdaptive_ExpertCardSize() -> CGSize {
        switch DeviceMenager.device {
        case .iPhone_Se2_3Gen_8_7_6S: CGSize(width: 300, height: 340)
        case .iPhone8Plus_7Plus_6Plus: CGSize(width: 300, height: 440)
        case .iPhone_Mini_12_13: CGSize(width: 300, height: 440)
        case .iPhone_X_XS_11Pro: CGSize(width: 300, height: 440)
        case .iPhone_XR_11: CGSize(width: 300, height: 440)
        case .iPhone_12_13_14: CGSize(width: 300, height: 440)
        case .iPhone_XSMax_11ProMax: CGSize(width: 300, height: 440)
        case .iPhone_12ProMax_13ProMax: CGSize(width: 300, height: 440)
        case .iPhone_15_15Pro_16: CGSize(width: 300, height: 440)
        case .iPhone_16Pro: CGSize(width: 300, height: 440)
        case .iPhone_16ProMax: CGSize(width: 300, height: 440)
        case .iPhone_15Plus_15ProMax_16Plus: CGSize(width: 300, height: 440)
        case .iPads_12_9: CGSize(width: 300, height: 440)
        case .iPads_11_10_9: CGSize(width: 300, height: 440)
        case .iPads10_5: CGSize(width: 300, height: 440)
        case .iPads9_7_mini7_9: CGSize(width: 300, height: 440)
        case .unknown: CGSize(width: 300, height: 440)
        }
    }
            
    func adaptive_ExpertCardSize_contaiter()  -> CGFloat {
        return DeviceMenager.isSmallDevice ? 35 : 50
    }
    
    // Buttons
    func adaptive_BigButton_cornerRadius() -> CGFloat {
        return DeviceMenager.isSmallDevice ? DS.midCornerRadius_20 : DS.maxCornerRadius
    }
    func adaptive_BigButton_Height() -> CGFloat {
        return DeviceMenager.isSmallDevice ? 50 : 60
    }
    // Font
    func font_adaptive_ReadAboutSignIn() -> UIFont? {
        return DeviceMenager.isSmallDevice ? DS.SourceSerifProFont.title_h6_SB : DS.SourceSerifProFont.title_h4_SB
    }
    
}
