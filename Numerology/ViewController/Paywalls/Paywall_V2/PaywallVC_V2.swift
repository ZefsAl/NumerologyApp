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


final class PaywallVC_V2: UIViewController {
    
    var onboardingIsCompleted: Bool?
    
    private let player = AVPlayer()
    
    // MARK: store Product Arr
    var storeProductArr: [StoreProduct]? {
        didSet {
            self.storeProductArr = storeProductArr?.sorted(by: { one, two in
                one.price > two.price
            })
        }
    }
    
    // MARK: Carousel CV
    private let customCarousel_CV: CustomCarousel_CV = {
        let cv = CustomCarousel_CV()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: Collection View
    private let productsCollectionView: ContentCollectionView = ContentCollectionView()
    
    // MARK: - register Cells
    private func registerCells() {
        self.productsCollectionView.register(BigPromoCVCell.self, forCellWithReuseIdentifier: BigPromoCVCell.reuseID)
        self.productsCollectionView.register(MiniPromoCVCell.self, forCellWithReuseIdentifier: MiniPromoCVCell.reuseID)
    }
    
    // MARK: Main Promo Title
    private let mainPromoTitle: UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.6980392157, green: 0.6901960784, blue: 0.9725490196, alpha: 1)
        l.numberOfLines = 0
        l.textAlignment = .center
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Get full access!",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        l.font = UIFont(name: "Cinzel-Regular", size: 44)
        return l
    }()
    
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
    
    // MARK: Purchase Action
    @objc private func actPurchaseButton() {
        // Get product index
        let index = self.productsCollectionView.indexPathsForSelectedItems?.first?.row
        guard let index = index else { return }
        guard let storeProductIndex = self.storeProductArr?[index] else { return }
        self.purchaseButton.activityIndicatorView.startAnimating()
        
        if trialOfferSwitch.isOn && storeProductIndex.productIdentifier == "Year_29.99" {
            Purchases.shared.getProducts(["Yearly.Trial"]) { arr in
                //                print("💰 Trial ---",arr.first?.productIdentifier)
                guard let product = arr.first else { return }
                Purchases.shared.purchase(product: product) { transaction, customerInfo, error, userCancelled in
                    self.purchaseButton.activityIndicatorView.stopAnimating()
                    if customerInfo?.entitlements["Access"]?.isActive == true {
                        //                        print("🟠",customerInfo?.entitlements["Access"]?.isActive)
                        self.dismissAction()
                    }
                }
            }
            
        } else {
            //            print(storeProductIndex.productIdentifier)
            Purchases.shared.purchase(product: storeProductIndex) { transaction, customerInfo, error, userCancelled in
                self.purchaseButton.activityIndicatorView.stopAnimating()
                if customerInfo?.entitlements["Access"]?.isActive == true {
                    //                    print("🟠",customerInfo?.entitlements["Access"]?.isActive)
                    self.dismissAction()
                }
            }
        }
    }
    
    // MARK: Trial Offer Lable
    private let trialOfferLable: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.numberOfLines = 0
        l.textAlignment = .left
        l.text =  "Not sure yet? Enable free trial!"
        return l
    }()
    
    // MARK: Trial Offer Switch
    private let trialOfferSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(Any?.self, action: #selector(switchAction), for: .touchUpInside)
        // on
        s.onTintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.7921568627, alpha: 1)
        // off
//        let off = DesignSystem.PaywallTint.primaryDarkBG
//        s.tintColor = off
//        s.layer.cornerRadius = s.frame.height / 2.0
//        s.backgroundColor = off
//        s.clipsToBounds = true
        
        return s
    }()
    
    
    // MARK: Switch Action
    @objc private func switchAction(_ sender: UISwitch) {
        trialOfferLable.fadeTransition()
        guard sender.isOn == true else {
            self.trialOfferLable.text = "Not sure yet? Enable free trial!"
            return
        }
        self.purchaseButton.buttonStateConfig(state: true)
        self.trialOfferLable.text = "7-day FREE trial enable"
    }
    
    
    // MARK: Terms Button
    private let termsButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Terms Of Use", for: .normal)
        b.titleLabel?.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(Any?.self, action: #selector(termsOfUseAct), for: .touchUpInside)
        return b
    }()
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
        b.setTitle("Privacy Policy", for: .normal)
        b.titleLabel?.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(Any?.self, action: #selector(privacyPolicyAct), for: .touchUpInside)
        return b
    }()
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
        b.setTitle("Restore purchases", for: .normal)
        b.titleLabel?.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(Any?.self, action: #selector(restoreAct), for: .touchUpInside)
        return b
    }()
    
    @objc private func restoreAct() {
        print("⚠️ Start Restore purchases")
        
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
        let b = UIButton() // customView: type
        b.translatesAutoresizingMaskIntoConstraints = false
        //
        let configImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
        let iv = UIImageView(image: configImage)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .systemGray
        iv.isUserInteractionEnabled = false
        //
        b.addSubview(iv)
        b.heightAnchor.constraint(equalToConstant: 20).isActive = true
        b.widthAnchor.constraint(equalToConstant: 20).isActive = true
        b.addTarget(Any?.self, action: #selector(dismissAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: - Dismiss Action
    @objc private func dismissAction() {
        guard let bool = onboardingIsCompleted else { return }
        if bool {
            self.dismiss(animated: true)
        } else {
            AppRouter.shared.setAppFlow(.app, animated: true)
        }
    }
    
    
    // MARK: 🟢 viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Background
        setBG()
        // Animation
        CustomAnimation.setPulseAnimation(to: self.purchaseButton, toValue: 1, fromValue: 0.90)
        // UI
        setAdaptiveStyle()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.customCarousel_CV.timer.invalidate()
        self.player.pause()
    }
    
    // MARK: - init
    init(onboardingIsCompleted: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.onboardingIsCompleted = onboardingIsCompleted
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBG() {
        self.view.backgroundColor = .hexColor("110F2D")
        self.setLoopedVideoLayer(
            player: self.player,
            named: "Paywall",
            to: self.view,
            margins: UIEdgeInsets(top: 0,left: 0,bottom: DeviceMenager.isSmallDevice ? 0 : 150,right: 0)
        )
    }
    
    // MARK: - set Adaptive Style
    private func setAdaptiveStyle() {
        //
        self.trialOfferLable.font = (
            DeviceMenager.isSmallDevice ?
            DesignSystem.SourceSerifProFont.footnote_Sb_13 :
            DesignSystem.SourceSerifProFont.subtitle_Sb_15
        )
    }
    
    // MARK: 🌕 Setup UI
    private func setupUI() {
        
        
        // MARK: Bottom Side Stack
        let topSideStack = UIStackView(arrangedSubviews: [mainPromoTitle])
        topSideStack.translatesAutoresizingMaskIntoConstraints = false
        topSideStack.axis = .vertical
        topSideStack.alignment = .center
        topSideStack.distribution = .fill
        topSideStack.spacing = 0
        topSideStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
        topSideStack.isLayoutMarginsRelativeArrangement = true
        
        // MARK: Docs Stack
        let docsStack = UIStackView(arrangedSubviews: [termsButton,restoreButton,privacyButton])
        docsStack.axis = .horizontal
        docsStack.spacing = 0
        docsStack.distribution = .fillEqually
        
        // MARK: Subscription Stack
        let trialOfferStack = UIStackView(arrangedSubviews: [trialOfferLable, trialOfferSwitch])
        trialOfferStack.axis = .horizontal
        trialOfferStack.alignment = .center
        trialOfferStack.spacing = 0
        trialOfferStack.layoutMargins = UIEdgeInsets(top: 0,left: 18,bottom: 0,right: 18)
        trialOfferStack.isLayoutMarginsRelativeArrangement = true
        trialOfferStack.backgroundColor = DesignSystem.PaywallTint.secondaryDarkBG
        trialOfferStack.layer.cornerRadius = DeviceMenager.isSmallDevice ? DesignSystem.midCornerRadius : DesignSystem.maxCornerRadius-2
        
        // MARK: Product Controls Stack
        let productControlsStack = UIStackView(arrangedSubviews: [
            trialOfferStack,
            productsCollectionView,
        ])
        productControlsStack.axis = .vertical
        productControlsStack.alignment = .fill
        productControlsStack.distribution = .fill
        productControlsStack.spacing = 12
        
        // MARK: Bottom Side Stack
        let cardContentStack = UIStackView(arrangedSubviews: [
            productControlsStack,
            purchaseButton,
            docsStack
        ])
        cardContentStack.translatesAutoresizingMaskIntoConstraints = false
        cardContentStack.axis = .vertical
        cardContentStack.alignment = .fill
        cardContentStack.distribution = .fill
        cardContentStack.spacing = 18
        cardContentStack.layoutMargins = UIEdgeInsets(
            top: 18,
            left: 18,
            bottom: self.view.layoutMargins.bottom+6,
            right: 18
        )
        cardContentStack.isLayoutMarginsRelativeArrangement = true
        cardContentStack.layer.cornerRadius = DesignSystem.maxCornerRadius
        cardContentStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cardContentStack.backgroundColor = DesignSystem.PaywallTint.primaryDarkBG.withAlphaComponent(0.9)
        
        // MARK: Main Stack
        let mainStack = UIStackView(arrangedSubviews: [
            topSideStack,
            customCarousel_CV,
            cardContentStack
        ])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 0
        
        // Add addSubview
        self.view.addSubview(mainStack)
        self.view.addSubview(closeButton)
        let viewMargin = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            trialOfferStack.heightAnchor.constraint(equalToConstant: DeviceMenager.isSmallDevice ? 50 : 60),
            docsStack.heightAnchor.constraint(equalToConstant: 16),
            purchaseButton.heightAnchor.constraint(equalToConstant: 60),
            closeButton.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: viewMargin.trailingAnchor),
            customCarousel_CV.heightAnchor.constraint(equalToConstant: 183),
            //
            mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
    }
}


// MARK: - 🟢 Products delegate
extension PaywallVC_V2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.storeProductArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = self.storeProductArr?[indexPath.row]
        
        guard let product = product else { return UICollectionViewCell() }
        
        // MARK: - Config cells
            return longCellsConfig(product: product, collectionView: collectionView, indexPath: indexPath)
    }
    
    // MARK: - long Cells Config
    private func longCellsConfig(product: StoreProduct, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // Config Cell normal case
        if indexPath.row == 0 {
            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPromoCVCell.reuseID, for: indexPath as IndexPath) as! BigPromoCVCell
            bigCell.configure(
                discount: "save 68%".uppercased(),
                title: "\(product.localizedTitle)",
                subtitle: "3.33 $ / month",
                price: "\(product.localizedPriceString) / year"
            )

            DispatchQueue.main.async {
                // Initial Select
                self.productsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
                self.purchaseButton.buttonStateConfig(state: true)
            }
            
            
            return bigCell
        } else if indexPath.row == 1 {
            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell.reuseID, for: indexPath as IndexPath) as! MiniPromoCVCell
            regularCell.configure(
                title: "\(product.localizedTitle)",
                price: "\(product.localizedPriceString) / month"
            )
            return regularCell
        } else if indexPath.row == 2 {
            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell.reuseID, for: indexPath as IndexPath) as! MiniPromoCVCell
            regularCell.configure(
                title: "\(product.localizedTitle)",
                price: "\(product.localizedPriceString) / week"
            )
            return regularCell
        }
//
        // 🟠?????????????
//        switch indexPath.row {
//        case 0:
//            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPromoCVCell.reuseID, for: indexPath as IndexPath) as! BigPromoCVCell
//            bigCell.configure(
//                discount: "save 68%".uppercased(),
//                title: "\(product.localizedTitle)",
//                subtitle: "3.33 $ / month",
//                price: "\(product.localizedPriceString) / year"
//            )
//
//            DispatchQueue.main.async {
//                // Initial Select
//                self.productsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
//                self.purchaseButton.buttonStateConfig(state: true)
//            }
//        case 1:
//            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell.reuseID, for: indexPath as IndexPath) as! MiniPromoCVCell
//            regularCell.configure(
//                title: "\(product.localizedTitle)",
//                price: "\(product.localizedPriceString) / month"
//            )
//            return regularCell
//        case 2:
//            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell.reuseID, for: indexPath as IndexPath) as! MiniPromoCVCell
//            regularCell.configure(
//                title: "\(product.localizedTitle)",
//                price: "\(product.localizedPriceString) / week"
//            )
//            return regularCell
//            
//        default:
//            return UICollectionViewCell()
//        }
        
        return UICollectionViewCell()
    }
    
    // MARK: should Select Item At
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let item = collectionView.cellForItem(at: indexPath)
        guard let item = item else { return false }
        // Deselect
        if item.isSelected {
            collectionView.deselectItem(at: indexPath, animated: true)
            trialOfferSwitch.isOn = false
            self.purchaseButton.buttonStateConfig(state: false)
            self.switchAction(self.trialOfferSwitch)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            self.purchaseButton.buttonStateConfig(state: true)
            return true
        }
        
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        
        let firstCell = indexPath.row == 0
        let width = collectionView.frame.size.width
        //
        return CGSize(
            width: firstCell ? width : (width/2)-6,
            height: DeviceMenager.isSmallDevice ? 60 : 82
        )
    }
    
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    // Horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}



// MARK: Initialize IAP
extension PaywallVC_V2 {
    
    func initializeIAP() {
        
        // MARK: IDs
        let productIDs: [String] = ["Month_9.99","Year_29.99","Weekly.ID"]
        
        // MARK: get Products
        Purchases.shared.getProducts(productIDs) { arr in
            self.storeProductArr = arr
            
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
        
    }
}
