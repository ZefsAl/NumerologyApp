//
//  DetailCompatibilityHrscpVC.swift
//  Numerology
//
//  Created by Serj on 23.01.2024.
//

import UIKit

class DetailCompatibilityHrscpVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    private let vcAccentColor: UIColor = DS.Horoscope.primaryColor
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: - Signs
    private lazy var compareSignsStackView: CompareSignsStackView = {
        let sv = CompareSignsStackView(frame: .null, accentColor: vcAccentColor)
        return sv
    }()
    
    // MARK: - Charts
    let chartsCV: ContentCollectionView = {
        let cv = ContentCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.clipsToBounds = false
        return cv
    }()
    
    lazy var chartsDescriptionDataCV = [ChartCVCellModel]()
    
    lazy var accordionView: PremiumAccordionView = {
       let v = PremiumAccordionView(
        title: "",
        info: "",
        isPremium: true,
        visibleConstant: DeviceMenager.isSmallDevice ? 75 : 200
       )
        v.remoteOpenDelegate = self
        v.remoteOpenDelegate?.openFrom = self
       return v
   }()
    
    // MARK: - init
    init(compatibilityHrscpModel: CompatibilityHrscpModel, secondSign: String) {
        super.init(nibName: nil, bundle: nil)
        self.register()
        self.setChartsData(model: compatibilityHrscpModel)
        self.firstSignConfigure()
        self.secondSignConfigure(sign: secondSign) // использовать Model вместо secondSign
        self.accordionView.accordionButton.setAccordionTitle("Generally")
        self.accordionView.sharedData.data = compatibilityHrscpModel.aboutThisSign
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - register
    private func register() {
        // delegate
        self.openFrom = self
        //
        self.chartsCV.delegate = self
        self.chartsCV.dataSource = self
        self.chartsCV.register(ChartCVCell.self, forCellWithReuseIdentifier: ChartCVCell.reuseID)
    }
    
    // config 1
    private func firstSignConfigure() {
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        let sign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
        //
        let model = CompatibilityData.compatibilitySignsData.filter({$0.sign.lowercased() == sign.lowercased()}).first
        self.compareSignsStackView.firstSignModel = model
    }
    
    // config 2
    private func secondSignConfigure(sign: String) {
        let model = CompatibilityData.compatibilitySignsData.filter({$0.sign.lowercased() == sign.lowercased()}).first
        self.compareSignsStackView.secondSignModel = model
    }
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DS.Horoscope.primaryColor)
        //
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        //
        setupStack()
    }

    // MARK: Set up Stack
    private func setupStack() {
        
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
            v.layer.cornerRadius = DS.maxCornerRadius
            v.layer.borderWidth = DS.borderWidth
            v.layer.borderColor = self.vcAccentColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = DS.maxCornerRadius
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
            compareSignsStackView,
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

