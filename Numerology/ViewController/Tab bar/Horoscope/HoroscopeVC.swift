//
//  HoroscopeVC.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit

//protocol RemoteOpenDelegate {
//    var openFrom: UIViewController? { get set }
//}

class HoroscopeVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    // MARK: - your Horoscope CV
    let yourHoroscopeCV: YourHoroscopeCV = {
        let cv = YourHoroscopeCV()
        cv.clipsToBounds = false
        return cv
    }()
    // MARK: - AboutYouCV
    let aboutYouCV: AboutYouCV = {
        let cv = AboutYouCV()
        cv.clipsToBounds = false
        return cv
    }()
    
    // MARK: - datingCalendarCV
    let datingCalendarCV: DatingCalendarCV = {
        let cv = DatingCalendarCV()
        cv.clipsToBounds = false
        return cv
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        // 2
        setupUI()
        remoteOpen()
        
    }
    
    private func remoteOpen() {
        // yourHoroscopeCV
        self.yourHoroscopeCV.remoteOpenDelegate = self
        self.yourHoroscopeCV.remoteOpenDelegate?.openFrom = self
        // aboutYouCV
        self.aboutYouCV.remoteOpenDelegate = self
        self.aboutYouCV.remoteOpenDelegate?.openFrom = self
        // datingCalendarCV
        self.datingCalendarCV.remoteOpenDelegate = self
        self.datingCalendarCV.remoteOpenDelegate?.openFrom = self
        self.openFrom = self
    }
}

// MARK: setup UI
extension HoroscopeVC {
    
    // Есть баг с большим NavBar проблема в этом VC скорее всего. Этот таб бар и нав бар + другой VC все норм.
    private func setupUI() {
        self.view.addSubview(contentScrollView) // 1
        
        // MARK: Content Stack
        let numerologyStack = UIStackView(arrangedSubviews: [
            yourHoroscopeCV,
            aboutYouCV,
            datingCalendarCV
        ])
        numerologyStack.translatesAutoresizingMaskIntoConstraints = false
        numerologyStack.axis = .vertical
        numerologyStack.alignment = .fill
        numerologyStack.spacing = 16
        
        // MARK: Content Stack
        let contentStack = UIStackView(arrangedSubviews: [numerologyStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .fill
        contentStack.spacing = 0
        
        contentScrollView.addSubview(contentStack)
        let viewMargin = self.view.layoutMarginsGuide
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            yourHoroscopeCV.heightAnchor.constraint(equalToConstant: 117+50),
            aboutYouCV.heightAnchor.constraint(equalToConstant: 117+50),
            
            datingCalendarCV.heightAnchor.constraint(equalToConstant: 390+50),

            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 40),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: scrollViewMargin.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            
            contentScrollView.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
}

