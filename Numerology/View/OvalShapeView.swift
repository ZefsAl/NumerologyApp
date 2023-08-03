//
//  UIView.swift
//  Numerology
//
//  Created by Serj on 19.07.2023.
//

import UIKit

class OvalShapeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let bezierPath = UIBezierPath(ovalIn:CGRect(x: -self.frame.size.width / 2.5,y: -24,width: 700, height: 200))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath;
        UIColor.black.withAlphaComponent(0.7).setFill()
        bezierPath.fill()
        
        
        // Gradient
//        let gradientBounds = CGRectMake(
//            bezierPath.bounds.origin.x    - shapeLayer.lineWidth,
//            bezierPath.bounds.origin.y    - shapeLayer.lineWidth,
//            bezierPath.bounds.size.width  + shapeLayer.lineWidth * 2.0,
//            bezierPath.bounds.size.height + shapeLayer.lineWidth * 2.0)
        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame  = gradientBounds;
//        gradientLayer.bounds = gradientBounds;
//        gradientLayer.colors = [
//            UIColor(red: 0.292, green: 0.139, blue: 0.139, alpha: 0).cgColor,
//            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
//        ]
////        gradientLayer.mask = shapeLayer;
//        self.layer.addSublayer(gradientLayer)
    }
    
}
