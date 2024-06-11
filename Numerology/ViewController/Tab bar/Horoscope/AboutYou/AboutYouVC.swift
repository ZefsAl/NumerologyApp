//
//  AboutYouVC.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit

class AboutYouVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    let signContent = SignContentView()
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        // open from VC
        self.openFrom = self
    }
    
    // MARK: Set up Stack
    func configureUI(
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
            v.backgroundColor = DesignSystem.Horoscope.backgroundColor
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = DesignSystem.Horoscope.primaryColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = DesignSystem.Horoscope.shadowColor.cgColor
            
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
        
        // MARK: - content Stack
        let contentStack = UIStackView(arrangedSubviews: [signContent,cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 20
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([

            signContent.heightAnchor.constraint(equalTo: signContent.widthAnchor),
            
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

