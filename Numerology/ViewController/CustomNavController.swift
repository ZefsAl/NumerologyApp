//
//  MainNavController.swift
//  Numerology
//
//  Created by Serj on 12.11.2023.
//

import UIKit

final class CustomNavController: UINavigationController {
    
    var boardOfDayModel: BoardOfDayModel?
    
    // MARK: Icon
    let horoscopeIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        let configImage = UIImage(named: "mdi_horoscope-taurus")
        iv.image = configImage
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.tintColor = .white
        
        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return iv
    }()
    
    // MARK: title
    private let nameTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "Name"
        l.font = UIFont.init(weight: .bold, size: 20)
        l.textColor = .white
        return l
    }()
    
    // MARK: Icon
//    let chevronIcon: UIImageView = {
//        let iv = UIImageView()
//
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.image = UIImage(systemName: "chevron.right")
//        iv.contentMode = UIView.ContentMode.scaleAspectFit
//        iv.tintColor = .white
//
//        let configImage = UIImage(
//            systemName: "chevron.right",
//            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
//        )
//        iv.image = configImage
//
//        return iv
//    }()
    
    // MARK: Profile Button
    let profileButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        let configImage = UIImage(systemName: "person.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
        let iv = UIImageView(image: configImage)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        b.addSubview(iv)
        iv.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        b.addTarget(Any?.self, action: #selector(profileAct), for: .touchUpInside)
        return b
    }()
    @objc private func profileAct() {
//        self.pushViewController(EditProfileVC(), animated: true)
        let nav = UINavigationController(rootViewController: EditProfileVC())
        self.present(nav, animated: true)
    }
    
    // MARK: dayTip Button
    let dayTipButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        let configImage = UIImage(systemName: "sun.max.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
        let iv = UIImageView(image: configImage)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        b.addSubview(iv)
        iv.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        b.addTarget(Any?.self, action: #selector(dayTipAct), for: .touchUpInside)
        return b
    }()
    @objc private func dayTipAct() {
        let vc = DescriptionVC()
        vc.configure(
            title: "Your tip of the day!",
            info: boardOfDayModel?.dayTip,
            about: nil
        )
        if boardOfDayModel != nil {
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
    }
    
    private func requestDayTip() {
        FirebaseManager.shared.getBoardOfDay { model in
            self.boardOfDayModel = model
        }
    }
    
    // MARK: - view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configName()
        
        requestDayTip()
        
    }
    
    private func configName() {
        guard
            let name = UserDefaults.standard.object(forKey: "nameKey") as? String
        else { return }
        nameTitle.text = name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    // MARK: - setup UI
    private func setupUI() {
//        let scrollAppearance = UINavigationBarAppearance()
//        scrollAppearance.configureWithDefaultBackground()
//        scrollAppearance.backgroundColor = .red
//        let standardAppearance = UINavigationBarAppearance()
//        standardAppearance.backgroundColor = .blue
//        standardAppearance.configureWithTransparentBackground()
        //        scrollAppearance.configureWithOpaqueBackground()
//        scrollAppearance.configureWithDefaultBackground()
//        scrollAppearance.configureWithTransparentBackground()
//        self.navigationBar.scrollEdgeAppearance = scrollAppearance
//        self.navigationBar.standardAppearance = standardAppearance
        
        
        let leftStack = UIStackView(arrangedSubviews: [horoscopeIcon,nameTitle])
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.axis = .horizontal
        leftStack.alignment = .center
        leftStack.spacing = 4
        
        let contentStack = UIStackView(arrangedSubviews: [leftStack,UIView(),dayTipButton,profileButton])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .fill
        contentStack.spacing = 24
        
        self.navigationBar.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.navigationBar.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: self.navigationBar.trailingAnchor, constant: -18),
            
        ])
    }
    
    // MARK: - Action
//    @objc private func settingsAct() {
//        print("settingsAct")
//    }
    
}



