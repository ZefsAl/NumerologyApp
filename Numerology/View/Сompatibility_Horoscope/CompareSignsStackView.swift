//
//  CompareSignsSV.swift
//  Numerology
//
//  Created by Serj on 19.01.2024.
//

import UIKit

class CompareSignsStackView: UIStackView {
    
    var accentColor: UIColor = .white
    
    var firstSignModel: SignCellModel? {
        didSet {
            if firstSignModel != nil {
                self.userSignIMG.image = firstSignModel?.signImage
                self.userLable.text = firstSignModel?.title.capitalized
            } else {
                self.userSignIMG.image = UIImage(named: "plus")
                self.userLable.text = "You"
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
                self.partnerLable.text = "Partner"
            }
        }
    }
    

    // MARK: User Sign IMG
    let userSignIMG: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.image = UIImage(named: "plus")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: user Lable
    let userLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "SourceSerifPro-Regular", size: 20)
        l.text = "Empty"
        l.textAlignment = .center
        return l
    }()
    
    // MARK: - Partner Sign IMG
    let partnerSignIMG: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.image = UIImage(named: "plus")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: Partner Lable
    let partnerLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "SourceSerifPro-Regular", size: 20)
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
            
            NSLayoutConstraint.activate([
                
                secondView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                secondView.topAnchor.constraint(equalTo: mainView.topAnchor),
                secondView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                secondView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                
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
            
            NSLayoutConstraint.activate([
                
                secondView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                secondView.topAnchor.constraint(equalTo: mainView.topAnchor),
                secondView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                secondView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                
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
        
        self.addArrangedSubview(userStack)
        self.addArrangedSubview(plusLable)
        self.addArrangedSubview(partnerStack)
        self.alignment = .center
        self.axis = .horizontal
        self.distribution = .fill
        self.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        self.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            userStack.widthAnchor.constraint(equalTo: partnerStack.widthAnchor), // fix
        ])
    }

}
