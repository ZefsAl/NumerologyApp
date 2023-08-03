//
//  Extension_UIView.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import Foundation
import UIKit

class Gradients {
 
    func setBlackGradient(forView: UIView) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
//        clipsToBounds = true
        forView.clipsToBounds = true
        
        gradient.colors = [
        UIColor(red: 0.292, green: 0.139, blue: 0.139, alpha: 0).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0) // vertical gradient start
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0) // vertical gradient end
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: forView.frame.size.width, height: forView.frame.size.height)
        gradient.cornerRadius = 15

        forView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame

        layer.colors = [
        UIColor(red: 0.292, green: 0.139, blue: 0.139, alpha: 0).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0) // vertical gradient start
        layer.endPoint = CGPoint(x: 0.5, y: 1.0) // vertical gradient end
        layer.frame = CGRect(x: 0.0, y: 0.0, width: layer.frame.size.width, height: layer.frame.size.height)
        layer.cornerRadius = 15
        
        return layer
    }
    
}
