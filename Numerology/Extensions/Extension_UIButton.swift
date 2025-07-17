//
//  Extension_UIButton.swift
//  Numerology
//
//  Created by Serj on 24.10.2023.
//

import Foundation
import UIKit

extension UIButton {
    
    @objc func animateAction() {
        TouchSupport.tapDefaultAnimate(view: self)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        TouchSupport.haptic(.soft)
    }
}
