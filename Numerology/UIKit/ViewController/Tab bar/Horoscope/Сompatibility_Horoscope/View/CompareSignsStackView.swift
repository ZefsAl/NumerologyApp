//
//  CompareSignsSV.swift
//  Numerology
//
//  Created by Serj on 19.01.2024.
//

import UIKit

class CompareSignsStackView: UIStackView {
    
    var accentColor: UIColor = .white
    
    var firstSignModel: CompatibilitySignsModel? {
        didSet {
            if firstSignModel != nil {
                self.userSignIMG.image = firstSignModel?.image
                self.userLable.text = (firstSignModel?.sign.capitalized ?? "") + "\n" + (firstSignModel?.signDateRange ?? "")
            } else {
                self.userSignIMG.image = UIImage(named: "plus")
                self.userLable.text = "You"
            }
        }
    }
    
    var secondSignModel: CompatibilitySignsModel? {
        didSet {
            if secondSignModel != nil {
                self.partnerSignIMG.image = secondSignModel?.image
                self.partnerLable.text = (secondSignModel?.sign.capitalized ?? "") + "\n" + (secondSignModel?.signDateRange ?? "")
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
        iv.image = UIImage(named: "plus")
        iv.contentMode = .scaleAspectFit
        //
        iv.layer.cornerRadius = iv.bounds.height/2
        //
        DS.setDesignedShadow(to: iv, accentColor: DS.Horoscope.primaryColor)
        return iv
    }()
    
    // MARK: user Lable
    let userLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.title_h5
        l.text = "Empty"
        l.numberOfLines = 2
        l.textAlignment = .center
        return l
    }()
    
    // MARK: - Partner Sign IMG
    let partnerSignIMG: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "plus")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = iv.bounds.height/2
        //
        DS.setDesignedShadow(to: iv, accentColor: DS.Horoscope.primaryColor)
        return iv
    }()
    
    // MARK: Partner Lable
    let partnerLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.title_h5
        l.text = "Empty"
        l.numberOfLines = 2
        l.textAlignment = .center
        return l
    }()
    
    // MARK: Plus lable
    let plusLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        l.text = "+"
        l.textAlignment = .center
        l.clipsToBounds = false
        return l
    }()
    
    init(frame: CGRect, accentColor: UIColor) {
        self.accentColor = accentColor
        super.init(frame: frame)
        setupStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStack() {

        // MARK: User Stack
        let userStack = UIStackView(arrangedSubviews: [userSignIMG,userLable])
        userStack.axis = .vertical
        userStack.alignment = .center
        userStack.spacing = 10
        
        // MARK: User Stack
        let partnerStack = UIStackView(arrangedSubviews: [partnerSignIMG,partnerLable])
        partnerStack.axis = .vertical
        partnerStack.alignment = .center
        partnerStack.spacing = 10
        
        self.addArrangedSubview(userStack)
        self.addArrangedSubview(partnerStack)
        self.addSubview(plusLable)
        
        self.alignment = .fill
        self.axis = .horizontal
        self.distribution = .fill
        
        NSLayoutConstraint.activate([
            userStack.widthAnchor.constraint(equalTo: partnerStack.widthAnchor), // fix
            userSignIMG.heightAnchor.constraint(equalToConstant: 165),
            partnerSignIMG.heightAnchor.constraint(equalToConstant: 165),
            // как то так 
            plusLable.leadingAnchor.constraint(equalTo: userLable.trailingAnchor),
            plusLable.trailingAnchor.constraint(equalTo: partnerLable.leadingAnchor),
            plusLable.centerYAnchor.constraint(equalTo: userLable.centerYAnchor),
        ])
    }

}
