//
//  MainTabBarController_v2.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit
import RevenueCat


final class MainTabBarController: UITabBarController, UITabBarControllerDelegate, RemoteOpenDelegate, SpecialOfferButtonDelegate {
    
    var openFrom: UIViewController?
//    let descriptionVC = DescriptionVC()
    var boardOfDayModel: BoardOfDayModel?
    
    
    lazy private var specialOfferButton = {
        let b = SpecialOfferButton()
        // Delegate
        b.remoteOpenDelegate = self
        b.remoteOpenDelegate?.openFrom = self
        //
        b.specialOfferButtonDelegate = self
        return b
    }()
    // delegate
    func todayTipAction() {
        let descriptionVC = DescriptionVC()
        descriptionVC.configure(
            title: "Your tip of the day!",
            info: boardOfDayModel?.dayTip,
            about: nil
        )
        if boardOfDayModel != nil {
            
            if let item = self.tabBar.selectedItem,
               let index = self.tabBar.items?.firstIndex(of: item) {
             
                descriptionVC.setStyleWithTint(
                    bgImage: getTabBarBgImage(index: index),
                    primaryColor: self.getTabBarTint(index: index),
                    bgColor: self.getTabBarBgColor(index: index)
                )
            }
            
            let navVC = UINavigationController(rootViewController: descriptionVC)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
    }
    
    private func requestDayTip() {
        NumerologyManager.shared.getBoardOfDay { model in
            self.boardOfDayModel = model
        }
    }
    
    private func configName() {
        guard
            let name = UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as? String
        else { return }
        self.profileButton.nameTitle.text = name
    }
    
    private func requestUserSign() {
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        guard let dateOfBirth = dateOfBirth else { return }
        let sign = HoroscopeSign().findHoroscopeSign(byDate: dateOfBirth)
        HoroscopeManager.shared.getSign(zodiacSign: sign) { model, image1, image2  in
            self.profileButton.horoscopeIcon.image = image2
        }
    }
    
    var primaryColor: UIColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
    
    lazy private var profileButton: ProfileButton = {
        let b = ProfileButton()
        // Delegate
        b.remoteOpenDelegate = self
        b.remoteOpenDelegate?.openFrom = self
        return b
    }()
    
    // MARK: 🟢 viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Nav
        self.setNavItems(
            left: UIBarButtonItem(customView: specialOfferButton),
            right: UIBarButtonItem(customView: profileButton)
        )
        //
        showSpecialOffer()
        //
        requestDayTip()
        // set
        setTabBarStyle()
        setTabs()
        //
        configName()
        requestUserSign() // 🔴 Возможно тут Crash
        // Bg Music
        MusicManager.shared.setupAndPlaySound()
    }
    
    private func showSpecialOffer() {
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
        let titleAttributes = [ NSAttributedString.Key.font : UIFont.setSourceSerifPro(weight: .bold, size: 10) ] as [NSAttributedString.Key : Any]
        
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
}

extension MainTabBarController {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.firstIndex(of: item)
        self.tabBar.tintColor = self.getTabBarTint(index: index)
    }
    
    private func getTabBarTint(index: Int?) -> UIColor? {
        guard let index = index else { return nil }
        switch index {
        case 0:
            return #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        case 1:
            return #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        case 2:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case 3:
            return #colorLiteral(red: 0.9529411765, green: 0.862745098, blue: 0.4705882353, alpha: 1)
        default:
            break
        }
        return nil
    }
    
    private func getTabBarBgImage(index: Int?) -> String? {
        guard let index = index else { return nil }
        switch index {
        case 0:
            return "bgHoroscope2"
        case 1:
            return "MainBG2"
        case 2:
            return "MoonBG2"
        case 3:
            return "TrendsBG_v2"
        default:
            break
        }
        return nil
    }
    
    private func getTabBarBgColor(index: Int?) -> UIColor? {
        guard let index = index else { return nil }
        switch index {
        case 0:
            return DesignSystem.Horoscope.backgroundColor
        case 1:
            return DesignSystem.Numerology.backgroundColor
        case 2:
            return UIColor.black.withAlphaComponent(0.6)
        case 3:
            return DesignSystem.TrendsArticles .backgroundColor
        default:
            break
        }
        return nil
    }
    
    
}


//struct DescriptionVCStyleModel {
//    
//}

