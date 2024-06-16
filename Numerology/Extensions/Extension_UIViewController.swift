//
//  Extension_UIViewController.swift
//  Numerology
//
//  Created by Serj on 27.07.2023.
//

import Foundation
import UIKit
import StoreKit

extension UIViewController {
    
    // MARK: - request Review
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
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
            
            let configImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
            
            let iv = UIImageView(image: configImage)
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.tintColor = .white
//            iv.backgroundColor = .black
            iv.layer.cornerRadius = 30
            iv.isUserInteractionEnabled = false
            
            v.addSubview(iv)
            
            v.heightAnchor.constraint(equalToConstant: 32).isActive = true
            v.widthAnchor.constraint(equalToConstant: 32).isActive = true
            
            return v
        }()
        
        // Add Nav Item
        let dismissButtonItem = UIBarButtonItem(customView: dismissButton)
        let gesture = UITapGestureRecognizer(target: self, action: selectorStr)
        dismissButton.addGestureRecognizer(gesture)
        self.navigationItem.rightBarButtonItem = dismissButtonItem
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
    
    
    // MARK: checkAccessContent
    func checkAccessContent() -> Bool {
        
        let accessVal = UserDefaults.standard.object(forKey: "UserAccessObserverKey") as! Bool
        guard accessVal == false else { return true }
        
        let vc2 = PaywallVC_V2(onboardingIsCompleted: true)
        let navVC = UINavigationController(rootViewController: vc2)
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
        
        return false
    }
     
    // MARK: isIphone_66
    func isIphone_12(view: UIView) -> Bool {
        // tryFix content size
        if (view.frame.height < 844.0) {
            print("✅ iphone 8")
            return false
        } else {
            print("✅ iphone 12")
            return true
        }
        // 8 iphone - Screen height: 667.0
        // 12 iphone - Screen height: 844.0
    }
    
    // MARK: - Share
    func shareButtonClicked() {
        
        let textToShare = String(describing: "Numerology")
        guard
            let myAppURLToShare = URL(string: "https://apps.apple.com/ru/app/id1622398869"),
            let image = UIImage(named: "AppIcon")
        else { return }
        let items = [textToShare, myAppURLToShare, image] as [Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        //Apps to exclude sharing to
        avc.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList
        ]
        //Present the shareView on iPhone
        DispatchQueue.main.async(qos: .default) {
            // Презент с ошибкой !
//            self.delegateVC?.settingsVC?.present(avc, animated: true)
            self.present(avc, animated: true)
        }
    }
}
