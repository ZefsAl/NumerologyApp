//
//  SpecialOfferPaywall.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit
import RevenueCat
import SafariServices
import AVFoundation


final class SpecialOfferPaywall: ViewControllerPannable {
    
    private var isNavBarHidden: Bool?
    let mainStack = UIStackView()
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
        l.text = "🔥 Last chance!"
        return l
    }()
    
    // MARK: - main Title
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.numberOfLines = 3
        // Text
        let stringToColor = "(Limited-time offer)"
        let mainString = """
        Unlock the secrets of your destiny and find inner peace. Take control of your future with up to 80% off and access all exclusive content! \(stringToColor)
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
    private let productsCollectionView: ContentCollectionView = ContentCollectionView()
    
    // MARK: - register Cells
    private func registerCells() {
        productsCollectionView.register(BigPromoCVCell.self, forCellWithReuseIdentifier: BigPromoCVCell.reuseID)
    }
    
    // MARK: Purchase Button
    private let purchaseButton: PurchaseButton = {
        let b = PurchaseButton(
            title: "Continue",
            primaryColor: DesignSystem.PaywallTint.primaryPaywall,
            tapToBounce: true
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
            } else {
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
        
        guard let url = URL(string: AppSupportedLinks.terms.rawValue) else { return }
        
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
        guard let url = URL(string: AppSupportedLinks.privacy.rawValue) else { return }
        
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
    
    
    // MARK: - Timer
    private var timer: Timer? = Timer()
    private var timerCounter: Int = 8
    // MARK: - closeButtonTimer
    private lazy var closeButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitleColor(DesignSystem.PaywallTint.primaryPaywall.withAlphaComponent(0.5), for: .normal)
        b.titleLabel?.font = DesignSystem.SourceSerifProFont.title_h4
        
        let img = UIImage(
            systemName: "xmark",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        )
        b.setImage(img, for: .normal)
        b.tintColor = b.titleLabel?.textColor
        b.semanticContentAttribute = .forceRightToLeft

        b.contentHorizontalAlignment = .center
        b.contentVerticalAlignment = .center
        //
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        b.addTarget(Any?.self, action: #selector(dismissAction), for: .touchUpInside)
        return b
    }()
    // MARK: - Timer Action
    @objc private func updateCounter() {
        self.closeButton.fadeTransition()
        if self.timerCounter > 0 {
            self.timerCounter -= 1
            self.closeButton.setTitle("\(self.timerCounter)", for: .normal)
        } else {
            self.closeButton.tintColor = DesignSystem.PaywallTint.primaryPaywall
            self.closeButton.setTitle("", for: .normal)
            self.closeButton.setTitleColor(DesignSystem.PaywallTint.primaryPaywall, for: .normal)
            self.timer?.invalidate()
            self.timer = nil
            CustomPresentationController.canBeDismissed = true
        }
    }
    
    // MARK: - ❌ Dismiss Action
    @objc private func dismissAction() {
        guard timerCounter == 0 else { return }
        guard CustomPresentationController.canBeDismissed else { return }
        let some = self.presentationController as? CustomPresentationController
        some?.dismissTap()
    }
    
    
    enum PaywallStyleType {
        case standart, modal
    }
    
    // MARK: 🟢🟠 Convenience init
    convenience init(type: PaywallStyleType) {
        self.init()
        //
        switch type {
        case .standart:
            self.isNavBarHidden = false
            self.view.gestureRecognizers?.removeAll()
            setupLoopedVideoBG()
        case .modal:
            self.isNavBarHidden = true
        }
        
        
    }
    
    // MARK: 🟢 viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let isNavBarHidden = isNavBarHidden {
            self.navigationController?.setNavigationBarHidden(isNavBarHidden, animated: true)
        }
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
        let cardContentStack = UIStackView(arrangedSubviews: [
            topTextStack,
            productsCollectionView,
            purchaseButton,
            docsStack,
        ])
        cardContentStack.backgroundColor = DesignSystem.PaywallTint.primaryDarkBG
        // Configure
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
        // Corner
        cardContentStack.layer.cornerRadius = DesignSystem.maxCornerRadius
        cardContentStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cardContentStack.clipsToBounds = true
        
        // MARK: Main Stack
        self.mainStack.addArrangedSubview(cardContentStack)
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
        self.mainStack.axis = .vertical
        self.mainStack.alignment = .fill
        self.mainStack.distribution = .fill
        
        // Add addSubview
        self.view.addSubview(self.mainStack)
        NSLayoutConstraint.activate([
            self.purchaseButton.heightAnchor.constraint(equalToConstant: 60),
            //
            docsStack.heightAnchor.constraint(equalToConstant: 16),
            //
            self.mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
        // At the end
        self.setAdapttiveLayout()
        
        if let isNavBarHidden = isNavBarHidden, 
           isNavBarHidden == true {
            addCustomClose()
        }
    }
    
    func addCustomClose() {
        self.mainStack.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -18),
        ])
    }
    
    // MARK: - Adapttive
    private func setAdapttiveLayout() {
        self.mainTitle.font = .setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 24 : 28)
        self.subtitle.font = .setSourceSerifPro(weight: .regular, size: DeviceMenager.isSmallDevice ? 12 : 14)
    }
    
    // Looped Video BG
    private func setupLoopedVideoBG() {
        let ref = "SpecialOffer"
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        guard let path = Bundle.main.path(forResource: ref, ofType: "mov") else { return }
        //
        player.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: path)))
        //
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
//        self.view.addSubview(iv)
        self.view.insertSubview(iv, at: 0)
//        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: self.view.topAnchor),
            iv.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            iv.heightAnchor.constraint(equalToConstant: self.view.frame.height-270),
            iv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        iv.layoutIfNeeded()
        playerLayer.frame = iv.bounds
        iv.layer.addSublayer(playerLayer)
        player.play()
        //
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: self.player.currentItem,
            queue: .main) { [weak self] _ in
                self?.player.seek(to: CMTime.zero)
                self?.player.play()
            }
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
        let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPromoCVCell.reuseID, for: indexPath as IndexPath) as! BigPromoCVCell
        
        bigCell.configure(
            discount: "special proposal".capitalized,
            title: "\(product.localizedTitle)",
            discountTitle: "Was 119.99 $",
            price: "\(product.localizedPriceString) / one-time",
            discountStyle: .secondsry
        )
        bigCell.discountBadge.backgroundColor = .hexColor("E5595C")
        
        //
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        self.purchaseButton.buttonStateConfig(state: true)
        
        return bigCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        //
        return CGSize(
            width: width,
            height: DeviceMenager.isSmallDevice ? 60 : 82
        )
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

