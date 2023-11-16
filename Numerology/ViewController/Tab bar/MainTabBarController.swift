//
//  MainTabBarController.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit
import RevenueCat

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    
    // MARK: header
//    let header: HeaderUIView = {
//        let v = HeaderUIView()
//        v.profileButton.addTarget(Any?.self, action: #selector(profileBtnAction), for: .touchUpInside)
//
//        return v
//    }()
    // MARK: Profile Btn Action
//    @objc func profileBtnAction() {
//        print("profileBtnAction")
//        self.navigationController?.pushViewController(EditProfileVC(), animated: true)
//    }
    
    
    
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
        let firstVC = NumerologyVC()
        let firstImage = UIImage(named: "Numerology_3x_93px")
        firstVC.tabBarItem.image = firstImage
        firstVC.tabBarItem.title = "Numerology"
        firstVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let firstTabNav = CustomNavController(rootViewController: firstVC)
        
        // MARK: SecondVC
        let secondVC = FourthViewController()
        let secondImage = UIImage(named: "Horoscope_3x_75px")
        secondVC.tabBarItem.image = secondImage
        secondVC.tabBarItem.title = "Horoscope"
        secondVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let secondTabNav = CustomNavController(rootViewController: secondVC)

        // MARK: ThirdVC
        let thirdVC = FourthViewController()
//        let thirdImage = UIImage(
//            systemName: "heart",
//            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
//        )?.withBaselineOffset(fromBottom: 14)
        let thirdImage = UIImage(named: "Compatibility_3x_75px")
        thirdVC.tabBarItem.image = thirdImage
        thirdVC.tabBarItem.title = "Compatibility"
        thirdVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let thirdTabNav = CustomNavController(rootViewController: thirdVC)
        
        // MARK: FourthVC
        let fourthVC = FourthViewController()
        let fourtImage = UIImage(
            systemName: "moon.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
//        ?.withBaselineOffset(fromBottom: 14)
        fourthVC.tabBarItem.image = fourtImage
        fourthVC.tabBarItem.title = "About"
        fourthVC.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
        let fourthTabNav = CustomNavController(rootViewController: fourthVC)
    
        self.viewControllers = [firstTabNav,secondTabNav,thirdTabNav,fourthTabNav]
        
        
    }
    
    // MARK: viewWill Appear 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
//        setHeaderView()
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
    
    
    
    
    // MARK: checkUserAccess
//    func checkUserAccess() {
//
//        // VC
//        let vc2 = PaywallVC_V2(onboardingIsCompleted: true)
////         MARK: get Customer Info
//        Purchases.shared.getCustomerInfo { (customerInfo, error) in
//
//            if customerInfo?.entitlements["Access"]?.isActive == true {
//                vc2.dismiss(animated: true)
//                print("Secondary Check: Have Access")
//            } else {
//                    let navVC = UINavigationController(rootViewController: vc2)
//                    navVC.modalPresentationStyle = .overFullScreen
//                    self.present(navVC, animated: true)
//                print("Secondary Check: No Access")
//            }
//        }
//
//    }
    
    
}

//extension MainTabBarController {
//
//    // MARK: Setup header View
//    private func setHeaderView() {
//        guard
//            let name = UserDefaults.standard.object(forKey: "nameKey") as? String,
//            let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
//        else {
//            return
//        }
//
//        let todayDate: String = setDateFormat(date: Date())
//        let userDate: String = setDateFormat(date: dateOfBirth)
//
//        header.configure(
//            helloTitle: name,
//            todayDate: todayDate,
//            userDate: userDate
//        )
//
//        self.view.addSubview(header)
//
//        NSLayoutConstraint.activate([
//            header.topAnchor.constraint(equalTo: view.topAnchor),
//            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            header.heightAnchor.constraint(equalToConstant: 176),
//        ])
//    }
//}
