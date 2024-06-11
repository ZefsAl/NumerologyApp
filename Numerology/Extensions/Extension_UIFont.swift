//
//  Extension_UIFont.swift
//  Numerology
//
//  Created by Serj on 19.09.2023.
//

import Foundation
import UIKit

extension UIFont {
    
    enum SourceSerifPro: String {
        
        case bold
        case semiBold
        case regular
        case light
        
        
        fileprivate var fontName: String {
            return "SourceSerifPro-\(self.rawValue.capitalized)"
        }
    }
    
    convenience init(weight: SourceSerifPro, size: CGFloat) {
        self.init(name: weight.fontName, size: size)!
    }
    
    static func setSourceSerifPro(weight: SourceSerifPro, size: CGFloat) -> UIFont? {
        UIFont(name: "SourceSerifPro-\(weight.rawValue.capitalized)", size: size)
    }
    
    // MARK: - Cinzel
    public static func setCinzelRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Cinzel-Regular", size: size)
    }
    
}
