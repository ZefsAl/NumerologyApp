//
//  Extension_UIViewController.swift
//  Numerology
//
//  Created by Serj on 27.07.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: setBackground
    func setBackground(named: String) {
        let background = UIImage(named: named)
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    // MARK: set Dismiss Nav Item
    public func setDismissNavButtonItem(selectorStr: Selector) {
        
        let dismissButton: UIView = {
            
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            
            let configImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular))
            
            let iv = UIImageView(image: configImage)
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.tintColor = .white
            iv.backgroundColor = .black
            iv.layer.cornerRadius = 30
            iv.isUserInteractionEnabled = false
            
            v.addSubview(iv)
            
            v.heightAnchor.constraint(equalToConstant: 32).isActive = true
            v.widthAnchor.constraint(equalToConstant: 32).isActive = true
            
            return v
        }()
        
        // Add Nav Item
        let dismissButtonItem = UIBarButtonItem(customView: dismissButton)
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonAction))
        let gesture = UITapGestureRecognizer(target: self, action: selectorStr)
        dismissButton.addGestureRecognizer(gesture)
        self.navigationItem.rightBarButtonItem = dismissButtonItem
        
        // MARK: + BG color NAV view
        // не прозрачное но заполненно
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.view.backgroundColor = .black.withAlphaComponent(0.7)
        
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = true
//
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    
    
    
    // MARK: Action dissmiss
    @objc func dismissButtonAction() {
        self.dismiss(animated: true)
        print("dismissButtonAction")
    }
    // MARK: Action popToRoot
    @objc func popToRootButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        
        print("popToRootButtonAction")
    }
    
    
    
    func checkAccessContent() -> Bool {
        
        let accessVal = UserDefaults.standard.object(forKey: "UserAccessObserverKey") as! Bool
        guard accessVal == false else { return true }
        
        let vc = PaywallViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
        

        return false
    }
        
        

    
    
    
}
