//
//  AngelNumbersVC.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.04.2024.
//

import UIKit



class DetailAngelNumbersVC: UIViewController, RemoteOpenDelegate  {
    
    var openFrom: UIViewController?
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        sv.clipsToBounds = false
        return sv
    }()
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.textAlignment = .center
        l.font = UIFont(name: "Cinzel-Regular", size: 26)
        l.sizeToFit()
        l.text = "Enigmatic Angelic Signs"
        return l
    }()
    
    let descriptionCardView: DescriptionCardView = {
       let v = DescriptionCardView()
        return v
    }()
    
    let detailAngelNumbersSignsCV: DetailAngelNumbersSignsCV = {
        let cv = DetailAngelNumbersSignsCV()
        if let collectionViewLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        cv.clipsToBounds = false
        cv.register()
        return cv
    }()
    
    
    let contentStackSV = UIStackView(arrangedSubviews: [])
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems()
        //
        self.setBackground(named: "MainBG3.png")
        AnimatableBG().setBackground(vc: self)
        setupStack()
        //
        self.detailAngelNumbersSignsCV.remoteOpenDelegate = self
        self.openFrom = self
        //
        configureViewData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.requestReview()
    }
    
    
    func configureViewData() {
        let color = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        
        NumerologyManager.shared.getAngelNumbers(stringNumber: "info") { model in
            self.descriptionCardView.configure(
                title: "About numbers",
                info: model.info,
                about: nil,
                tintColor: color
            )
        }
    }

    // MARK: Set up Stack
    private func setupStack() {
        
        // content Stack
        contentStackSV.addArrangedSubview(titleLabel)
        contentStackSV.addArrangedSubview(detailAngelNumbersSignsCV)
        contentStackSV.addArrangedSubview(descriptionCardView)
        // setup
        contentStackSV.translatesAutoresizingMaskIntoConstraints = false
        contentStackSV.alignment = .fill
        contentStackSV.axis = .vertical
        contentStackSV.distribution = .fill
        contentStackSV.spacing = 12
        // add
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackSV)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            // 1
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            // 2
            contentStackSV.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 16),
            contentStackSV.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStackSV.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStackSV.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStackSV.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
        ])
    }

}
