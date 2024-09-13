//
//  Ext_UIViewController.swift
//  Numerology
//
//  Created by Serj_M1Pro on 29.08.2024.
//

import UIKit

extension UIViewController {
    // MARK: - set Detai Vc Nav Items
    func setNavItems(left: UIBarButtonItem, right: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = left
        self.navigationItem.rightBarButtonItem = right
    }
    // MARK: - set Detai Vc Nav Items
    func setDetaiVcNavItems(showShare: Bool = true, shareTint: UIColor? = nil) {
        let tint = (shareTint ?? UIColor.white).withAlphaComponent(0.7)
        // 1
        let shareImg = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        )?.withTintColor(tint, renderingMode: .alwaysOriginal)
        let shareButtonItem = UIBarButtonItem(
            image: shareImg,
            style: .plain,
            target: self,
            action: #selector(shareAction)
        )
        
        // 2
        let dismissImg = UIImage(
            systemName: "xmark",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        )?.withTintColor(UIColor.white.withAlphaComponent(0.7), renderingMode: .alwaysOriginal)
        let dismissButtonItem = UIBarButtonItem(
            image: dismissImg,
            style: .plain,
            target: self,
            action: #selector(closeAction)
        )
        
        // Set
        if showShare {
            self.navigationItem.leftBarButtonItem = shareButtonItem
        }
        
        self.navigationItem.rightBarButtonItem = dismissButtonItem
    }
    
    @objc private func closeAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        if let navigationController = self.navigationController,
           navigationController.viewControllers.first != self {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func shareAction(_ sender: UIButton) {
        self.shareButtonClicked()
    }
}
