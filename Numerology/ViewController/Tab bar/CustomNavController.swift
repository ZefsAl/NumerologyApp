//
//  MainNavController.swift
//  Numerology
//
//  Created by Serj on 12.11.2023.
//

import UIKit

final class CustomNavController: UINavigationController {
    
    // MARK: - view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFullWidthBackGesture()
    }
    
    // Fix Shadow crop
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationBar.subviews.forEach {
            $0.clipsToBounds = false
        }
        self.navigationBar.clipsToBounds = false
    }
    
    // ✅ Back Swipe from any left drag
    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
    private func setupFullWidthBackGesture() {
        guard
            let interactivePopGestureRecognizer = interactivePopGestureRecognizer,
            let targets = interactivePopGestureRecognizer.value(forKey: "targets")
        else {
            return
        }
        fullWidthBackGestureRecognizer.setValue(targets, forKey: "targets")
        fullWidthBackGestureRecognizer.delegate = self
        view.addGestureRecognizer(fullWidthBackGestureRecognizer)
    }
    
}
// MARK: - Delegate
extension CustomNavController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled == true
        let isThereStackedViewControllers = viewControllers.count > 1
        
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = panGestureRecognizer.velocity(in: view)
            // Only left swipe
            return isSystemSwipeToBackEnabled && isThereStackedViewControllers && velocity.x > 0
        }
        return false
    }
}


