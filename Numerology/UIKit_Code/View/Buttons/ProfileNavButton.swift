//
//  ProfileNavButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 26.08.2024.
//

import UIKit

final class ProfileButton: UIButton {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // MARK: - 🟢 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        

        self.setImage(UIImage(named: "Gear_SF"), for: .normal)
        
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        // target
        self.addTarget(Any?.self, action: #selector(profileAct), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func profileAct() {
        self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(EditProfileVC(), animated: true)
    }
}


//class ProfileButton: UIButton {
//    
//    var remoteOpenDelegate: RemoteOpenDelegate? = nil
//    
//    // MARK: Icon
////    let horoscopeIcon: UIImageView = {
////        let iv = UIImageView()
////        iv.translatesAutoresizingMaskIntoConstraints = false
////        iv.contentMode = UIView.ContentMode.scaleAspectFit
////        iv.tintColor = .white
////        
////        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
////        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
////        return iv
////    }()
//    
//    // MARK: title
////    let nameTitle: UILabel = {
////        let l = UILabel()
////        l.translatesAutoresizingMaskIntoConstraints = false
////        l.font = UIFont.setSourceSerifPro(weight: .bold, size: 20)
////        l.textColor = .white
////        return l
////    }()
//    
//    // MARK: Icon
////    private let chevronIcon: UIImageView = {
////        let iv = UIImageView()
////        iv.translatesAutoresizingMaskIntoConstraints = false
////        iv.image = UIImage(systemName: "chevron.right")
////        iv.contentMode = UIView.ContentMode.scaleAspectFit
////        iv.tintColor = .white
////        let configImage = UIImage(
////            systemName: "chevron.right",
////            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
////        )
////        iv.image = configImage
////        return iv
////    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        setUI()
//        
//        self.addTarget(Any?.self, action: #selector(profileAct), for: .touchUpInside)
//    }
//    @objc private func profileAct() {
//        self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(EditProfileVC(), animated: true)
//    }
//        
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setUI() {
//        let contentStack = UIStackView(arrangedSubviews: [horoscopeIcon,nameTitle,chevronIcon])
//        contentStack.translatesAutoresizingMaskIntoConstraints = false
//        contentStack.axis = .horizontal
//        contentStack.alignment = .center
//        contentStack.spacing = 4
//        contentStack.isUserInteractionEnabled = false
//        
//        self.addSubview(contentStack)
//        NSLayoutConstraint.activate([
//            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//        ])
//    }
//    
//}
