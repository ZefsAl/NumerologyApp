//

//  Numerology
//
//  Created by Serj_M1Pro on 17.06.2024.
//

import UIKit

extension UICollectionViewCell {
    // Animate
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        self.tapAnimateBegan()
        TouchSupport.tapDefaultAnimate(view: self)
        TouchSupport.hapticImpact(style: .soft)
    }
//    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        self.tapAnimateEnded()
//    }
    
    // MARK: - Button
    func tapAnimateBegan() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            }
        }
    }
    
    func tapAnimateEnded() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
