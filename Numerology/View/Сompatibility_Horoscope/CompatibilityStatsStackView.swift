//
//  CompatibilityCV.swift
//  Numerology
//
//  Created by Serj on 18.01.2024.
//

import UIKit

// MARK: - Stats Stack View
class StatsStackView: UIStackView {
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .semiBold, size: 14)
        l.textAlignment = .left
        l.text = "test"
        return l
    }()
    
    let percentTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(weight: .semiBold, size: 14)
        l.textAlignment = .right
        l.text = "0.0"
        return l
    }()
    
    private let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.trackTintColor = .lightGray.withAlphaComponent(0.4)
        pv.tintColor = .blue
        
        pv.layer.cornerRadius = 2.5
        pv.clipsToBounds = true
        
        pv.layer.sublayers![1].cornerRadius = 2.5
        pv.subviews[1].clipsToBounds = true
        
        NSLayoutConstraint.activate([
            pv.heightAnchor.constraint(equalToConstant: 5),
        ])
        
        // Gradient
        let gradientImage = UIImage.gradientImage(
            with: pv.frame,
            colors: [#colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1).cgColor, UIColor.white.cgColor],
            locations: nil
        )
        pv.progressImage = gradientImage
        
        return pv
    }()

    
    func setProgressValue(value: Int) {
        progressView.progress = Float(value)/Float(100)
    }
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStack()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpStack() {
        let firstStack = UIStackView(arrangedSubviews: [title,percentTitle])
        firstStack.axis = .horizontal
        firstStack.alignment = .fill
        firstStack.distribution = .fill
        firstStack.spacing = 10
        
        let secondtStack = UIStackView(arrangedSubviews: [progressView])
        secondtStack.axis = .horizontal
        secondtStack.alignment = .fill
        secondtStack.distribution = .fill
        secondtStack.spacing = 0
        
        self.addArrangedSubview(firstStack)
        self.addArrangedSubview(secondtStack)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.borderColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1)
        self.layer.borderWidth = DesignSystem.borderWidth
        self.layer.cornerRadius = 16
        // Shadow
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
        
        self.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.isLayoutMarginsRelativeArrangement = true
        
    }

}

// MARK: - Compatibility Stats Stack View
class CompatibilityStatsStackView: UIStackView {
    
    let general: StatsStackView = StatsStackView()
    let relationship: StatsStackView = StatsStackView()
    let intimacy: StatsStackView = StatsStackView()
    let family: StatsStackView = StatsStackView()
    let work: StatsStackView = StatsStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStats(model: CompatibilityHrscpModel) {
        let valArr = model.compatibilityStats.components(separatedBy: ",").compactMap({Int($0)})
        
        general.title.text = "General сompatibility"
        general.percentTitle.text = "\(valArr[0])%"
        general.setProgressValue(value: valArr[0])
        
        relationship.title.text = "Relationship"
        relationship.percentTitle.text = "\(valArr[1])%"
        relationship.setProgressValue(value: valArr[1])
        
        intimacy.title.text = "Intimacy"
        intimacy.percentTitle.text = "\(valArr[2])%"
        intimacy.setProgressValue(value: valArr[2])
        
        family.title.text = "Family"
        family.percentTitle.text = "\(valArr[3])%"
        family.setProgressValue(value: valArr[3])
        
        work.title.text = "Work"
        work.percentTitle.text = "\(valArr[4])%"
        work.setProgressValue(value: valArr[4])
    }
    
    private func setUpStack() {
        
        let firstStack = UIStackView(arrangedSubviews: [relationship,intimacy])
        firstStack.axis = .horizontal
        firstStack.alignment = .fill
        firstStack.distribution = .fillEqually
        firstStack.spacing = 20
        
        let secondtStack = UIStackView(arrangedSubviews: [family,work])
        secondtStack.axis = .horizontal
        secondtStack.alignment = .fill
        secondtStack.distribution = .fillEqually
        secondtStack.spacing = 20
        
        self.addArrangedSubview(general)
        self.addArrangedSubview(firstStack)
        self.addArrangedSubview(secondtStack)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 12
    }
}
