//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 11.06.2024.
//

import UIKit

class DatailTrendsArticlesVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    var trendsView: TrendsView = {
       let v = TrendsView(edgeMargin: 22)
        v.layer.cornerRadius = 16
        return v
    }()
    
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
        setBackground(named: "TrendsBG_v2")
        AnimatableBG().setBackground(vc: self)
        //
        trendsView.remoteOpenDelegate = self
        trendsView.remoteOpenDelegate?.openFrom = self
        // open from VC
        self.openFrom = self
    }
    
    convenience init(
        model: TrendsCellModel,
        visibleConstant: CGFloat
    ) {
        self.init()
        configureUI(model: model, visibleConstant: visibleConstant)
        self.trendsView = trendsView
    }
    
    // MARK: Set up Stack + data
    private func configureUI(
        model: TrendsCellModel,
        visibleConstant: CGFloat
    ) {
        // like
        self.trendsView.likeButton.configureLike(model: model)
        //
        trendsView.bgImage.image = model.image
        trendsView.imageTitle.text = model.imageTitle
        //
        let accordionStack = UIStackView()
        accordionStack.translatesAutoresizingMaskIntoConstraints = false
        accordionStack.axis = .vertical
        accordionStack.spacing = 8
        //
        let accordionView: PremiumAccordionView = {
            let v = PremiumAccordionView(
                title: model.cardTitle ?? "",
                info: model.cardText,
                isPremium: model.isPremium,
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
            v.backgroundColor = DesignSystem.TrendsArticles.backgroundColor
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = DesignSystem.TrendsArticles.primaryColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = DesignSystem.TrendsArticles.shadowColor.cgColor
            
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
        contentStack.alignment = .center
        contentStack.axis = .vertical
        /*contentStack.distribution = .fill*/
        contentStack.spacing = 20
        
        setBlackHeader()
        self.view.addSubview(trendsView)
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let stackMargin: CGFloat = 18 // 18 default
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        //
        let trendsViewHeight: NSLayoutConstraint = {
            if DeviceMenager.shared.device == .iPhone_Se2_3Gen_8_7_6S {
                return trendsView.heightAnchor.constraint(equalToConstant: 240) //240
            } else {
                return trendsView.heightAnchor.constraint(equalToConstant: 300)
            }
        }()
        
        NSLayoutConstraint.activate([
            //
            cardView.widthAnchor.constraint(equalTo: contentStack.widthAnchor, constant: 0),
            //
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: stackMargin),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: stackMargin),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -stackMargin),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -stackMargin),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -(stackMargin*2)),
            
            // trendsView + contentStack
            trendsView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            trendsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            trendsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            trendsViewHeight,
            
            contentScrollView.topAnchor.constraint(equalTo: trendsView.bottomAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    private func setBlackHeader() {
        let blackTopview: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .black
            return v
        }()
        self.view.addSubview(blackTopview)
        NSLayoutConstraint.activate([
            blackTopview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            blackTopview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            blackTopview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            blackTopview.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
        ])
    }
}

