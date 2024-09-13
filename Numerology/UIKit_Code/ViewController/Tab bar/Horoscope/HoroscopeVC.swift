//
//  HoroscopeVC.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit

class HoroscopeVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    // MARK: - your Horoscope CV
    let yourHoroscopeCV: YourHoroscopeCV = {
        let cv = YourHoroscopeCV()
        cv.clipsToBounds = false
        return cv
    }()
    
    // MARK: - CharismaCV
    let charismaCV: CharismaCV = {
        let cv = CharismaCV()
        cv.clipsToBounds = false
        return cv
    }()
    
    // MARK: - money Calendar CV
    let moneyCalendarCV: MoneyCalendarCV = {
        let cv = MoneyCalendarCV()
        cv.clipsToBounds = false
        cv.isScrollEnabled = false 
        return cv
    }()
    
    // MARK: - datingCalendarCV
    let compatibilityHrscpView: CompatibilityHrscpPickerView = CompatibilityHrscpPickerView()
    
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        // 2
        setupUI()
        remoteOpen()
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        HoroscopeCellViewModel.shared.setTodayData()
    }
    
    private func remoteOpen() {
        // compatibilityHrscpView
        self.compatibilityHrscpView.remoteOpenDelegate = self
        self.compatibilityHrscpView.remoteOpenDelegate?.openFrom = self
        // yourHoroscopeCV
        self.yourHoroscopeCV.remoteOpenDelegate = self
        self.yourHoroscopeCV.remoteOpenDelegate?.openFrom = self
        // aboutYouCV
        self.charismaCV.remoteOpenDelegate = self
        self.charismaCV.remoteOpenDelegate?.openFrom = self
        // datingCalendarCV
        self.moneyCalendarCV.remoteOpenDelegate = self
        self.moneyCalendarCV.remoteOpenDelegate?.openFrom = self
        self.openFrom = self
    }
}

// MARK: setup UI
extension HoroscopeVC {

    private func setupUI() {
        self.view.addSubview(contentScrollView)
        
        // MARK: Content Stack
        let numerologyStack = UIStackView(arrangedSubviews: [
            charismaCV,
            yourHoroscopeCV,
            compatibilityHrscpView,
            moneyCalendarCV
        ])
        numerologyStack.translatesAutoresizingMaskIntoConstraints = false
        numerologyStack.axis = .vertical
        numerologyStack.alignment = .fill
        numerologyStack.spacing = 32
        
        // MARK: Content Stack
        let contentStack = UIStackView(arrangedSubviews: [numerologyStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .fill
        contentStack.spacing = 0
        
        contentScrollView.addSubview(contentStack)

        let viewMargin = self.view.layoutMarginsGuide
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        let statusBar: CGFloat = UIApplication.shared.statusBarFrame.height
        
        NSLayoutConstraint.activate([
            yourHoroscopeCV.heightAnchor.constraint(equalToConstant: 370+50),
            moneyCalendarCV.heightAnchor.constraint(equalToConstant: 390+50),

            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: statusBar+12),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: scrollViewMargin.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: viewMargin.bottomAnchor, constant: 0),
            
        ])
    }
}

