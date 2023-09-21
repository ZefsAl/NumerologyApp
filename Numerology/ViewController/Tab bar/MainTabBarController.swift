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
    let header: HeaderUIView = {
        let v = HeaderUIView()
        v.profileButton.addTarget(Any?.self, action: #selector(profileBtnAction), for: .touchUpInside)
        
        return v
    }()
    // MARK: Profile Btn Action
    @objc func profileBtnAction() {
        print("profileBtnAction")
        self.navigationController?.pushViewController(EditProfileVC(), animated: true)
    }
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
//        self.view.backgroundColor = .black // Обязательно если не указываем на других VC
//        self.tabBar.barTintColor = .orange // ??
//        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.07058823529, blue: 0.1490196078, alpha: 1)
        
        setHeaderView()
        
        
        // MARK: FirstVC
        let firstVC = FirstViewController()
        firstVC.tabBarItem.title = nil
        let firstImage = UIImage(
            systemName: "star",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
        firstVC.tabBarItem.image = firstImage
        let firstTabNav = UINavigationController(rootViewController: firstVC)
        
        // MARK: SecondVC
        let secondVC = SecondViewController()
        secondVC.tabBarItem.title = nil
        let secondImage = UIImage(
            named: "Person_WideSize_3x_93px"
        ) 
        secondVC.tabBarItem.image = secondImage
        let secondTabNav = UINavigationController(rootViewController: secondVC)

        // MARK: ThirdVC
        let thirdVC = ThirdViewController()
        thirdVC.tabBarItem.title = ""
        let thirdImage = UIImage(
            systemName: "heart",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
        thirdVC.tabBarItem.image = thirdImage
        let thirdTabNav = UINavigationController(rootViewController: thirdVC)
        
        // MARK: FourthVC
        let fourthVC = FourthViewController()
        fourthVC.tabBarItem.title = ""
        let fourtImage = UIImage(
            systemName: "moon",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        ) 
        fourthVC.tabBarItem.image = fourtImage
        let fourthTabNav = UINavigationController(rootViewController: fourthVC)
        
        self.viewControllers = [firstTabNav,secondTabNav,thirdTabNav,fourthTabNav]
        
        
    }
    
    // MARK: viewWill Appear 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: view Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        var observer: NSKeyValueObservation?
        observer = UserDefaults.standard.observe(\.userAccess, options: [.initial, .new], changeHandler: { (defaults, change) in
            
            print("Defaults value : \(defaults.userAccess)")
            if defaults.userAccess == true {
            } else {
                self.checkUserAccess()
            }
        })
    }
    
    
    
    
    // MARK: checkUserAccess
    func checkUserAccess() {

        // VC
//        let vc = PaywallViewController()
        let vc2 = PaywallVC_V2()
//         MARK: get Customer Info
        Purchases.shared.getCustomerInfo { (customerInfo, error) in

            if customerInfo?.entitlements["Access"]?.isActive == true {
                vc2.dismiss(animated: true)
                print("Secondary Check: Have Access")
            } else {
                    let navVC = UINavigationController(rootViewController: vc2)
                    navVC.modalPresentationStyle = .overFullScreen
                    self.present(navVC, animated: true)
                print("Secondary Check: No Access")
            }
        }
        
    }
    
    
}

extension MainTabBarController {
    
    // MARK: Setup header View
    private func setHeaderView() {
        guard
            let name = UserDefaults.standard.object(forKey: "nameKey") as? String,
            let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        else {
            return
        }
        
        let todayDate: String = setDateFormat(date: Date())
        let userDate: String = setDateFormat(date: dateOfBirth)
        
        header.configure(
            helloTitle: name,
            todayDate: todayDate,
            userDate: userDate
        )

        self.view.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 176),
        ])
    }
}
