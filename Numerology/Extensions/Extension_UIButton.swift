//
//  Extension_UIButton.swift
//  Numerology
//
//  Created by Serj on 24.10.2023.
//

import Foundation
import UIKit

extension UIButton {
    func bounceAnimate() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.transform = CGAffineTransform.identity
                }
            })
        }
    }
}
