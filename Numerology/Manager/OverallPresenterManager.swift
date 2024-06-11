//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 30.05.2024.
//

import UIKit


extension UIViewController {
    // MARK: - Present from current any VC
    func presentViewControllerFromVisibleViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {

        viewControllerToPresent.modalPresentationStyle = .overFullScreen
        
        if let navigationController = self as? UINavigationController {
            navigationController.topViewController?.presentViewControllerFromVisibleViewController(
                viewControllerToPresent,
                animated: flag,
                completion: completion
            )
        } else if let tabBarController = self as? UITabBarController {
            tabBarController.selectedViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent, animated: flag, completion: completion)
        } else if let presentedViewController = presentedViewController {
            presentedViewController.presentViewControllerFromVisibleViewController(viewControllerToPresent, animated: flag, completion: completion)
        } else {
            self.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    // Alert
    func showAlert(title: String, message: String?, action completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            completion()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}
