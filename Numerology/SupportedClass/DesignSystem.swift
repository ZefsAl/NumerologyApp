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
        static let feedCardTextColor = #colorLiteral(red: 0.6980392157, green: 0.6901960784, blue: 0.9725490196, alpha: 1)
    }
    
}
