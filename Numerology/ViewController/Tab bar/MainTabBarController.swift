//
//  MainTabBarController.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit

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
        
        
        // MARK: FirstVC
        let firstVC = FirstViewController()
        firstVC.tabBarItem.title = ""
        let firstImage = UIImage(
            systemName: "star",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
        firstVC.tabBarItem.image = firstImage
        let firstTabNav = UINavigationController(rootViewController: firstVC)
        
        // MARK: SecondVC
        let secondVC = ViewController()
        secondVC.tabBarItem.title = ""
        let secondImage = UIImage(
            systemName: "hand.raised.fingers.spread",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
        secondVC.tabBarItem.image = secondImage
        let secondTabNav = UINavigationController(rootViewController: secondVC)

        // MARK: ThirdVC
        let thirdVC = ViewController()
        thirdVC.tabBarItem.title = ""
        let thirdImage = UIImage(
            systemName: "heart",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
        thirdVC.tabBarItem.image = thirdImage
        let thirdTabNav = UINavigationController(rootViewController: thirdVC)
        
        // MARK: FourthVC
        let fourthVC = ViewController()
        fourthVC.tabBarItem.title = ""
        let fourtImage = UIImage(
            systemName: "info.circle",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
        fourthVC.tabBarItem.image = fourtImage
        let fourthTabNav = UINavigationController(rootViewController: fourthVC)
        
        //
        self.viewControllers = [firstTabNav,secondTabNav,thirdTabNav,fourthTabNav]
        
    }
    // MARK: viewWill Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        setHeaderView()
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
