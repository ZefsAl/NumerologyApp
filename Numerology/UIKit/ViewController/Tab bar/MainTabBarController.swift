//
//  MainTabBarController_v2.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit
import RevenueCat
import SwiftUI


final class MainTabBarController: UITabBarController, UITabBarControllerDelegate, RemoteOpenDelegate, SpecialOfferButtonDelegate{
    
    
    //
    var openFrom: UIViewController?
    var boardOfDayModel: BoardOfDayModel?
    @ObservedObject var musicManager = MusicManager.shared
    
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
        showSpecialOffer()
        requestDayTip()
        // set
        setTabBarStyle()
        setTabs()
        // Bg Music
        musicManager.setupAndPlaySound()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func showSpecialOffer() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            guard
                customerInfo?.entitlements["Access"]?.isActive == false ||
                customerInfo?.entitlements["Access"]?.isActive == nil
            else { return }
            TechnicalManager.shared.getSpecialOfferShowTime() { model in
                guard let time = model.val1 else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(time*60)) { // ~ 420=7 min   Double(time*60)
                    // MARK: - Special Offer ✅
                    let savedDay: Int? = UserDefaults.standard.object(forKey: UserDefaultsKeys.specialOfferCurrentDay) as? Int
                    let currntDay = Date().get(.day)
                    
                    guard let savedDay = savedDay else {
                        PremiumManager.showSpecialOffer(from: self)
                        UserDefaults.standard.setValue(currntDay, forKey: UserDefaultsKeys.specialOfferCurrentDay)
                        return
                    }
                    guard currntDay != savedDay else { return }
                    PremiumManager.showSpecialOffer(from: self)
                    UserDefaults.standard.setValue(currntDay, forKey: UserDefaultsKeys.specialOfferCurrentDay)
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
        let titleAttributes = [ NSAttributedString.Key.font : UIFont.setSourceSerifPro(weight: .bold, size: 10) as Any ] as [NSAttributedString.Key : Any]
        
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
        let fourthVC = UIHostingController(rootView: MoonView())
        let fourtImage = UIImage(named: "Moon_3x_75px")
        fourthVC.tabBarItem.image = fourtImage
        fourthVC.tabBarItem.title = "Moonly"
        fourthVC.tabBarItem.titlePositionAdjustment = UIOffset(
            horizontal: 5, // horizontal for optical compensation
            vertical: -5 // same
        )
        fourthVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)

        
        // MARK: fiveVC
        let fiveVC = UIHostingController(rootView: SelectExpertView())
        let fiveImage = UIImage(named: "Chat_3x_75px")
        fiveVC.tabBarItem.image = fiveImage
        fiveVC.tabBarItem.title = "Chat"
        fiveVC.tabBarItem.titlePositionAdjustment = UIOffset(
            horizontal: 5, // horizontal for optical compensation
            vertical: -5 // same
        )
        fiveVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        
        
        // MARK: fiveVC
        let sixVC = TrendsArticlesVC()
        let sixImage = UIImage(named: "Trends")
        sixVC.tabBarItem.image = sixImage
        sixVC.tabBarItem.title = "Trends"
        sixVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        sixVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        
        self.viewControllers = [secondVC,firstVC,fiveVC,fourthVC,sixVC]
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
            return DS.Chat.orange
        case 3:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case 4:
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
            return DS.Horoscope.backgroundColor
        case 1:
            return DS.Numerology.backgroundColor
        case 2:
            return UIColor.black.withAlphaComponent(0.6)
        case 3:
            return DS.TrendsArticles .backgroundColor
        default:
            break
        }
        return nil
    }
    
    
}
