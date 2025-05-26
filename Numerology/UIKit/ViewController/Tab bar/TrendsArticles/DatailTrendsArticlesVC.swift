//

//  Numerology
//
//  Created by Serj_M1Pro on 11.06.2024.
//

import UIKit

class DatailTrendsArticlesVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    lazy var trendsView: TrendsView = {
       let v = TrendsView()
        DS.setCardStyle(to: v, tintColor: DS.TrendsArticles.primaryColor, cornerRadius: DS.maxCornerRadius)
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
        self.setDetaiVcNavItems(showShare: false)
        self.navigationItem.hidesBackButton = true
        
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
            v.backgroundColor = DS.TrendsArticles.backgroundColor
            // Border
            v.layer.cornerRadius = DS.maxCornerRadius
            v.layer.borderWidth = DS.borderWidth
            v.layer.borderColor = DS.TrendsArticles.primaryColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = DS.TrendsArticles.shadowColor.cgColor
            
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
        let contentStack = UIStackView(arrangedSubviews: [trendsView,cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .center
        contentStack.axis = .vertical
        contentStack.spacing = 20
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let stackMargin: CGFloat = 18 // 18 default
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            //
            cardView.widthAnchor.constraint(equalTo: contentStack.widthAnchor, constant: 0),
            // trendsView
            trendsView.heightAnchor.constraint(equalToConstant: DeviceMenager.isSmallDevice ? 228 : 245),
            //
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: stackMargin),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -stackMargin),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -stackMargin),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -(stackMargin*2)),
            //
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}
