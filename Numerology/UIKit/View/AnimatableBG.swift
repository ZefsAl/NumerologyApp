//
//  AnimatableBGView.swift
//  Numerology
//
//  Created by Serj on 20.10.2023.
//

import UIKit

class AnimatableBG {

    
    private let background = UIImage(named: "StarsBG")
    private var imageView: UIImageView = UIImageView()
    private var timer = Timer()
    
    // MARK: setBackground
    func setBackground(vc: UIViewController) {
        self.imageView.frame = vc.view.bounds
        self.imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.image = background
        self.imageView.center = vc.view.center
        self.imageView.alpha = 1
        vc.view.addSubview(self.imageView)
//        vc.view.sendSubviewToBack(self.imageView)
        
        self.timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
     
//    Animate
    @objc private func animate() {
        if self.imageView.alpha == 1 {
            UIView.animate(withDuration: 4, delay: 0, options: .curveEaseInOut) {
                self.imageView.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 4, delay: 0, options: .curveEaseInOut) {
                self.imageView.alpha = 1
            }
        }
    }
    
}
