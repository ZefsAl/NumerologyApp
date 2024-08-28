//
//  PaywallVC_V2.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit
import RevenueCat
import SafariServices
import AVFoundation


final class SpecialOfferPaywall: UIViewController {
    
    //
    let cardContentStack = UIStackView()
    
    //
    private let player = AVPlayer()
    
    // MARK: store Product Arr
    var storeProductArr: [StoreProduct]? {
        didSet {
            self.storeProductArr = storeProductArr?.sorted(by: { one, two in
                one.price > two.price
            })
        }
    }
    
    // MARK: - main Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 1
        l.text = "Last chance"
        return l
    }()
    
    // MARK: - main Title
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 0
        // Text
        let stringToColor = "(Limited-time offer)"
        let mainString = """
        Unlock the secrets of your destiny and find inner peace. Take control of your future with up to 80% off and access all exclusive content!
        \(stringToColor)
        """
        let range = (mainString as NSString).range(of: stringToColor)
        
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.lightGray,
            range: range
        )
        l.attributedText = mutableAttributedString
        return l
    }()
    
    // MARK: Collection View
    private let productsCollectionView: ContentCollectionView = {
        var cv = ContentCollectionView()
        return cv
    }()
    
    // MARK: - config Compositional Layout CV
    private func configCompositionalLayoutCV(absoluteCellWidth: CGFloat, cvHeight: CGFloat ) {
        // iphone 12
        
        // Fill Width for cells by screen - Хорошее решение но конфликтует с авто высотой и не отображается, только в ViewController будет работать или указать высоту явно
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.absolute(absoluteCellWidth),
            heightDimension: NSCollectionLayoutDimension.estimated(85)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 18
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.productsCollectionView.collectionViewLayout = layout
        self.productsCollectionView.heightAnchor.constraint(equalToConstant: cvHeight).isActive = true // 😢
        
    }
    
    // MARK: - config Flow Layout CV
    private func configFlowLayoutCV() {
        // iphone 8
        // For size cell by content + Constraints in Cell
        if let collectionViewLayout = productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.minimumInteritemSpacing = 0
        }
    }
    
    
    // MARK: - register Cells
    private func registerCells() {
        productsCollectionView.register(SpecialOfferCVCell.self, forCellWithReuseIdentifier: SpecialOfferCVCell.reuseID)
    }
    
    
    // MARK: Purchase Button
    private let purchaseButton: PurchaseButton = {
        let b = PurchaseButton(
            title: "Continue",
            primaryColor: DesignSystem.PaywallTint.primaryPaywall,
            tapToBounce: false
        )
        b.addTarget(Any?.self, action: #selector(actPurchaseButton), for: .touchUpInside)
        return b
    }()
    
    // MARK: - ➡️ Purchase Action
    @objc private func actPurchaseButton() {
        // Loader
        self.purchaseButton.activityIndicatorView.startAnimating()
        
        // product
        guard let product = self.storeProductArr?.first else { return }
        
        // Purchase
        Purchases.shared.purchase(product: product) { transaction, customerInfo, error, userCancelled in
            self.purchaseButton.activityIndicatorView.stopAnimating()
            print("🟠 Check Access",customerInfo?.entitlements["Access"]?.isActive as Any)
            if customerInfo?.entitlements["Access"]?.isActive == true {
                self.dismissAction()
            }
        }
        
    }
    
    
    // MARK: Terms Button
    private let termsButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Terms Of Use", for: .normal)
        b.titleLabel?.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(termsOfUseAct), for: .touchUpInside)
        return b
    }()
    // MARK: - ➡️ terms
    @objc private func termsOfUseAct() {
        print("termsOfUseAct")
        
        guard let url = URL(string: "https://numerology-terms.web.app/") else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .pageSheet
            self.present(safariVC, animated: true)
        }
    }
    
    // MARK: Privacy Button
    private let privacyButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Privacy Policy", for: .normal)
        b.titleLabel?.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(privacyPolicyAct), for: .touchUpInside)
        return b
    }()
    // MARK: - ➡️ privacy
    @objc private func privacyPolicyAct() {
        guard let url = URL(string: "https://numerology-privacy.web.app/") else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .pageSheet
            self.present(safariVC, animated: true)
        }
    }
    
    // MARK: Restore Button
    private let restoreButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Restore purchases", for: .normal)
        b.titleLabel?.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(restoreAct), for: .touchUpInside)
        return b
    }()
    // MARK: - ➡️ restore
    @objc private func restoreAct() {
        print("Restore purchases")
        
        Purchases.shared.restorePurchases { (customerInfo, error) in
            // проверить есть ли подписка -> Предоставить доступ
            if customerInfo?.entitlements.all["Access"]?.isActive == true {
                print("✅User restored!")
                self.showAlert(
                    title: "Purchases restored",
                    message: nil) {
                        self.dismiss(animated: true)
                    }
            } else {
                print("❌User not restored")
                self.showAlert(
                    title: "Purchases not restored",
                    message: "We couldn't find your purchases") {}
            }
        }
    }
    
    // MARK: - closeButton
    private let closeButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        let configImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
        let iv = UIImageView(image: configImage)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .systemGray
        iv.isUserInteractionEnabled = false
        b.addSubview(iv)
        b.heightAnchor.constraint(equalToConstant: 20).isActive = true
        b.widthAnchor.constraint(equalToConstant: 20).isActive = true
        b.addTarget(Any?.self, action: #selector(dismissAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: - Dismiss Action
    @objc private func dismissAction() {
        self.dismiss(animated: true)
    }
    
    // MARK: 🟢 viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Background
        self.setBG()
        // Animation
        CustomAnimation.setPulseAnimation(to: self.purchaseButton, toValue: 1, fromValue: 0.90)
        // UI
        setupUI()
        // Delegate
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        // Register
        registerCells()
        // In-App
        initializeIAP()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.player.pause()
    }
    
    private func setBG() {
        self.setBackground(named: "PaywallRadialBG") // plug!
        self.setLoopedVideoLayer(
            player: self.player,
            named: "SpecialOffer",
            to: self.view,
            margins: UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: DeviceMenager.isSmallDevice ? 100 : 250,
                right: 0
            )
        )
    }
    
    // MARK: setup UI
    private func setupUI() {
        
        // MARK: Bottom Side Stack
        let topTextStack = UIStackView(arrangedSubviews: [mainTitle, subtitle])
        topTextStack.translatesAutoresizingMaskIntoConstraints = false
        topTextStack.axis = .vertical
        topTextStack.alignment = .center
        topTextStack.distribution = .fill
        topTextStack.spacing = 4
        
        // MARK: Docs Stack
        let docsStack = UIStackView(arrangedSubviews: [termsButton,restoreButton,privacyButton])
        docsStack.axis = .horizontal
        docsStack.spacing = 0
        docsStack.distribution = .fillEqually
        
        // MARK: Bottom Side Stack
        cardContentStack.addSystemBlur(to: cardContentStack, style: .systemThinMaterialDark)
        // Add
        cardContentStack.addArrangedSubview(topTextStack)
        cardContentStack.addArrangedSubview(productsCollectionView)
        cardContentStack.addArrangedSubview(purchaseButton)
        cardContentStack.addArrangedSubview(docsStack)
        // Configure
        cardContentStack.translatesAutoresizingMaskIntoConstraints = false
        cardContentStack.axis = .vertical
        cardContentStack.alignment = .center
        cardContentStack.distribution = .fill
        cardContentStack.spacing = 18
        cardContentStack.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 0, right: 18)
        
        cardContentStack.layoutMargins = UIEdgeInsets(
            top: 18,
            left: 18,
            bottom: self.view.layoutMargins.bottom+6,
            right: 18
        )
        
        cardContentStack.isLayoutMarginsRelativeArrangement = true
        // Corner
        cardContentStack.layer.cornerRadius = DesignSystem.maxCornerRadius
        cardContentStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cardContentStack.clipsToBounds = true
        
        // MARK: Main Stack
        let mainStack = UIStackView(arrangedSubviews: [
            cardContentStack
        ])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        
        // Add addSubview
        self.view.addSubview(mainStack)
        self.view.addSubview(closeButton)
        let viewMargin = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            //
            closeButton.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: viewMargin.trailingAnchor),
            //
            mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
        // At the end
        setAdapttiveLayout()
    }
    
    // MARK: - Adapttive
    private func setAdapttiveLayout() {
        //
        let cellWidth: CGFloat = DeviceMenager.isSmallDevice ? 176 : 200
        // Layout CV
        self.configCompositionalLayoutCV(absoluteCellWidth: cellWidth, cvHeight: DeviceMenager.isSmallDevice ? 104 : 128)
        //
        self.mainTitle.font = .setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 24 : 35)
        self.subtitle.font = .setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 15 : 17)
        // Constraints
        NSLayoutConstraint.activate([
            self.productsCollectionView.widthAnchor.constraint(equalToConstant: cellWidth),
            self.purchaseButton.widthAnchor.constraint(equalTo: cardContentStack.widthAnchor, constant: -36),
            self.purchaseButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}


// MARK: - Products delegate
extension SpecialOfferPaywall: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.storeProductArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = self.storeProductArr?[indexPath.row]
        //
        guard let product = product else { return UICollectionViewCell() }
        
        // MARK: - Config cells
        
        let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialOfferCVCell.reuseID, for: indexPath as IndexPath) as! SpecialOfferCVCell
        
        bigCell.configure(
            discount: "special proposal🔥".capitalized,
            title: "\(product.localizedTitle)",
            subtitle: "Was 119.99 $",
            price: "\(product.localizedPriceString) / one-time"
        )
        
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        self.purchaseButton.buttonStateConfig(state: true)
        
        return bigCell
        
    }
}



// MARK: Initialize IAP
extension SpecialOfferPaywall {
    
    func initializeIAP() {
        
        // MARK: IDs
        let productIDs: [String] = ["Lifetime.Purchase"]
        
        // MARK: get Products
        Purchases.shared.getProducts(productIDs) { arr in
            self.storeProductArr = arr
            //
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
    }
}

