//
//  SectionFooterView.swift
//  Numerology
//
//  Created by Serj on 10.11.2023.
//

import Foundation
import UIKit


final class SectionFooterView: UICollectionReusableView {
    
    static var reuseID: String {
        String(describing: self)
    }

    func setPageControl(pageControl: UIPageControl) {
        addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

