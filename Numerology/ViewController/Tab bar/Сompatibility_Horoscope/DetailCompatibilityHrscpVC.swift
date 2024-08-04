//
//  DetailCompatibilityHrscpVC.swift
//  Numerology
//
//  Created by Serj on 23.01.2024.
//

import UIKit

class DetailCompatibilityHrscpVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    
    private let vcAccentColor: UIColor = DesignSystem.Horoscope.primaryColor
    
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
        visibleConstant: 150
       )
        v.remoteOpenDelegate = self
        v.remoteOpenDelegate?.openFrom = self
       return v
   }()
    
    // MARK: - init
    init(compatibilityHrscpModel: CompatibilityHrscpModel, secondSign: String) {
        compatibilityStatsStackView.setStats(model: compatibilityHrscpModel)
        super.init(nibName: nil, bundle: nil)
        //
        self.openFrom = self
        //
        firstSignConfigure()
        secondSignConfigure(sign: secondSign)
        
        accordionView.accordionButton.setAccordionTitle("Generally")
        accordionView.info.text = compatibilityHrscpModel.aboutThisSign
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // config 1
    private func firstSignConfigure() {
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)

        
//        let model = CompatibilityData.simpleSigns.filter({$0.title.lowercased() == sign.lowercased() }).first
        let model = CompatibilityData.compatibilitySignsData.filter({$0.sign.lowercased() == sign.lowercased()}).first
        
//        guard
//            let title = model?.sign,
//            let signImage = model?.image
//        else { return }
        self.compareSignsStackView.firstSignModel = model
        
//        self.compareSignsStackView.firstSignModel = CompatibilitySignsModel(
//            title: title.capitalized,
//            signImage: signImage,
//            itemIndexPath: nil
//        )
//        self.compareSignsStackView.firstSignModel = CompatibilitySignsModel(
//            index: <#T##Int#>,
//            sign: title.capitalized,
//            signDateRange: signImage,
//            image: <#T##UIImage?#>
//        )
        
        
        
    }
    // config 2
    private func secondSignConfigure(sign: String) {

//        let model = CompatibilityData.simpleSigns.filter({$0.title.lowercased() == sign.lowercased()}).first
        let model = CompatibilityData.compatibilitySignsData.filter({$0.sign.lowercased() == sign.lowercased()}).first
        
//        guard
//            let title = model?.sign,
//            let signImage = model?.image
//        else { return }
//        self.compareSignsStackView.secondSignModel = SimpleSignModel(
//            title: title.capitalized,
//            signImage: signImage,
//            itemIndexPath: nil
//        )
        self.compareSignsStackView.secondSignModel = model
    }
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground(named: "bgHoroscope")
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
            v.layer.borderColor = self.vcAccentColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = vcAccentColor.withAlphaComponent(0.5).cgColor
            
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
