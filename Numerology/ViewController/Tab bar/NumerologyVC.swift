//
//  NumerologyVC.swift
//  Numerology
//
//  Created by Serj on 20.10.2023.
//

import UIKit

protocol RemoteOpenDelegate {
    var openFrom: UIViewController? { get set }
}

class NumerologyVC: UIViewController, RemoteOpenDelegate {
    
    var openFrom: UIViewController?
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: - personal Predictions CV
    let dateCompatibilityCV: DateCompatibilityCV = {
        let cv = DateCompatibilityCV()
        return cv
    }()
    // MARK: - yournumerology CV
    let yournumerologyCV: YourNumerologyCV = {
        let cv = YourNumerologyCV()
        return cv
    }()
    // MARK: - personal Predictions CV
    let personalPredictionsCV: PersonalPredictionsCV = {
        let cv = PersonalPredictionsCV()
        return cv
    }()
    // MARK: - personal Predictions CV
    let aboutCV: AboutCV = {
        let cv = AboutCV()
        return cv
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
        setupUI()
        remoteOpen()
        
        setBackground(named: "MainBG3")
        AnimatableBG().setBackground(vc: self)
    }
    
    private func remoteOpen() {
        // dateCompatibilityCV
        dateCompatibilityCV.remoteOpenDelegate = self
        dateCompatibilityCV.remoteOpenDelegate?.openFrom = self
        // yournumerologyCV
        yournumerologyCV.remoteOpenDelegate = self
        yournumerologyCV.remoteOpenDelegate?.openFrom = self
        // personalPredictionsCV
        personalPredictionsCV.remoteOpenDelegate = self
        personalPredictionsCV.remoteOpenDelegate?.openFrom = self
        // aboutCV
        aboutCV.remoteOpenDelegate = self
        aboutCV.remoteOpenDelegate?.openFrom = self
        //
        self.openFrom = self
    }
}

// MARK: setup UI
extension NumerologyVC {
    
    // Есть баг с большим NavBar проблема в этом VC скорее всего. Этот таб бар и нав бар + другой VC все норм.
    private func setupUI() {
        self.view.addSubview(contentScrollView) // 1
        
        // MARK: Content Stack
        let numerologyStack = UIStackView(arrangedSubviews: [
            dateCompatibilityCV,
            yournumerologyCV,
            personalPredictionsCV,
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
            dateCompatibilityCV.heightAnchor.constraint(equalToConstant: 160+50),
            yournumerologyCV.heightAnchor.constraint(equalToConstant: 160+50+30),
            personalPredictionsCV.heightAnchor.constraint(equalToConstant: 160+50+30),

            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 40),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: scrollViewMargin.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])   
    }
}

