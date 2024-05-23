//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.05.2024.
//

import UIKit

extension UIView {

    enum ViewSide {
        case left, right, top, bottom
    }
    // MARK: - Border for side
    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {
        switch side {
        case .left: 
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
            self.layer.addSublayer(border)
            break
        case .right: 
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
            self.layer.addSublayer(border)
            break
        case .top:
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
            self.layer.addSublayer(border)
            break
        case .bottom: 
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
            self.layer.addSublayer(border)
            break
        }
    }
    
    // MARK: - custom Corner Radius
    func customCornerRadius(viewToRound: UIView, byRoundingCorners: UIRectCorner?, corner: CGFloat) {
        
        let maskLayer = CAShapeLayer()
        maskLayer.name = "CustomCornerRadius"
        
        guard let byRoundingCorners = byRoundingCorners else {
            for item in viewToRound.layer.sublayers! where item.name == "CustomCornerRadius" {
                item.removeFromSuperlayer()
            }
            return
        }
        let path = UIBezierPath(
            roundedRect: viewToRound.bounds,
            byRoundingCorners: byRoundingCorners,
            cornerRadii: CGSize(width: corner, height:  corner)
        )
        maskLayer.path = path.cgPath
        viewToRound.layer.mask = maskLayer
        
    }
//    func removeCustomCornerRadius(rmoveFrom: UIView) {
//        
//        for item in rmoveFrom.layer.sublayers! where item.name == "CustomCornerRadius" {
//            item.removeFromSuperlayer()
////            item.backgroundColor = UIColor.systemOrange.cgColor
//            
//        }
//    }
    
    
    // color Animate Tap
    func colorAnimateTap(selectedColor: UIColor) {
        let bgColor = self.backgroundColor
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
            self.backgroundColor = selectedColor
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0) {
                self.backgroundColor = bgColor
            }
        }
    }
    
}
