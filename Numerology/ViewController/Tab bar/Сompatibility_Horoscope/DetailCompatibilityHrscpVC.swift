//
//  DetailCompatibilityHrscpVC.swift
//  Numerology
//
//  Created by Serj on 23.01.2024.
//

import UIKit

class DetailCompatibilityHrscpVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    
    private let vcAccentColor: UIColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1)
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    private lazy var compareSignsStackView: CompareSignsStackView = {
        let sv = CompareSignsStackView(frame: .null, accentColor: vcAccentColor)
        return sv
    }()
    
    let compatibilityStatsStackView = CompatibilityStatsStackView()
    
    private lazy var accordionView: PremiumAccordionView = {
       let v = PremiumAccordionView(
        title: "",
        info: "",
        isPremium: true,
        visibleConstant: 200
       )
        v.remoteOpenDelegate = self
        v.remoteOpenDelegate?.openFrom = self
//        v.accordionButton.setAccordionTitle("")
//        v.info.text = ""
//       v.showAccordion()
       return v
   }()
    
    // MARK: - init
    init(compatibilityHrscpModel: CompatibilityHrscpModel, compareSignsStackView: CompareSignsStackView) {
        compatibilityStatsStackView.setStats(model: compatibilityHrscpModel)
        super.init(nibName: nil, bundle: nil)
        //
        self.openFrom = self
        //
        self.compareSignsStackView.firstSignModel = compareSignsStackView.firstSignModel
        self.compareSignsStackView.secondSignModel = compareSignsStackView.secondSignModel
        
        accordionView.accordionButton.setAccordionTitle("Generally")
        accordionView.info.text = compatibilityHrscpModel.aboutThisSign
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "CompatibilityBG.png")
        AnimatableBG().setBackground(vc: self)
        //
        setupStack()
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
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
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1)
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
            
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
        let contentStack = UIStackView(arrangedSubviews: [
            compareSignsStackView,
            compatibilityStatsStackView,
            cardView,
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 24
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 20),
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
