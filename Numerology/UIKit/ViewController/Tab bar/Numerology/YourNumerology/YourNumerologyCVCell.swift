//
//  YourNumerologyCell.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.04.2024.
//

import UIKit


class YourNumerologyCVCell: UICollectionViewCell {
 
    static var reuseID: String {
        String(describing: self)
    }
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 18)
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        return l
    }()
    
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.setSourceSerifPro(weight: .light, size: 14)
        l.textAlignment = .left
        l.numberOfLines = 3
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.6)
        return l
    }()
    
    // MARK: Icon
    let cardIcon: UIImageView = {
        let iv = UIImageView()
        //
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        //
        let configImage = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        )
        iv.image = configImage
        iv.isHidden = true
        return iv
    }()
    
    // MARK: bgImage
    let numberBgIMG: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 55).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 55).isActive = true
        iv.image = UIImage(named: "plug")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = DS.maxCornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
        // setup
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, subtitle: String?, bgImage: UIImage?) {
        self.title.text = title
        self.subtitle.text = subtitle
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.numberBgIMG.image = bgImage ?? UIImage(named: "plug")
        }
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [title,subtitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .leading
        contentStack.spacing = 0
        // 1
        self.addSubview(contentStack)
        // 2
        self.addSubview(numberBgIMG)
        //
        NSLayoutConstraint.activate([
            numberBgIMG.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            numberBgIMG.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
        ])
    }
}
