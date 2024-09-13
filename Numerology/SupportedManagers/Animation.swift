//
//  Animation.swift
//  Numerology
//
//  Created by Serj_M1Pro on 22.08.2024.
//

import UIKit

class CustomAnimation {
    
    static func setPulseAnimation(
        to view: UIView,
        toValue: CGFloat = 0.95,
        fromValue: CGFloat = 0.79
    ) {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.isRemovedOnCompletion = false
        pulseAnimation.duration = 1
        pulseAnimation.toValue = toValue
        pulseAnimation.fromValue = fromValue
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        view.layer.add(pulseAnimation, forKey: "pulse")
    }
    
}


