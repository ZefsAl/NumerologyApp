//
//  FourthViewController.swift
//  Numerology
//
//  Created by Serj on 06.08.2023.
//

import UIKit

class AboutNumerologyDetailVC: UIViewController {
    
    // MARK: - Top Image
    private lazy var topImage: TopImage = TopImage(
        tint: DesignSystem.Numerology.primaryColor,
        referenceView: self.view
    )
    
    private let verticalScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: Description
    let descriptionText: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let contentStack = UIStackView()
    
    // MARK: view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DesignSystem.Numerology.primaryColor)
        //
        setBackground(named: "MainBG2")
        setupStack()
        requestFB()
        // Notification
        self.numerologyImagesDataUpdated()
        NotificationCenter.default.addObserver(self, selector: #selector(numerologyImagesDataUpdated), name: .numerologyImagesDataUpdated, object: nil)
        
    }
    
    @objc private func numerologyImagesDataUpdated() {
        NumerologyImagesManager.shared.setTopImage(self.topImage, key: .aboutNumerology)
    }
    
    func requestFB() {
        NumerologyManager.shared.getNumerologyIs { arr in
            for item in arr.sorted(by: { $0.number < $1.number }) {
                if item.number == 123 {
                    self.descriptionText.text = item.infoNumerology
                } else {
                    let descriptionView = DescriptionView(frame: .zero, description: item.infoNumerology, number: item.number)
                    self.contentStack.addArrangedSubview(descriptionView)
                }
            }
        }
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        self.view.addSubview(verticalScrollView)
        
        // Content Stack
        contentStack.addArrangedSubview(descriptionText)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 32
        
        contentStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentStack.isLayoutMarginsRelativeArrangement = true
        
        // Style
        contentStack.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        contentStack.layer.cornerRadius = DesignSystem.maxCornerRadius
        contentStack.layer.borderWidth = DesignSystem.borderWidth
        contentStack.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        contentStack.layer.shadowOpacity = 1
        contentStack.layer.shadowRadius = 16
        contentStack.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentStack.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
        
        verticalScrollView.addSubview(topImage)
        verticalScrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: verticalScrollView.topAnchor),
            topImage.centerXAnchor.constraint(equalTo: verticalScrollView.centerXAnchor),
            //
            contentStack.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 18),
            contentStack.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor, constant: -36),

            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}
