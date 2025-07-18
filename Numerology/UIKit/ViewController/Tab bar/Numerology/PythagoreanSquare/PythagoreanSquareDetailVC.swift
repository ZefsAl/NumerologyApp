//
//  ViewController.swift
//  Numerology
//
//  Created by Serj on 29.01.2024.
//

import UIKit

class PythagoreanSquareDetailVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    // MARK: - Top Image
    private lazy var topImage: TopImage = TopImage(
        tint: DS.Numerology.primaryColor,
        referenceView: self.view
    )
    
    // MARK: - content Stack
    let contentStack = UIStackView()
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        // sv.contentInsetAdjustmentBehavior = .neve
        return sv
    }()
    
    private let headerTitle: SectionHeaderView = {
        let v = SectionHeaderView()
        v.label.text = "About you"
        v.label.textColor = DS.Numerology.lightTextColor
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return v
    }()
    
    // MARK: 🟢 View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DS.Numerology.primaryColor)
        //
        self.setBackground(named: "MainBG3")
        AnimatableBG().setBackground(vc: self)
        // open from VC
        self.openFrom = self
        //
        setupStack()
        // Notification
        self.numerologyImagesDataUpdated()
        NotificationCenter.default.addObserver(self, selector: #selector(numerologyImagesDataUpdated), name: .numerologyImagesDataUpdated, object: nil)
    }
    
    @objc private func numerologyImagesDataUpdated() {
        NumerologyImagesManager.shared.setTopImage(self.topImage, key: .psychomatrix)
    }
    
    func configureHandleDataModels(models: [PythagoreanDetailDataModel]) {

        let models = models.sorted { $0.index < $1.index }
        
        myPrint("check ✅",models.count)
        
        for models in models {
            myPrint("✅🟣 index",models.index)
            myPrint("✅🟣 title",models.title)
            myPrint("✅🟣 subtitle",models.subtitle)
        }
        
        // description 
        let accordionStack: PremiumAccordionView = {
            let v = PremiumAccordionView(
                title: "About Psychomatrix",
                info: models[0].info,
                isPremium: false
            )
            
            v.remoteOpenDelegate = self
            v.remoteOpenDelegate?.openFrom = self
            return v
        }()
        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = DS.Numerology.backgroundColor
            // Border
            v.layer.cornerRadius = DS.maxCornerRadius
            v.layer.borderWidth = DS.borderWidth
            v.layer.borderColor = DS.Numerology.primaryColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = DS.maxCornerRadius
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = DS.Numerology.shadowColor.cgColor
            //
            v.addSubview(accordionStack)
            NSLayoutConstraint.activate([
                accordionStack.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                accordionStack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
                accordionStack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
                accordionStack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16),
                accordionStack.widthAnchor.constraint(equalTo: v.widthAnchor, constant: -32),
            ])
            return v
        }()
        contentStack.insertArrangedSubview(cardView, at: 0)
        
        
        // others content
        for model in models {
            
            let accordionStack = UIStackView()
            accordionStack.translatesAutoresizingMaskIntoConstraints = false
            accordionStack.axis = .vertical
            accordionStack.spacing = 8
            
            let accordionView: PremiumAccordionView = {
                
                let v = PremiumAccordionView(
                    title: model.title,
                    info: model.subtitle,
                    isPremium: isNotPremium(
                        indexes: [1,2,3],
                        model: model
                    ),
                    visibleConstant: 100
                )
                v.remoteOpenDelegate = self
                v.remoteOpenDelegate?.openFrom = self
                return v
            }()
            accordionStack.addArrangedSubview(accordionView)
            
            // cardView + Border
            let cardView: UIView = {
                let v = UIView()
                v.translatesAutoresizingMaskIntoConstraints = false
                // Style
                v.backgroundColor = DS.Numerology.backgroundColor
                // Border
                v.layer.cornerRadius = DS.maxCornerRadius
                v.layer.borderWidth = DS.borderWidth
                v.layer.borderColor = DS.Numerology.primaryColor.cgColor
                v.layer.shadowOpacity = 1
                v.layer.shadowRadius = DS.maxCornerRadius
                v.layer.shadowOffset = CGSize(width: 0, height: 4)
                v.layer.shadowColor = DS.Numerology.shadowColor.cgColor
                
                v.addSubview(accordionStack)
                NSLayoutConstraint.activate([
                    accordionStack.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                    accordionStack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
                    accordionStack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
                    accordionStack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16),
                    accordionStack.widthAnchor.constraint(equalTo: v.widthAnchor, constant: -32),
                ])
                
                return v
            }()
            
            contentStack.addArrangedSubview(cardView)
        }
        
        // custom
        func isNotPremium(indexes: [Int], model: PythagoreanDetailDataModel) -> Bool {
            return !indexes.contains { $0 == model.index }
        }
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // MARK: content Stack
        contentStack.insertArrangedSubview(headerTitle, at: 1)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 12
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(topImage)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            topImage.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor),
            
            contentStack.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 18),

            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

