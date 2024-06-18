//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.06.2024.
//

import UIKit

class TrendsCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    let trendsView = TrendsView(edgeMargin: 12)
    
    let premiumBadgeManager = PremiumBadgeManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Style
        self.backgroundColor = DesignSystem.TrendsArticles.backgroundColor
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = DesignSystem.TrendsArticles.primaryColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = DesignSystem.TrendsArticles.shadowColor.cgColor
        //
        self.clipsToBounds = true
        // setup
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configureCell(
        model: TrendsCellModel
    ) {
        self.trendsView.setDataModel(model: model)
        
        // Очень специфичный баг
        // ➡️ by default, model.isPremium = false -> request вернет -> model.isPremium == true || false
        
        // Баг При reloadData
        
        // ⚠️ Проблема точно в конфиге ячейки (т.к при открытии detail view все правильно)
        // Если есть хотябы 1 (model.isPremium == true) то будет баг который добавит в другие ячейки .setPremiumBadgeToCard()
        
        // Предположения ❓❓❓
        // может что то происходит с данными в model, хотя в логах все правильно ❓
        // Может потому что я использую standart DataSource это не правильно, а не UICollectionViewDiffableDataSource (не пробовал) ❓
        
        // Проверить ☑️
        // ☑️ Модель данных после fetched request
        
//        print(
//            """
//            ✅🟠🔴imageTitle - \(model.imageTitle) - isPremium - \(model.isPremium)
//            """
//        )
        
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        // add
        self.addSubview(trendsView) // 1
        //
        NSLayoutConstraint.activate([
            // view
            trendsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            trendsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            trendsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            trendsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
}
