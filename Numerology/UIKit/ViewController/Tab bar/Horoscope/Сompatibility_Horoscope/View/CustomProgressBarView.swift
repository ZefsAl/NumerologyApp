//
//  CustomProgressBarView.swift
//  Numerology
//
//  Created by Serj on 24.01.2024.
//

import UIKit

class CustomProgressBarView: UIProgressView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.progressViewStyle = .bar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }

}
