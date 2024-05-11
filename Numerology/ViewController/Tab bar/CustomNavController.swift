//
//  MainNavController.swift
//  Numerology
//
//  Created by Serj on 12.11.2023.
//

import UIKit

//protocol CustomNavControllerDelegate {
//    var vcDelegate: CustomNavController? { get set }
//}

final class CustomNavController: UINavigationController {
    
    let descriptionVC = DescriptionVC()
    var boardOfDayModel: BoardOfDayModel?
    
    var primaryColor: UIColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
    
    let profileButton: ProfileNavButton = {
        let b = ProfileNavButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(Any?.self, action: #selector(profileAct), for: .touchUpInside)
        return b
    }()
    
    @objc private func profileAct() {
        let nav = UINavigationController(rootViewController: EditProfileVC())
        self.present(nav, animated: true)
    }
    
    // MARK: dayTip Button
    lazy var dayTipButton: UIButton = {
        let b = UIButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.titleLabel?.font = UIFont.init(weight: .bold, size: 20)
        b.setTitle("Today", for: .normal)
        b.setTitleColor(.white, for: .normal)
        // Shadow
        b.titleLabel?.layer.shadowOpacity = 1
        b.titleLabel?.layer.shadowRadius = 16
        b.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
        b.titleLabel?.layer.shadowColor = self.primaryColor.cgColor
        
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
    
    // MARK: - init with color
    convenience init(primaryColor: UIColor) {
        self.init()
        self.primaryColor = primaryColor
    }
    
    // MARK: - view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configName()
        
        requestDayTip()
        requestUserSign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configName() {
        guard
            let name = UserDefaults.standard.object(forKey: "nameKey") as? String
        else { return }
        self.profileButton.nameTitle.text = name
    }
    
    private func requestUserSign() {
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)
        HoroscopeManager.shared.getSign(zodiacSign: sign) { model, image1, image2  in
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
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
