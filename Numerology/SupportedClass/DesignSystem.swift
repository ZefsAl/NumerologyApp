//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 08.05.2024.
//

import UIKit


struct DesignSystem {
    
    static let borderWidth: CGFloat = 1
    
    
    
    
    enum TextCard {
        static let title = UIFont(weight: .semiBold, size: 24)
        static let subtitle = UIFont(weight: .semiBold, size: 15)
    }
    
    enum FeedCard {
        static let title = UIFont(name: "Cinzel-Regular", size: 18)
        static let subtitle = UIFont(name: "Cinzel-Regular", size: 14)
    }
    
    struct Horoscope {
        static let lightTextColor = #colorLiteral(red: 0.6980392157, green: 0.6901960784, blue: 0.9725490196, alpha: 1)
    }
    struct Numerology {
        static let lightTextColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        static let primaryColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        static let shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
        static let backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
    }
    
    
}
