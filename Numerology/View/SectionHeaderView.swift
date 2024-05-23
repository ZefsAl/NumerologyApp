//
//  SectionHeaderView.swift
//  Numerology
//
//  Created by Serj on 10.11.2023.
//

import Foundation
import UIKit


final class SectionHeaderView: UICollectionReusableView {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textColor = DesignSystem.Numerology.lightTextColor
        l.textAlignment = .center
        l.font = UIFont(name: "Cinzel-Regular", size: 26)
        l.sizeToFit()
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

