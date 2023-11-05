//
//  Extension_UIColor.swift
//  Numerology
//
//  Created by Serj on 19.09.2023.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: CellColors
    struct CellColors {
        // BG
//        let cellActiveBG: UIColor = UIColor(red: 0.16, green: 0.16, blue: 0.28, alpha: 1)
//        let cellDisableBG: UIColor = UIColor(red: 0.13, green: 0.12, blue: 0.22, alpha: 1) // old
        let cellActiveBG: UIColor = UIColor(red: 0.075, green: 0.075, blue: 0.129, alpha: 1)
        let cellDisableBG: UIColor = UIColor(red: 0.042, green: 0.041, blue: 0.075, alpha: 1)
        
        // Border
//        let cellDisableBorder = UIColor(red: 0.16, green: 0.16, blue: 0.28, alpha: 1) // old
        let cellDisableBorder = UIColor(red: 0.075, green: 0.075, blue: 0.129, alpha: 1)
        let cellActiveBorder = UIColor(red: 0.29, green: 0.29, blue: 0.52, alpha: 1)
        
        // Text
        let disabledText: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        let activeText: UIColor = .white
        
    }
    
    // MARK: CardColors
    struct CardColors {
        // BG
//        let cardDefaultBG: UIColor = UIColor(red: 0.13, green: 0.12, blue: 0.22, alpha: 1) // old
        let cardDefaultBG: UIColor = UIColor(red: 0.042, green: 0.041, blue: 0.075, alpha: 1)
    }
    
    
    
}
