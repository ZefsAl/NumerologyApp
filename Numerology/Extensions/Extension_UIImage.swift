//
//  Extension_UIImage.swift
//  Numerology
//
//  Created by Serj on 27.07.2023.
//

import Foundation
import UIKit


extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
