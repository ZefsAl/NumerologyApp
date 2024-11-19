//
//  HoroscopeDescriptionVC.swift
//  Numerology
//
//  Created by Serj on 28.11.2023.
//

import Foundation
import UIKit


class HoroscopeDescriptionVC: UIViewController, SegmentedControlCustomDelegate, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    // MARK: - Top Image
    private lazy var topImage: TopImage = TopImage(
        tint: DesignSystem.Horoscope.primaryColor,
        referenceView: self.view
    )
    
    
    let horoscopeCellViewModel = HoroscopeCellViewModel()
    
    let segmentedControlData: [String] = ["Today","Tomorrow","Week","Month","Year"]
    // MARK: - segmented Control
    lazy var segmentedControl: SegmentedControlHRSCP = {
        let sc = SegmentedControlHRSCP(items: segmentedControlData)
        sc.customDelegate = self
        sc.translatesAutoresizingMaskIntoConstraints = true
        return sc
    }()
    
    // Delegate
    func currentSegment(index: Int) {
        print("🟣✅ currentSegment", index)
        
        self.mainInfo.info.fadeTransition()
        self.learnMore.info.fadeTransition()
        
        // MARK: - check access
        guard self.checkAndShowPaywall() == true else {
            self.segmentedControl.selectedSegmentIndex = 0
            return
        }
        
        self.setTopBGImage(at: index)
        
        switch index {
        case 0:
            setInitialUIState()
            break
        case 1:
            DispatchQueue.main.async {
                self.learnMore.isHidden = true
                //
                self.horoscopeCellViewModel.setTomorrowData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                self.setSingleCardText(model: model)
                self.chartsCV.reloadData()
            }
            break
        case 2:
            DispatchQueue.main.async {
                self.learnMore.isHidden = true
                self.horoscopeCellViewModel.setWeekData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                // charts
                self.setSingleCardText(model: model)
                //
                self.chartsCV.reloadData()
            }
            break
        case 3:
            DispatchQueue.main.async {
                self.learnMore.isHidden = false
                //
                self.horoscopeCellViewModel.setMonthData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                // Main info
                self.mainInfo.accordionButton.setAccordionTitle("Month horoscope")
                self.mainInfo.info.text = model.text
                // learn More
                self.learnMore.accordionButton.setAccordionTitle("Main trends")
                self.learnMore.info.text = model.text2
                //
                self.chartsCV.reloadData()
            }
            break
        case 4:
            DispatchQueue.main.async {
                self.learnMore.isHidden = false
                self.horoscopeCellViewModel.setYearData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                // Main info
                self.mainInfo.accordionButton.setAccordionTitle("Year horoscope")
                self.mainInfo.info.text = model.text
                // learn More
                self.learnMore.accordionButton.setAccordionTitle("Main trends")
                self.learnMore.info.text = model.text2
                //
                self.chartsCV.reloadData()
            }
            break
            
        default: break;
        }
    }
    
    func setInitialUIState() {
        DispatchQueue.main.async {
            self.learnMore.isHidden = true
            //
            self.horoscopeCellViewModel.setTodayData()
            guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
            self.setSingleCardText(model: model)
            self.chartsCV.reloadData()
        }
    }
    
    func setSingleCardText(model: ChartCVCellModel) {
        self.mainInfo.accordionButton.setAccordionTitle(model.title)
        self.mainInfo.info.text = model.text
    }
    
    // MARK: - charts CV
    lazy var chartsCV: ContentCollectionView = {
        let cv = ContentCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.clipsToBounds = false
        return cv
    }()
    
    
    lazy var mainInfo: AccordionView = AccordionView()
    let learnMore: AccordionView = AccordionView()
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
//        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    // MARK: 🟢🔄 View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DesignSystem.Horoscope.primaryColor)
        // ui setup
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        setupStack()
        self.registerChartsCV()
        
        // Initial UI state
        if YourHoroscopeManager.shared.todayHoroscope == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(hrscpTodayDataUpdated), name: .hrscpTodayDataUpdated, object: nil)
        } else {
            self.hrscpTodayDataUpdated()
        }
        // Notofication
        NotificationCenter.default.addObserver(self, selector: #selector(hrscpImagesDataUpdated), name: .hrscpImagesDataUpdated, object: nil)
        // Default ui state
        setTopBGImage(at: 0)
    }
    
    // MARK: 🟢🔄 viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setInitialUIState()
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    // MARK: - Notification Action
    @objc private func hrscpTodayDataUpdated() {
        DispatchQueue.main.async {
            self.horoscopeCellViewModel.setTodayData()
            guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
            self.setSingleCardText(model: model)
            self.chartsCV.reloadData()
        }
    }
    // MARK: - Notification hrscp Action
    @objc private func hrscpImagesDataUpdated() {
        setTopBGImage(at: segmentedControl.selectedSegmentIndex)
    }
    
    private func setTopBGImage(at index: Int) {
        if let images = YourHoroscopeManager.shared.yourHrscpImages,
           let title = segmentedControl.titleForSegment(at: index),
           let image = images[title] {
            // Set top Image
            self.topImage.fadeTransition()
            self.topImage.image = image
        }
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let cardContentStack = UIStackView(arrangedSubviews: [
            segmentedControl,
            chartsCV,
            mainInfo,
            learnMore
        ])
        cardContentStack.translatesAutoresizingMaskIntoConstraints = false
        cardContentStack.axis = .vertical
        cardContentStack.spacing = 16
        
        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = DesignSystem.maxCornerRadius
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = DesignSystem.maxCornerRadius
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
            return v
        }()
        cardView.addSubview(cardContentStack)
        
        let contentStack = UIStackView(arrangedSubviews: [
            topImage,
            cardView
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .center
        
        // add
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            // cardContentStack
            cardContentStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            cardContentStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            cardContentStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            cardContentStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            // card View
            cardView.widthAnchor.constraint(equalTo: contentStack.widthAnchor,constant: -36),
            // content Stack
            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: 0),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -0),
            // content Scroll View
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

