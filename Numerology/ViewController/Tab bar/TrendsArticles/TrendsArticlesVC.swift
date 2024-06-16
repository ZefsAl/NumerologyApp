//
//  NumerologyVC_2024.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.04.2024.
//

import Foundation
import UIKit

final class TrendsArticlesVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController? 
    
    let trendsArticlesCV = TrendsArticlesCV()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        setBackground(named: "TrendsBG")
        AnimatableBG().setBackground(vc: self)
        // 2
        setupUI()
        remoteOpen()
    }

    
    private func remoteOpen() {
        // date Compatibility CV
        trendsArticlesCV.remoteOpenDelegate = self
        trendsArticlesCV.remoteOpenDelegate?.openFrom = self
        self.openFrom = self
    }
    
    private func setupUI() {
        self.view.addSubview(trendsArticlesCV)
        
        let margin: CGFloat = 0
        let viewMargin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            trendsArticlesCV.topAnchor.constraint(      equalTo: viewMargin.topAnchor,     constant: 24 ),
            trendsArticlesCV.leadingAnchor.constraint(  equalTo: self.view.leadingAnchor,  constant: margin ),
            trendsArticlesCV.trailingAnchor.constraint( equalTo: self.view.trailingAnchor, constant: -margin),
            trendsArticlesCV.bottomAnchor.constraint(   equalTo: self.view.bottomAnchor,   constant: -margin),
        ])
    }
    
}
