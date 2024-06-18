//
//  MainTabBarController.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit
import RevenueCat


//protocol CustomNavControllerDelegate {
////    var vcDelegate: CustomNavController? { get set }
//}

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
//    var customNavControllerDelegate: CustomNavControllerDelegate?
    
    let titleAttributes = [
        NSAttributedString.Key.font: UIFont.init(weight: .bold, size: 10)
    ]
    
    // MARK: FirstVC
    lazy var firstTabNav: CustomNavController = {
        let firstVC = NumerologyVC_2024()
        let firstImage = UIImage(named: "Numerology_3x_75px")
        firstVC.tabBarItem.image = firstImage
        firstVC.tabBarItem.title = "Numerology"
        firstVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        firstVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        // Navigation
        let firstTintColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        let firstTabNav = CustomNavController(primaryColor: firstTintColor)
        firstTabNav.descriptionVC.primaryColor = firstTintColor
        firstTabNav.setViewControllers([firstVC], animated: true)
        //
        return firstTabNav
    }()
    
    
    lazy var secondTabNav: CustomNavController = {
        let secondVC = HoroscopeVC()
        let secondImage = UIImage(named: "Horoscope_3x_75px")
        secondVC.tabBarItem.image = secondImage
        secondVC.tabBarItem.title = "Horoscope"
        secondVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        secondVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        // Navigation
        let secondTintColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        let secondTabNav = CustomNavController(primaryColor: secondTintColor)
        // description VC
        secondTabNav.descriptionVC.bgImageNamed = "bgHoroscope2"
        secondTabNav.descriptionVC.primaryColor = secondTintColor
        // add
        secondTabNav.setViewControllers([secondVC], animated: true)
        //
        return secondTabNav
    }()
    
    
    lazy var thirdTabNav: CustomNavController = {
        // MARK: ThirdVC
        let thirdVC = CompatibilityHoroscopeVC()
        let thirdImage = UIImage(named: "Compatibility_3x_75px")
        thirdVC.tabBarItem.image = thirdImage
        thirdVC.tabBarItem.title = "Compatibility"
        thirdVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        thirdVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        // Navigation
        let thirdTintColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1)
        let thirdTabNav = CustomNavController(primaryColor: thirdTintColor)
        // description VC
        thirdTabNav.descriptionVC.bgImageNamed = "CompatibilityBG_Full"
        thirdTabNav.descriptionVC.primaryColor = thirdTintColor
        // add
        thirdTabNav.setViewControllers([thirdVC], animated: true)
        //
        return thirdTabNav
    }()
    
    
    lazy var fourthTabNav: CustomNavController = {
        // MARK: FourthVC
        let fourthVC = MoonVC()
        let fourtImage = UIImage(named: "Moon_3x_75px")
        fourthVC.tabBarItem.image = fourtImage
        fourthVC.tabBarItem.title = "Moon"
        fourthVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        fourthVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        //
        let fourthTintColor = UIColor.white
        let fourthTabNav = CustomNavController(primaryColor: fourthTintColor)
        //
        fourthTabNav.descriptionVC.bgImageNamed = "MoonBG2"
        fourthTabNav.descriptionVC.cardBGColor = .black.withAlphaComponent(0.85)
        fourthTabNav.descriptionVC.primaryColor = fourthTintColor
        // add
        fourthTabNav.setViewControllers([fourthVC], animated: true)
        //
        return fourthTabNav
    }()
    
    lazy var fiveTabNav: CustomNavController = {
        let fiveVC = TrendsArticlesVC()
        let fiveImage = UIImage(named: "Trends")
        fiveVC.tabBarItem.image = fiveImage
        fiveVC.tabBarItem.title = "Trends"
        fiveVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        fiveVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        // Navigation
        let fiveTintColor = #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1)
        let fiveTabNav = CustomNavController(primaryColor: fiveTintColor)
        // description VC
        fiveTabNav.descriptionVC.bgImageNamed = "TrendsBG_v2"
        fiveTabNav.descriptionVC.primaryColor = fiveTintColor
        // add
        fiveTabNav.setViewControllers([fiveVC], animated: true)
        //
        return fiveTabNav
    }()
   
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //
        setTabBarStyle()
        //
        self.viewControllers = [firstTabNav,secondTabNav,thirdTabNav,fourthTabNav,fiveTabNav]
    }
    
    func setTabBarStyle() {
        self.tabBar.tintColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
//        self.tabBar.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
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
    
    
    // MARK: view Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            guard
                customerInfo?.entitlements["Access"]?.isActive == false ||
                customerInfo?.entitlements["Access"]?.isActive == nil
            else { return }
            DispatchQueue.main.asyncAfter(deadline: .now()+80) {
                // MARK: - Special Offer ✅
                self.presentViewControllerFromVisibleViewController(SpecialOfferPaywall(), animated: true) {}
            }
        }
        
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
        } else if tabBar.items?.firstIndex(of: item) == 4 {
            self.tabBar.tintColor = #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1)
        }
    }
}
