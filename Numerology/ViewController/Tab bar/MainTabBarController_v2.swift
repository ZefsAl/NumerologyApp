//
//  MainTabBarController_v2.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit
import RevenueCat


final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //
        setTabBarStyle()
        setTabs()
    }
    
    func setTabBarStyle() {
        self.tabBar.tintColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        setBlurBG()
    }
    
    func setBlurBG() {
        // clear Tab Bar BG
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage() // add this if you want remove tabBar separator
        self.tabBar.barTintColor = .clear
        self.tabBar.backgroundColor = .black // here is your tabBar color
        self.tabBar.layer.backgroundColor = UIColor.clear.cgColor
        // set
        UIView().addSystemBlur(to: self.tabBar, style: .systemThinMaterialDark)
    }
    
    func setTabs() {
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
        
        // MARK: SecondVC
        let secondVC = HoroscopeVC()
        let secondImage = UIImage(named: "Horoscope_3x_75px")
        secondVC.tabBarItem.image = secondImage
        secondVC.tabBarItem.title = "Horoscope"
        secondVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        secondVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        
        // MARK: FourthVC
        let fourthVC = MoonVC()
        let fourtImage = UIImage(named: "Moon_3x_75px")
        fourthVC.tabBarItem.image = fourtImage
        fourthVC.tabBarItem.title = "Moonly"
        fourthVC.tabBarItem.titlePositionAdjustment = UIOffset(
            horizontal: 5, // horizontal for optical compensation
            vertical: -5 // same
        )
        fourthVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        
        // MARK: fiveVC
        let fiveVC = TrendsArticlesVC()
        let fiveImage = UIImage(named: "Trends")
        fiveVC.tabBarItem.image = fiveImage
        fiveVC.tabBarItem.title = "Trends"
        fiveVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        fiveVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        
        
        let testVC = UIViewController()
        let testImage = UIImage(named: "Trends")
        testVC.tabBarItem.image = testImage
        testVC.tabBarItem.title = "Test"
        testVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        testVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        testVC.view.backgroundColor = .systemBrown
        
        self.viewControllers = [secondVC,firstVC,fourthVC,fiveVC]
    }
    
    
    // MARK: view Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            guard
                customerInfo?.entitlements["Access"]?.isActive == false ||
                customerInfo?.entitlements["Access"]?.isActive == nil
            else { return }
            TechnicalManager.shared.getSpecialOfferShowTime() { model in
                guard let time = model.val1 else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(time*60)) { // ~ 420=7 min
                    // MARK: - Special Offer ✅
                    self.presentViewControllerFromVisibleViewController(SpecialOfferPaywall(), animated: true) {}
                }
            }
        }
    }
}

extension MainTabBarController {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.items?.firstIndex(of: item) == 0 {
            self.tabBar.tintColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        } else if tabBar.items?.firstIndex(of: item) == 1 {
            self.tabBar.tintColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        }
        else if tabBar.items?.firstIndex(of: item) == 2 {
            self.tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else if tabBar.items?.firstIndex(of: item) == 3 {
            self.tabBar.tintColor = #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1)
        }
    }
    
//    func setTabBarTint(_ tabBar: UITabBar) {
//        tabBar.selectedItem
//        
//        switch tabBar.items {
//            
//        case .none:
//            <#code#>
//        case .some(_):
//            <#code#>
//        }
//        
//    }
    
}


