//
//  NumerologyVC_2024.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.04.2024.
//

import Foundation
import UIKit

class NumerologyVC_2024: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: - yournumerology CV - 1
    let yournumerologyCV: YourNumerologyCV_2024 = {
        let cv = YourNumerologyCV_2024()
        cv.clipsToBounds = false
        return cv
    }()
    // MARK: - personal Predictions CV - 2
    let dateCompatibilityCV: DateCompatibilityCV = {
        let cv = DateCompatibilityCV()
        cv.clipsToBounds = false
        cv.isScrollEnabled = false 
        return cv
    }()
    // MARK: - your Money CV - 3
    let yourMoneyCV: YourMoneyCV = {
        let cv = YourMoneyCV()
        cv.clipsToBounds = false
        return cv
    }()
    // MARK: - personal Predictions CV - 4
    let personalPredictionsCV: PersonalPredictionsCV_2024 = {
        let cv = PersonalPredictionsCV_2024()
        cv.clipsToBounds = false
        return cv
    }()
    // MARK: - personal Predictions CV - 5
    let angelNumbersCV: AngelNumbersCV = {
        let cv = AngelNumbersCV()
        cv.clipsToBounds = false
        return cv
    }()
    // MARK: - about  - 6
    let aboutCV: AboutCV = {
        let cv = AboutCV()
        cv.clipsToBounds = false
        return cv
    }()
    // MARK: - pythagorean Square CV - 7
    let pythagoreanSquareCV: PythagoreanSquareCV = {
        let cv = PythagoreanSquareCV()
        cv.clipsToBounds = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        setBackground(named: "MainBG3")
        AnimatableBG().setBackground(vc: self)
        // 2
        setupUI()
        remoteOpen()
    }
    
    private func remoteOpen() {
        // date Compatibility CV
        dateCompatibilityCV.remoteOpenDelegate = self
        dateCompatibilityCV.remoteOpenDelegate?.openFrom = self
        // your numerology CV
        yournumerologyCV.remoteOpenDelegate = self
        yournumerologyCV.remoteOpenDelegate?.openFrom = self
        // personal Predictions CV
        personalPredictionsCV.remoteOpenDelegate = self
        personalPredictionsCV.remoteOpenDelegate?.openFrom = self
        // about CV
        aboutCV.remoteOpenDelegate = self
        aboutCV.remoteOpenDelegate?.openFrom = self
        // your Money CV
        yourMoneyCV.remoteOpenDelegate = self
        yourMoneyCV.remoteOpenDelegate?.openFrom = self
        // angel Numbers CV
        angelNumbersCV.remoteOpenDelegate = self
        angelNumbersCV.remoteOpenDelegate?.openFrom = self
        // pythagorean Square CV
        pythagoreanSquareCV.remoteOpenDelegate = self
        pythagoreanSquareCV.remoteOpenDelegate?.openFrom = self
        
        self.openFrom = self
    }
}

// MARK: setup UI
extension NumerologyVC_2024 {
    
    // Есть баг с большим NavBar проблема в этом VC скорее всего. Этот таб бар и нав бар + другой VC все норм.
    private func setupUI() {
        self.view.addSubview(contentScrollView) // 1
        
        // MARK: Content Stack
        let numerologyStack = UIStackView(arrangedSubviews: [
            pythagoreanSquareCV,
            yournumerologyCV,
            dateCompatibilityCV,
            yourMoneyCV,
            personalPredictionsCV,
            angelNumbersCV,
            aboutCV
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
            aboutCV.heightAnchor.constraint(equalToConstant: 110+50),
            dateCompatibilityCV.heightAnchor.constraint(equalToConstant: 108+50),
            angelNumbersCV.heightAnchor.constraint(equalToConstant: 112+50),
            pythagoreanSquareCV.heightAnchor.constraint(equalToConstant: 300+50),

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

