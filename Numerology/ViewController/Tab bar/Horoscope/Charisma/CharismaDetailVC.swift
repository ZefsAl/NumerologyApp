//
//  AboutYouVC.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit

class CharismaDetailVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    let signContent = SignContentView()
    
    // MARK: title
    let signTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle_Sb_15
        l.textAlignment = .center
        return l
    }()
    // MARK: - subtitle
    let signSubtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle_Sb_15
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    var chartsDataSource = [ChartCVCellModel]()
    
    let chartsCV: ContentCollectionView = {
        let cv = ContentCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return cv
    }()
    
    
    // MARK: 🟢 View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        // open from VC
        self.openFrom = self
        self.registerChartsCV()
    }
    
    // MARK: Setup Stack
    func configureUI(
        title: String,
        info: String?,
        isPremium: Bool,
        visibleConstant: CGFloat
    ) {
        
        let textStack = UIStackView(arrangedSubviews: [signTitle,signSubtitle])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .center
        textStack.spacing = 4
        
        //
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
                accordionStack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -16),
                accordionStack.widthAnchor.constraint(equalTo: v.widthAnchor, constant: -32),
            ])
            
            return v
        }()
        
        // MARK: - content Stack
        let contentStack = UIStackView(arrangedSubviews: [signContent,textStack,cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .center
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

