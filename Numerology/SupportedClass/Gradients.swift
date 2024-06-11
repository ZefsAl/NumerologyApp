//
//  Extension_UIView.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import Foundation
import UIKit

enum Direction {
    case topToBottom, bottomToTop
}

class GradientView: UIView {
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(viewHeight: CGFloat, gradientDirection: Direction) {
        self.init()
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
//            Gradients().setBlackGradient(forView: self, direction: gradientDirection)
        self.setGradientBackground(direction: gradientDirection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGradientBackground(direction: Direction) {
        let colorOne = #colorLiteral(red: 0.2235294118, green: 0.2705882353, blue: 0.4156862745, alpha: 1)
        let colorTwo = #colorLiteral(red: 0.137254902, green: 0.1803921569, blue: 0.3019607843, alpha: 1)
        let gradientlayer = CAGradientLayer()
        gradientlayer.name = "GradientLayerKey"
        gradientlayer.frame = self.bounds
        gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientlayer.locations = [0, 1]
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        self.view.layer.insertSublayer(gradientlayer, at: 0)
        self.layer.insertSublayer(gradientlayer, at: 0)
//        toView.layer.insertSublayer(gradientlayer, at: 0)
    }
}

class Gradients {
    
    enum Position {
        case top, bottom
    }
    
    func setBlackGradient(forView: UIView, height: CGFloat, framePosition: Position) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        let color1 = UIColor.black.cgColor
        let color2 = UIColor.clear.cgColor
        
        gradient.colors = [
            color1,
            color2,
        ]
        gradient.locations = [0, 1]
        
        switch framePosition {
        case .top:
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: forView.frame.size.width, height: height)
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0) // vertical gradient start
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0) // vertical gradient end
        case .bottom:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0) // vertical gradient start
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0) // vertical gradient end
            gradient.frame = CGRect(x: 0.0, y: forView.frame.height-height, width: forView.frame.size.width, height: height)
        }
        
        forView.layer.addSublayer(gradient)
    }
    
    
    func gradient(frame: CGRect) -> CAGradientLayer {
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
