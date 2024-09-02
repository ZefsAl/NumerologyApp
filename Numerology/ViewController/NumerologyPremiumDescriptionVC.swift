//
//  DescriptionVC.swift
//  Numerology
//
//  Created by Serj on 27.07.2023.
//

import UIKit

class NumerologyPremiumDescriptionVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    // MARK: - Top Image
    private lazy var topImage: TopImage = TopImage(
        tint: DesignSystem.Numerology.primaryColor,
        referenceView: self.view
    )
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
//        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private var numerologyImagesKeys: NumerologyImagesKeys? = nil
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DesignSystem.Numerology.primaryColor)
        //
        self.setBackground(named: "MainBG2")
        AnimatableBG().setBackground(vc: self)
        // open from VC
        self.openFrom = self
        
    }

    convenience init(
        title: String,
        info: String?,
        isPremium: Bool = true,
        visibleConstant: CGFloat? = 100,
        topImageKey: NumerologyImagesKeys
    ) {
        self.init()
        self.openFrom = self
        //
        self.configureUI(
            title: title,
            info: info,
            isPremium: isPremium,
            visibleConstant: visibleConstant ?? 100
        )
        // Notification
        self.numerologyImagesKeys = topImageKey
        self.numerologyImagesDataUpdated()
        NotificationCenter.default.addObserver(self, selector: #selector(numerologyImagesDataUpdated), name: .numerologyImagesDataUpdated, object: nil)
    }
    
    @objc private func numerologyImagesDataUpdated() {
        if let key = self.numerologyImagesKeys {
            NumerologyImagesManager.shared.setTopImage(self.topImage, key: key)
        }
    }
    
    // MARK: Set up Stack
    private func configureUI(
        title: String,
        info: String?,
        isPremium: Bool,
        visibleConstant: CGFloat
    ) {

        let accordionStack = UIStackView()
        accordionStack.translatesAutoresizingMaskIntoConstraints = false
        accordionStack.axis = .vertical
        accordionStack.spacing = 8
        
        let accordionView: PremiumAccordionView = {
            let v = PremiumAccordionView(
                title: title,
                info: info,
                isPremium: isPremium,
                visibleConstant: visibleConstant
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
            v.layer.shadowRadius = 16
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
        
        // MARK: - content Stack
        let contentStack = UIStackView(arrangedSubviews: [cardView])
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

