//
//  DetailCompatibilityHrscpVC.swift
//  Numerology
//
//  Created by Serj on 23.01.2024.
//

import UIKit

class CharismaDetailVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    private let vcAccentColor: UIColor = DesignSystem.Horoscope.primaryColor
    
    let signContent = SignContentView()
    
    // MARK: title
    let signTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.title_h5
        l.textAlignment = .center
        return l
    }()
    // MARK: - subtitle
    let signSubtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.title_h5
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    var charismaCVViewModel: CharismaCVViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.chartsCV.reloadData()
            }
        }
    }
    
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    lazy var accordionView: PremiumAccordionView = {
        let v = PremiumAccordionView(
            title: "",
            info: "",
            isPremium: true,
            visibleConstant: 150
        )
        v.remoteOpenDelegate = self
        v.remoteOpenDelegate?.openFrom = self
        return v
    }()
    
    let chartsCV: ContentCollectionView = {
        let cv = ContentCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return cv
    }()
    
    // MARK: 🟢 View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DesignSystem.Horoscope.primaryColor)
        //
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        //
        setupStack()
        // open from VC
        self.openFrom = self
        self.registerChartsCV()
        //
        guard
            let data = self.charismaCVViewModel?.chartsDataSource,
            data.count > 0
        else { return }
        self.setCardText(model: data[0])
    }
    
    func setCardText(model: ChartCVCellModel) {
        accordionView.accordionButton.setAccordionTitle(model.title)
        accordionView.sharedData.data = model.text
        accordionView.accordionButton.mainTitle.fadeTransition()
        //
        self.accordionView.premiumTextViewHost.view.setNeedsUpdateConstraints()
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        let signTitleStack = UIStackView(arrangedSubviews: [signTitle,signSubtitle])
        signTitleStack.translatesAutoresizingMaskIntoConstraints = false
        signTitleStack.axis = .vertical
        signTitleStack.alignment = .center
        signTitleStack.spacing = 4
        
        //
        let accordionStack = UIStackView(arrangedSubviews: [chartsCV,accordionView])
        accordionStack.translatesAutoresizingMaskIntoConstraints = false
        accordionStack.axis = .vertical
        accordionStack.spacing = 16
        
        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = DesignSystem.maxCornerRadius
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = self.vcAccentColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = DesignSystem.maxCornerRadius
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = vcAccentColor.withAlphaComponent(0.5).cgColor
            
            v.addSubview(accordionStack)
            NSLayoutConstraint.activate([
                accordionStack.topAnchor.constraint(equalTo: v.topAnchor, constant: 20),
                accordionStack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
                accordionStack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
                accordionStack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -20),
                accordionStack.widthAnchor.constraint(equalTo: v.widthAnchor, constant: -32),
            ])
            
            return v
        }()
        
        // MARK: content Stack
        let contentStack = UIStackView(arrangedSubviews: [
            signContent,
            signTitleStack,
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

