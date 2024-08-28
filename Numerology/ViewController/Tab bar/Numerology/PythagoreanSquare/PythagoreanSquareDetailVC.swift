//
//  ViewController.swift
//  Numerology
//
//  Created by Serj on 29.01.2024.
//

import UIKit

class PythagoreanSquareDetailVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    // MARK: - content Stack
    let contentStack = UIStackView()
    
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
        v.label.text = "About you"
        v.label.textColor = DesignSystem.Numerology.lightTextColor
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return v
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems()
        //
        self.setBackground(named: "MainBG3")
        AnimatableBG().setBackground(vc: self)
        // open from VC
        self.openFrom = self
        //
        setupStack()
    }
    
    func configureHandleDataModels(models: [PythagoreanDetailDataModel]) {

        let models = models.sorted { $0.index < $1.index }
        
        print("check ✅",models.count)
        
        for models in models {
            print("✅🟣 index",models.index)
            print("✅🟣 title",models.title)
            print("✅🟣 subtitle",models.subtitle)
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
            v.backgroundColor = DesignSystem.Numerology.backgroundColor
            // Border
            v.layer.cornerRadius = DesignSystem.maxCornerRadius
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = DesignSystem.Numerology.primaryColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = DesignSystem.maxCornerRadius
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = DesignSystem.Numerology.shadowColor.cgColor
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
                v.backgroundColor = DesignSystem.Numerology.backgroundColor
                // Border
                v.layer.cornerRadius = DesignSystem.maxCornerRadius
                v.layer.borderWidth = DesignSystem.borderWidth
                v.layer.borderColor = DesignSystem.Numerology.primaryColor.cgColor
                v.layer.shadowOpacity = 1
                v.layer.shadowRadius = DesignSystem.maxCornerRadius
                v.layer.shadowOffset = CGSize(width: 0, height: 4)
                v.layer.shadowColor = DesignSystem.Numerology.shadowColor.cgColor
                
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

