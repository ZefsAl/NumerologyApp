//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.05.2024.
//

import UIKit

enum ViewSide {
    case left, right, top, bottom
}

extension UIView {
    // MARK: - Border for side
    func addBorder(toView: UIView, toSide side: ViewSide?, withColor color: UIColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.name = "BorderCALayerKey"
        
        guard let side = side else {
            return
        }
        
        switch side {
        case .left:
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
            toView.layer.addSublayer(border)
            break
        case .right:
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
            toView.layer.addSublayer(border)
            break
        case .top:
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
            toView.layer.addSublayer(border)
            break
        case .bottom:
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
            toView.layer.addSublayer(border)
            break
        }
        
    }
    func removeCALayerByName(fromView: UIView, name: String) {
        for item in fromView.layer.sublayers! where item.name == name {
            item.removeFromSuperlayer()
        }
    }
    
    // MARK: - custom Corner Radius
    func customCornerRadius(viewToRound: UIView, byRoundingCorners: UIRectCorner?, cornerValue: CGFloat?) {
        
        let maskLayer = CAShapeLayer()
        maskLayer.name = "CustomCornerRadius"
        
        guard 
            let byRoundingCorners = byRoundingCorners,
            let corner = cornerValue
        else {
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
    
    
    // MARK: - color Animate Tap
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
    
    func addSystemBlur(to view: UIView, style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
//        view.layer.addSublayer(blurEffectView)
    }
    
    
    
}
