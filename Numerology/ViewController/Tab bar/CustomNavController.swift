//
//  MainNavController.swift
//  Numerology
//
//  Created by Serj on 12.11.2023.
//

import UIKit

final class CustomNavController: UINavigationController {
    
    let descriptionVC = DescriptionVC()
    var boardOfDayModel: BoardOfDayModel?
    
    // MARK: Icon
//    let horoscopeIcon: UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
////        iv.image = UIImage(named: "mdi_horoscope-taurus")
//        iv.contentMode = UIView.ContentMode.scaleAspectFit
//        iv.tintColor = .white
//
//        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        return iv
//    }()
    
    // MARK: title
//    private let nameTitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
////        l.text = "Name"
//        l.font = UIFont.init(weight: .bold, size: 20)
//        l.textColor = .white
//        return l
//    }()
    
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
    
    let profileButton: ProfileNavButton = {
        let b = ProfileNavButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(Any?.self, action: #selector(profileAct), for: .touchUpInside)
        return b
    }()

    
    
    // MARK: Profile Button
//    let profileButton: UIButton = {
//        let b = UIButton(type: .system)
//        b.translatesAutoresizingMaskIntoConstraints = false
//
//        let configImage = UIImage(systemName: "person.fill",
//                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
//        let iv = UIImageView(image: configImage)
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.tintColor = .white
//        b.addSubview(iv)
//        iv.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
//        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
//        b.addTarget(Any?.self, action: #selector(profileAct), for: .touchUpInside)
//        return b
//    }()
    @objc private func profileAct() {
        let nav = UINavigationController(rootViewController: EditProfileVC())
        self.present(nav, animated: true)
    }
    
    // MARK: dayTip Button
    let dayTipButton: UIButton = {
        let b = UIButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        // MARK: title
        let lable: UILabel = {
            let l = UILabel()
            l.translatesAutoresizingMaskIntoConstraints = false
            l.text = "Today"
            l.font = UIFont.init(weight: .bold, size: 20)
            l.textColor = .white
            
            l.layer.shadowOpacity = 1
            l.layer.shadowRadius = 16
            l.layer.shadowOffset = CGSize(width: 0, height: 0)
            l.layer.shadowColor = UIColor.white.cgColor
            
            return l
        }()
        
        b.addSubview(lable)
        NSLayoutConstraint.activate([
            lable.centerYAnchor.constraint(equalTo: b.centerYAnchor),
            lable.leadingAnchor.constraint(equalTo: b.leadingAnchor),
            lable.trailingAnchor.constraint(equalTo: b.trailingAnchor),
        ])
        
        b.addTarget(Any?.self, action: #selector(dayTipAct), for: .touchUpInside)
        return b
    }()
    @objc private func dayTipAct() {
        descriptionVC.configure(
            title: "Your tip of the day!",
            info: boardOfDayModel?.dayTip,
            about: nil
        )
        if boardOfDayModel != nil {
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
    
    // MARK: - view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configName()
        
        requestDayTip()
        requestUserSign()
    }
    
    private func configName() {
        guard
            let name = UserDefaults.standard.object(forKey: "nameKey") as? String
        else { return }
        self.profileButton.nameTitle.text = name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    private func requestUserSign() {
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)
        HoroscopeManager.shared.getSigns(zodiacSigns: sign) { model, image1, image2  in
            self.profileButton.horoscopeIcon.image = image2
        }
    }
    
    
    // MARK: - setup UI
    private func setupUI() {
        
        let contentStack = UIStackView(arrangedSubviews: [dayTipButton,UIView(),profileButton])
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
}





class ProfileNavButton: UIButton {
    
    // MARK: Icon
    let horoscopeIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.image = UIImage(named: "mdi_horoscope-taurus")
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.tintColor = .white
        
        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return iv
    }()
    
    // MARK: title
    let nameTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "Name"
        l.font = UIFont.init(weight: .bold, size: 20)
        l.textColor = .white
        return l
    }()
    
    // MARK: Icon
    private let chevronIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.tintColor = .white
        let configImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        )
        iv.image = configImage
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        let contentStack = UIStackView(arrangedSubviews: [horoscopeIcon,nameTitle,chevronIcon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 4
        contentStack.isUserInteractionEnabled = false 
        
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
//            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
    
    
}
