//

//  Numerology
//
//  Created by Serj_M1Pro on 08.05.2024.
//

import UIKit
import SwiftUI

extension UIFont {
    func asCTFont() -> Font {
        Font((self) as CTFont)
    }
}

// Design System
struct DS {
    
    // MARK: - 🌕 Static Values
    static let borderWidth: CGFloat = 1
    // Radius
    static let maxCornerRadius: CGFloat = 24
    static let midCornerRadius_20: CGFloat = 20
    static let minCornerRadius_16: CGFloat = 16
    
    
    enum ChipsButton {
        static let title = UIFont.setSourceSerifPro(weight: .semiBold, size: 14)
    }
    
    enum BadgeColor {
        static let transparent: UIColor = UIColor.white.withAlphaComponent(0.5)
        static let white: UIColor = .white
    }
    let color = #colorLiteral(red: 0.3137254902, green: 0.3019607843, blue: 0.3490196078, alpha: 1)
    
    enum SourceSerifProFont {
        
        static let title_h4_SB = UIFont.setSourceSerifPro(weight: .semiBold, size: 17)
        static let title_h5_SB = UIFont.setSourceSerifPro(weight: .semiBold, size: 15)
        static let title_h6_SB = UIFont.setSourceSerifPro(weight: .semiBold, size: DeviceMenager.isSmallDevice ? 12 : 13)
        
        static let title_h1 = UIFont.setSourceSerifPro(weight: .regular, size: 26)
        static let title_h2 = UIFont.setSourceSerifPro(weight: .regular, size: 24)
        static let title_h3 = UIFont.setSourceSerifPro(weight: .regular, size: 20)
        static let title_h4 = UIFont.setSourceSerifPro(weight: .regular, size: 17)
        static let title_h5 = UIFont.setSourceSerifPro(weight: .regular, size: 15)
        static let title_h6 = UIFont.setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 12 : 13)
        
        //
        
        static let subtitle = UIFont.setSourceSerifPro(weight: .light, size: 15)
        static let footnote_Sb_13 = UIFont.setSourceSerifPro(weight: .regular, size: 13)
        static let caption2_Sb_11 = UIFont.setSourceSerifPro(weight: .light, size: 11)
        static let caption3 = UIFont.setSourceSerifPro(weight: .regular, size: 9)
        
        //
        static let stars_large = UIFont.setSourceSerifPro(weight: .semiBold, size: 21)
        static let stars_mini = UIFont.setSourceSerifPro(weight: .semiBold, size: 11)
    }
    
    enum CinzelFont {
        static let title_Extra = UIFont(name: "Cinzel-Regular", size: DeviceMenager.isSmallDevice ? 36 : 48)
        static let title_h0 = UIFont(name: "Cinzel-Regular", size: DeviceMenager.isSmallDevice ? 36 : 42)
        static let title_h1 = UIFont(name: "Cinzel-Regular", size: 26)
        static let title_h3 = UIFont(name: "Cinzel-Regular", size: 18)
        static let subtitle = UIFont(name: "Cinzel-Regular", size: 14)
    }
    
    struct Horoscope {
        static let lightTextColor = #colorLiteral(red: 0.6980392157, green: 0.6901960784, blue: 0.9725490196, alpha: 1)
        static let primaryColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        static let shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5)
        static let backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        
    }
    struct Numerology {
        static let lightTextColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        static let primaryColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        static let shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
        static let backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
    }
    
    struct TrendsArticles {
        static let textColor = #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1)
        static let primaryColor = #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1)
        static let shadowColor = #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1).withAlphaComponent(0.5)
        static let backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.1607843137, blue: 0.1333333333, alpha: 0.7)
    }
    
    struct ProgressBarTitnt {
        static let green   = #colorLiteral(red: 0.231372549, green: 1, blue: 0.4392156863, alpha: 1)
        static let red     = #colorLiteral(red: 1, green: 0.262745098, blue: 0.231372549, alpha: 1)
        static let yellow  = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.231372549, alpha: 1)
        static let purple  = #colorLiteral(red: 0.6901960784, green: 0.231372549, blue: 1, alpha: 1)
        static let cyan    = #colorLiteral(red: 0.231372549, green: 1, blue: 0.8235294118, alpha: 1)
        static let pink    = #colorLiteral(red: 1, green: 0.231372549, blue: 0.6039215686, alpha: 1)
        static let clear   = UIColor.clear
    }
    
    // MARK: CellColors
    struct PaywallTint {
        static let primaryPaywall: UIColor = .hexColor("7070CA")
        // Card
        static let primaryDarkBG: UIColor = .hexColor("202039")
        static let secondaryDarkBG: UIColor = .hexColor("333261")
        // Cell
        static let cellActiveBG: UIColor = .hexColor("4B4A89")
        static let cellActiveBorder: UIColor = .hexColor("7070CA")
        static let cellDisabledBorder: UIColor = .hexColor("4B4A89")
        //
        static let discountBadge: UIColor = .hexColor("2DA890")
    }
    
    struct MoonColors {
        /// == AADCFF
        static let brightTint: UIColor = .hexColor("AADCFF")
        /// == 6D9BAE
        static let mediumTint: UIColor = .hexColor("6D9BAE")
        /// == 1F2930
        static let darkTint: UIColor = .hexColor("1F2930")
        static let grayText: UIColor = .white.withAlphaComponent(0.5)
    }
    
    struct Chat {
        static let primary: UIColor = .hexColor("7070CA")
        static let darkBG: UIColor = .hexColor("302B4B").withAlphaComponent(0.7)
        static let green: UIColor = .hexColor("2DA890")
        
        // Bubble
        static let answer: UIColor = .hexColor("4B4A89")
        static let question: UIColor = .hexColor("7070CA")
        
        static let orange: UIColor = .hexColor("FF7D00")
        static let textColor: UIColor = .hexColor("B1B0F8")
        static let bg: UIColor = .hexColor("3A3A69")
        
        
    }
    
    
    
    
    
    
    
    // MARK: - 🌕 Funcs
    public static func setDesignedShadow(to view: UIView, accentColor: UIColor) {
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = DS.maxCornerRadius
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowColor = accentColor.withAlphaComponent(0.5).cgColor
    }
    
    public static func setCardStyle(
        to view: UIView,
        tintColor: UIColor,
        cornerRadius: CGFloat
    ) {
        // Style
        view.backgroundColor = tintColor == UIColor.clear ? tintColor : tintColor.withAlphaComponent(0.24)
        
        // Border
        view.layer.borderColor = tintColor.cgColor
        view.layer.borderWidth = DS.borderWidth
        view.layer.cornerRadius = cornerRadius
        // Shadow
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowColor = tintColor.withAlphaComponent(0.5).cgColor
    }
    
}
