//
//  MainNavController.swift
//  Numerology
//
//  Created by Serj on 12.11.2023.
//

import UIKit

extension UIViewController {
    func setNavItems(left: UIBarButtonItem, right: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = left
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setDetaiVcNavItems(showShare: Bool = true) {
        // 1
        let dismissButton: UIButton = {
            let configImage = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)
            )
            let iv = UIImageView(image: configImage)
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.tintColor = .white
            iv.contentMode = .scaleAspectFit
            iv.isUserInteractionEnabled = false

            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 15
            button.addSystemBlur(to: button, style: .systemUltraThinMaterialDark)
            button.clipsToBounds = true
            
            button.addSubview(iv)
            NSLayoutConstraint.activate([
                iv.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                iv.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                button.heightAnchor.constraint(equalToConstant: 30),
                button.widthAnchor.constraint(equalToConstant: 30),
            ])
            return button
        }()
        let dismissButtonItem = UIBarButtonItem(customView: dismissButton)
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(closeAction(_:)))
        dismissButton.addGestureRecognizer(dismissTap)

        // 2
        let shareButton: UIButton = {
            let configImage = UIImage(
                systemName: "square.and.arrow.up",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
            )
            let iv = UIImageView(image: configImage)
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.tintColor = .white
            iv.contentMode = .scaleAspectFit
            iv.isUserInteractionEnabled = false

            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 15
            button.addSystemBlur(to: button, style: .systemUltraThinMaterialDark)
            button.clipsToBounds = true
            
            button.addSubview(iv)
            NSLayoutConstraint.activate([
                iv.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                iv.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                button.heightAnchor.constraint(equalToConstant: 30),
                button.widthAnchor.constraint(equalToConstant: 30),
            ])
            return button
        }()
        
        let shareButtonItem = UIBarButtonItem(customView: shareButton)
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(shareAction(_:)))
        shareButton.addGestureRecognizer(shareTap)
        
        // Set
        if showShare {
            self.navigationItem.leftBarButtonItem = shareButtonItem
        }
        
        self.navigationItem.rightBarButtonItem = dismissButtonItem
    }
    
    @objc private func closeAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareAction(_ sender: UIButton) {
        self.shareButtonClicked()
    }
    
    
    
}

final class CustomNavController: UINavigationController {
    
    // MARK: - view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = nil
        self.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationBar.subviews.forEach {
            $0.clipsToBounds = false
        }
        self.navigationBar.clipsToBounds = false
    }
    
}



