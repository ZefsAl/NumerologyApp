//

//  Numerology
//
//  Created by Serj_M1Pro on 17.06.2024.
//

import UIKit

class TouchSupport {
    static func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    
    static func tapDefaultAnimate(view: UIView) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    view.transform = CGAffineTransform.identity
                }
            })
        }
    }
    
}

