//
//  ViewController.swift
//  Numerology
//
//  Created by Serj on 29.01.2024.
//

import UIKit

class MoonVC: UIViewController {
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    private let headerTitle: SectionHeaderView = {
        let v = SectionHeaderView()
        v.label.text = "Moon Calendar"
        v.label.textColor = .white
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return v
    }()
    
    private let accordionView: AccordionView = {
        let v = AccordionView()
        v.accordionButton.setAccordionTitle("Today")
        return v
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "MoonBG.png")
        AnimatableBG().setBackground(vc: self)
        //
        setupStack()
        requestData()
        
    }
    
    private func requestData() {
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        let moonDay = MoonCalendarManager().getAfternoonMoonDay()
        //
        HoroscopeManager.shared.getMoonPhase(moonDay: moonDay) { model in
            self.accordionView.info.text = model.todayInfo
            self.accordionView.imageView.image = UIImage(named: "fullMoon.png")
            self.accordionView.showConstraintImage()
            self.accordionView.imageView.isHidden = false
        }
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let accordionStack = UIStackView(arrangedSubviews: [accordionView])
        accordionStack.translatesAutoresizingMaskIntoConstraints = false
        accordionStack.axis = .vertical
        accordionStack.spacing = 8
        
        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = .black.withAlphaComponent(0.85)
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = UIColor.white.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
            
            v.addSubview(accordionStack)
            NSLayoutConstraint.activate([
                accordionStack.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                accordionStack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
                accordionStack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
                accordionStack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -0),
                accordionStack.widthAnchor.constraint(equalTo: v.widthAnchor, constant: -32),
            ])
            
            return v
        }()
        
        // MARK: content Stack
        let contentStack = UIStackView(arrangedSubviews: [headerTitle,cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 12
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 32),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

