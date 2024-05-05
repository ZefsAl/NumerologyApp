//
//  MainTabBarController.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit
import RevenueCat

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.tabBar.tintColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        self.tabBar.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.init(weight: .bold, size: 10)
        ]
        
        // MARK: FirstVC
        let firstVC = NumerologyVC_2024()
        let firstImage = UIImage(named: "Numerology_3x_75px")
        firstVC.tabBarItem.image = firstImage
        firstVC.tabBarItem.title = "Numerology"
        firstVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        firstVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let firstTabNav = CustomNavController(rootViewController: firstVC)
        
        // MARK: SecondVC
        let secondVC = HoroscopeVC()
        let secondImage = UIImage(named: "Horoscope_3x_75px")
        secondVC.tabBarItem.image = secondImage
        secondVC.tabBarItem.title = "Horoscope"
        secondVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        secondVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let secondTabNav = CustomNavController(rootViewController: secondVC)
        secondTabNav.descriptionVC.primaryColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)

        // MARK: ThirdVC
        let thirdVC = CompatibilityHoroscopeVC()
        let thirdImage = UIImage(named: "Compatibility_3x_75px")
        thirdVC.tabBarItem.image = thirdImage
        thirdVC.tabBarItem.title = "Compatibility"
        thirdVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        thirdVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let thirdTabNav = CustomNavController(rootViewController: thirdVC)

        // MARK: FourthVC
        let fourthVC = MoonVC()
        let fourtImage = UIImage(named: "Moon_3x_75px")
        fourthVC.tabBarItem.image = fourtImage
        fourthVC.tabBarItem.title = "Moon"
        fourthVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        fourthVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let fourthTabNav = CustomNavController(rootViewController: fourthVC)
    
        self.viewControllers = [firstTabNav,secondTabNav,thirdTabNav,fourthTabNav]
    }
    
    // MARK: view Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        var observer: NSKeyValueObservation?
        observer = UserDefaults.standard.observe(\.userAccess, options: [.initial, .new], changeHandler: { (defaults, change) in
            
            print("Defaults value : \(defaults.userAccess)")
            if defaults.userAccess == true {
            } else {
//                self.checkUserAccess()
            }
        })
    }
}

extension MainTabBarController {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.items?.firstIndex(of: item) == 0 {
            self.tabBar.tintColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        } else if tabBar.items?.firstIndex(of: item) == 1 {
            self.tabBar.tintColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        } else if tabBar.items?.firstIndex(of: item) == 2 {
            self.tabBar.tintColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1)
        } else if tabBar.items?.firstIndex(of: item) == 3 {
            self.tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
