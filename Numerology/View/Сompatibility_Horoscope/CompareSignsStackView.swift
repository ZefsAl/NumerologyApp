//
//  CompareSignsSV.swift
//  Numerology
//
//  Created by Serj on 19.01.2024.
//

import UIKit

protocol CompareSignsStackDelegate {
    func firstRemoveButtonAct()
    func secondRemoveButtonAct()
}

class CompareSignsStackView: UIStackView {
    
    lazy var compareSignsStackDelegate: CompareSignsStackDelegate? = nil
    
    var accentColor: UIColor = .white
    
    var firstSignModel: SignCellModel? {
        didSet {
            if firstSignModel != nil {
                self.userSignIMG.image = firstSignModel?.signImage
                self.userLable.text = firstSignModel?.title.capitalized
            } else {
                self.userSignIMG.image = UIImage(named: "plus")
                self.userLable.text = "Empty"
            }
            
        }
    }
    var secondSignModel: SignCellModel? {
        didSet {
            if secondSignModel != nil {
                self.partnerSignIMG.image = secondSignModel?.signImage
                self.partnerLable.text = secondSignModel?.title.capitalized
            } else {
                self.partnerSignIMG.image = UIImage(named: "plus")
                self.partnerLable.text = "Empty"
            }
        }
    }
    

    // MARK: User Sign IMG
    let userSignIMG: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iv.image = UIImage(named: "plus")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: user Lable
    let userLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "SourceSerifPro-Regular", size: 26)
        l.text = "Empty"
        l.textAlignment = .center
        return l
    }()
    
    // MARK: - Partner Sign IMG
    let partnerSignIMG: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iv.image = UIImage(named: "plus")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: Partner Lable
    let partnerLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "SourceSerifPro-Regular", size: 26)
        l.text = "Empty"
        l.textAlignment = .center
        return l
    }()
    
    // MARK: Plus lable
    let plusLable : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        l.text = "+"
        l.textAlignment = .center
        NSLayoutConstraint.activate([
            l.widthAnchor.constraint(equalToConstant: 70)
        ])
        return l
    }()
    
    // Remove Button
    let firstRemoveButton: UIButton = {
        let b = UIButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        //
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .heavy)
        b.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        b.tintColor = .white
        b.backgroundColor = .systemGray
        b.layer.cornerRadius = 12
        //
        NSLayoutConstraint.activate([
            b.heightAnchor.constraint(equalToConstant: 24),
            b.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        b.addTarget(Any?.self, action: #selector(firstRemoveButtonAct), for: .touchUpInside)
        return b
    }()
    @objc private func firstRemoveButtonAct() {
        compareSignsStackDelegate?.firstRemoveButtonAct()
    }

    let secondRemoveButton: UIButton = {
        let b = UIButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        //
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .heavy)
        b.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        b.tintColor = .white
        b.backgroundColor = .systemGray
        b.layer.cornerRadius = 12
        //
        NSLayoutConstraint.activate([
            b.heightAnchor.constraint(equalToConstant: 24),
            b.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        b.addTarget(Any?.self, action: #selector(secondRemoveButtonAct), for: .touchUpInside)
        return b
    }()
    @objc private func secondRemoveButtonAct() {
        compareSignsStackDelegate?.secondRemoveButtonAct()
    }
    
    
    
    
    init(frame: CGRect, accentColor: UIColor) {
        self.accentColor = accentColor
        super.init(frame: frame)
        setUpStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStack() {
        
        // MARK: user view
        let userView: UIView = {
            let mainView = UIView()
            let secondView = UIView()
            secondView.translatesAutoresizingMaskIntoConstraints = false
            // Border
            secondView.layer.borderWidth = 2
            secondView.backgroundColor =  #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            secondView.layer.borderColor = accentColor.cgColor
            secondView.layer.cornerRadius = 16
            // Shadow
            secondView.layer.shadowOpacity = 1
            secondView.layer.shadowRadius = 16
            secondView.layer.shadowOffset = CGSize(width: 0, height: 4)
            secondView.layer.shadowColor = accentColor.withAlphaComponent(0.5).cgColor
            
            mainView.addSubview(secondView)
            mainView.addSubview(self.userSignIMG)
            mainView.addSubview(self.firstRemoveButton)
            
            
            NSLayoutConstraint.activate([
                
                secondView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                secondView.topAnchor.constraint(equalTo: mainView.topAnchor),
                secondView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                secondView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                
                firstRemoveButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: -5),
                firstRemoveButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: -5),
                
                secondView.heightAnchor.constraint(equalTo: secondView.widthAnchor),
                userSignIMG.centerYAnchor.constraint(equalTo: secondView.centerYAnchor),
                userSignIMG.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            ])
            return mainView
        }()
        
        
        // MARK: User Stack
        let userStack = UIStackView(arrangedSubviews: [userView,userLable])
        userStack.axis = .vertical
        userStack.alignment = .fill
        userStack.spacing = 10
        
        // MARK: partner View
//        let partnerView: UIView = {
//            let v = UIView()
//            v.translatesAutoresizingMaskIntoConstraints = false
//            // Border
//            v.layer.borderWidth = 2
//            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
//            v.layer.borderColor = accentColor.cgColor
//            v.layer.cornerRadius = 16
//            // Shadow
//            v.layer.shadowOpacity = 1
//            v.layer.shadowRadius = 16
//            v.layer.shadowOffset = CGSize(width: 0, height: 4)
//            v.layer.shadowColor = accentColor.cgColor
//
//            v.addSubview(self.partnerSignIMG)
//
//            NSLayoutConstraint.activate([
//                v.heightAnchor.constraint(equalTo: v.widthAnchor),
//                partnerSignIMG.centerYAnchor.constraint(equalTo: v.centerYAnchor),
//                partnerSignIMG.centerXAnchor.constraint(equalTo: v.centerXAnchor),
//            ])
//            return v
//        }()
        let partnerView: UIView = {
            let mainView = UIView()
            let secondView = UIView()
            secondView.translatesAutoresizingMaskIntoConstraints = false
            // Border
            secondView.layer.borderWidth = 2
            secondView.backgroundColor =  #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            secondView.layer.borderColor = accentColor.cgColor
            secondView.layer.cornerRadius = 16
            // Shadow
            secondView.layer.shadowOpacity = 1
            secondView.layer.shadowRadius = 16
            secondView.layer.shadowOffset = CGSize(width: 0, height: 4)
            secondView.layer.shadowColor = accentColor.withAlphaComponent(0.5).cgColor
            
            mainView.addSubview(secondView)
            mainView.addSubview(self.partnerSignIMG)
            mainView.addSubview(self.secondRemoveButton)
            
            
            NSLayoutConstraint.activate([
                
                secondView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                secondView.topAnchor.constraint(equalTo: mainView.topAnchor),
                secondView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                secondView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                
                secondRemoveButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: -5),
                secondRemoveButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: -5),
                
                secondView.heightAnchor.constraint(equalTo: secondView.widthAnchor),
                partnerSignIMG.centerYAnchor.constraint(equalTo: secondView.centerYAnchor),
                partnerSignIMG.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            ])
            return mainView
        }()
        
        // MARK: User Stack
        let partnerStack = UIStackView(arrangedSubviews: [partnerView,partnerLable])
        partnerStack.axis = .vertical
        partnerStack.alignment = .fill
        partnerStack.spacing = 10
        
    // MARK: numbers Stack
//        let compareStack = UIStackView(arrangedSubviews: [userStack, plusLable, partnerStack])
//        compareStack.translatesAutoresizingMaskIntoConstraints = false
//        compareStack.alignment = .center
//        compareStack.axis = .horizontal
//        compareStack.distribution = .fill
        
//        self.arrangedSubviews = [userStack, plusLable, partnerStack]
        self.addArrangedSubview(userStack)
        self.addArrangedSubview(plusLable)
        self.addArrangedSubview(partnerStack)
//        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .center
        self.axis = .horizontal
        self.distribution = .fill
        
        
//
//        // MARK: content Stack
//        let contentStack = UIStackView(arrangedSubviews: [
//            compareStack,
//            compatibilityButton,
//            aboutYouCV,
//            descriptionView
//        ])
//        contentStack.translatesAutoresizingMaskIntoConstraints = false
//        contentStack.alignment = .fill
//        contentStack.axis = .vertical
//        contentStack.distribution = .fill
//        contentStack.spacing = 40
        
//        self.view.addSubview(contentScrollView)
//        contentScrollView.addSubview(contentStack)
        
//        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            userStack.widthAnchor.constraint(equalTo: partnerStack.widthAnchor), // fix
            
//            compatibilityButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
//            compatibilityButton.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
//
//            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 32),
//            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 36),
//            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -36),
//            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
//            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -72),
//
//            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

}
