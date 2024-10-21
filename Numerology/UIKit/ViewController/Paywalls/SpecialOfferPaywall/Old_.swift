////
////  PaywallVC_V2.swift
////  Numerology
////
////  Created by Serj on 17.09.2023.
////
//
//import UIKit
//import RevenueCat
//import SafariServices
//import AVFoundation
//
//
//final class qweasd12123: UIViewController {
//    
//    //
//    let bottomSideStack = UIStackView()
//    
//    //
//    private let player = AVPlayer()
//    
//    // MARK: store Product Arr
//    var storeProductArr: [StoreProduct]? {
//        didSet {
//            self.storeProductArr = storeProductArr?.sorted(by: { one, two in
//                one.price > two.price
//            })
//        }
//    }
//    
//    // MARK: - main Title
//    private let mainTitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textAlignment = .center
//        l.numberOfLines = 1
//        l.text = "Last chance"
//        return l
//    }()
//    
//    // MARK: - main Title
//    private let subtitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textAlignment = .center
//        l.numberOfLines = 0
//        // Text
//        let stringToColor = "(Limited-time offer)"
//        let mainString = """
//        Unlock the secrets of your destiny and find inner peace. Take control of your future with up to 80% off and access all exclusive content!
//        \(stringToColor)
//        """
//        let range = (mainString as NSString).range(of: stringToColor)
//        
//        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
//        mutableAttributedString.addAttribute(
//            NSAttributedString.Key.foregroundColor,
//            value: UIColor.lightGray,
//            range: range
//        )
//        l.attributedText = mutableAttributedString
//        return l
//    }()
//    
//    // MARK: Collection View
//    private let productsCollectionView: ContentCollectionView = {
//        var cv = ContentCollectionView()
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        return cv
//    }()
//    
//    // MARK: - config Compositional Layout CV
//    private func configCompositionalLayoutCV(absoluteCellWidth: CGFloat, cvHeight: CGFloat ) {
//        // iphone 12
//        
//        // Fill Width for cells by screen - Хорошее решение но конфликтует с авто высотой и не отображается, только в ViewController будет работать или указать высоту явно
//        let size = NSCollectionLayoutSize(
//            widthDimension: NSCollectionLayoutDimension.absolute(absoluteCellWidth),
//            heightDimension: NSCollectionLayoutDimension.estimated(85)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: size)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        section.interGroupSpacing = 18
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        self.productsCollectionView.collectionViewLayout = layout
//        self.productsCollectionView.heightAnchor.constraint(equalToConstant: cvHeight).isActive = true // 😢
//        
//    }
//    
//    // MARK: - config Flow Layout CV
//    private func configFlowLayoutCV() {
//        // iphone 8
//        // For size cell by content + Constraints in Cell
//        if let collectionViewLayout = productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewLayout.minimumInteritemSpacing = 0
//        }
//    }
//    
//    
//    // MARK: - register Cells
//    private func registerCells() {
//        productsCollectionView.register(SpecialOfferCVCell.self, forCellWithReuseIdentifier: SpecialOfferCVCell.reuseID)
//    }
//    
//    
//    // MARK: Purchase Button
//    private let purchaseButton: PurchaseButton = {
//        let color = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.7921568627, alpha: 1)
//        let b = PurchaseButton(frame: .zero, title: "Continue", primaryColor: color)
//        b.addTarget(Any?.self, action: #selector(actPurchaseButton), for: .touchUpInside)
//        return b
//    }()
//    
//    // MARK: Purchase Action
//    @objc private func actPurchaseButton() {
//        // Loader
//        self.purchaseButton.activityIndicatorView.startAnimating()
//        
//        // product
//        guard let product = self.storeProductArr?.first else { return }
//
//        // Purchase
//        Purchases.shared.purchase(product: product) { transaction, customerInfo, error, userCancelled in
//            self.purchaseButton.activityIndicatorView.stopAnimating()
//            print("🟠 Check Access",customerInfo?.entitlements["Access"]?.isActive as Any)
//            if customerInfo?.entitlements["Access"]?.isActive == true {
//                self.dismissAction()
//            }
//        }
//        
//    }
//    
//    
//    // MARK: Terms Button
//    private let termsButton: UIButton = {
//        let b = UIButton(type: .system)
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.setTitle("Terms Of Use", for: .normal)
//        b.titleLabel?.font = UIFont(weight: .regular, size: 13)
//        b.setTitleColor(UIColor.white, for: .normal)
//        
//        b.addTarget(Any?.self, action: #selector(termsOfUseAct), for: .touchUpInside)
//        return b
//    }()
//    @objc private func termsOfUseAct() {
//        print("termsOfUseAct")
//        
//        guard let url = URL(string: "https://numerology-terms.web.app/") else { return }
//        
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            let safariVC = SFSafariViewController(url: url)
//            safariVC.modalPresentationStyle = .pageSheet
//            self.present(safariVC, animated: true)
//        }
//    }
//    
//    // MARK: Privacy Button
//    private let privacyButton: UIButton = {
//        let b = UIButton(type: .system)
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.setTitle("Privacy Policy", for: .normal)
//        b.titleLabel?.font = UIFont(weight: .regular, size: 13)
//        b.setTitleColor(UIColor.white, for: .normal)
//        
//        b.addTarget(Any?.self, action: #selector(privacyPolicyAct), for: .touchUpInside)
//        return b
//    }()
//    
//    @objc private func privacyPolicyAct() {
//        guard let url = URL(string: "https://numerology-privacy.web.app/") else { return }
//        
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            let safariVC = SFSafariViewController(url: url)
//            safariVC.modalPresentationStyle = .pageSheet
//            self.present(safariVC, animated: true)
//        }
//    }
//    
//    // MARK: Restore Button
//    private let restoreButton: UIButton = {
//        let b = UIButton(type: .system)
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.setTitle("Restore purchases", for: .normal)
//        b.titleLabel?.font = UIFont(weight: .regular, size: 13)
//        b.setTitleColor(UIColor.white, for: .normal)
//        
//        b.addTarget(Any?.self, action: #selector(restoreAct), for: .touchUpInside)
//        return b
//    }()
//    @objc private func restoreAct() {
//        print("Restore purchases")
//        
//        Purchases.shared.restorePurchases { (customerInfo, error) in
//            // проверить есть ли подписка -> Предоставить доступ
//            if customerInfo?.entitlements.all["Access"]?.isActive == true {
//                print("✅User restored!")
//                self.showAlert(
//                    title: "Purchases restored",
//                    message: nil) {
//                        self.dismiss(animated: true)
//                    }
//            } else {
//                print("❌User not restored")
//                self.showAlert(
//                    title: "Purchases not restored",
//                    message: "We couldn't find your purchases") {}
//            }
//        }
//    }
//    
//    // MARK: - closeButton
//    private let closeButton: UIButton = {
//        
//        let b = UIButton() // customView: type
//        b.translatesAutoresizingMaskIntoConstraints = false
//        
//        let configImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
//        
//        let iv = UIImageView(image: configImage)
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.tintColor = .systemGray
//        iv.isUserInteractionEnabled = false
//        
//        b.addSubview(iv)
//        b.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        b.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        b.addTarget(Any?.self, action: #selector(dismissAction), for: .touchUpInside)
//        
//        return b
//    }()
//    
//    // MARK: - Dismiss Action
//    @objc private func dismissAction() {
//        self.dismiss(animated: true)
//    }
//    
//    // MARK: viewDidLoad
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Background
//        self.setBackground(named: "PaywallRadialBG")
//        playLoopedVideo()
//        // UI
//        setupUI()
//        // Delegate
//        productsCollectionView.delegate = self
//        productsCollectionView.dataSource = self
//        // Register
//        registerCells()
//        // In-App
//        initializeIAP()
//    }
//    
//    // MARK: viewWillAppear
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//    
//    // MARK: setup UI
//    private func setupUI() {
//        
//        // MARK: Bottom Side Stack
//        let topTextStack = UIStackView(arrangedSubviews: [mainTitle, subtitle])
//        topTextStack.translatesAutoresizingMaskIntoConstraints = false
//        topTextStack.axis = .vertical
//        topTextStack.alignment = .center
//        topTextStack.distribution = .fill
//        topTextStack.spacing = 4
//        
//        // MARK: Docs Stack
//        let docsStack = UIStackView(arrangedSubviews: [termsButton,restoreButton,privacyButton])
//        docsStack.axis = .horizontal
//        docsStack.spacing = 0
//        docsStack.distribution = .fillEqually
//        
//        // MARK: Bottom Side Stack
//        bottomSideStack.addSystemBlur(to: bottomSideStack, style: .systemThinMaterialDark)
//        // Add
//        bottomSideStack.addArrangedSubview(topTextStack)
//        bottomSideStack.addArrangedSubview(productsCollectionView)
//        bottomSideStack.addArrangedSubview(purchaseButton)
//        bottomSideStack.addArrangedSubview(docsStack)
//        // Configure
//        bottomSideStack.translatesAutoresizingMaskIntoConstraints = false
//        bottomSideStack.axis = .vertical
//        bottomSideStack.alignment = .center
//        bottomSideStack.distribution = .fill
//        bottomSideStack.spacing = 18
//        bottomSideStack.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 0, right: 18)
//        bottomSideStack.isLayoutMarginsRelativeArrangement = true
//        // Corner
//        bottomSideStack.layer.cornerRadius = 16
//        bottomSideStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        bottomSideStack.clipsToBounds = true
//        
//        // MARK: Main Stack
//        let mainStack = UIStackView(arrangedSubviews: [
//            bottomSideStack
//        ])
//        mainStack.translatesAutoresizingMaskIntoConstraints = false
//        mainStack.axis = .vertical
//        mainStack.alignment = .fill
//        mainStack.distribution = .fill
//        
//        // Add addSubview
//        self.view.addSubview(mainStack)
//        self.view.addSubview(closeButton)
//        let viewMargin = self.view.layoutMarginsGuide
//        
//        NSLayoutConstraint.activate([
//            //
//            closeButton.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 8),
//            closeButton.trailingAnchor.constraint(equalTo: viewMargin.trailingAnchor),
//            //
//            mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
//            mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
//            mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
//        ])
//        // At the end
//        setAdapttiveLayout()
//    }
//    
//    // MARK: - Adapttive
//    private func setAdapttiveLayout() {
//        
//        if DeviceMenager.shared.device == .iPhone_Se2_3Gen_8_7_6S {
//            let cellWidth: CGFloat = 176
//            // Layout CV
//            configCompositionalLayoutCV(absoluteCellWidth: cellWidth, cvHeight: 104)
//            //
//            mainTitle.font = .setSourceSerifPro(weight: .regular, size: 24)
//            subtitle.font = .setSourceSerifPro(weight: .regular, size: 15)
//            // Constraints
//            productsCollectionView.widthAnchor.constraint(equalToConstant: cellWidth).isActive = true
//            purchaseButton.widthAnchor.constraint(equalTo: bottomSideStack.widthAnchor, constant: -36).isActive = true
//            purchaseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        } else {
//            // Default 12 iphone
//            let cellWidth: CGFloat = 200
//            // Layout CV
//            configCompositionalLayoutCV(absoluteCellWidth: cellWidth, cvHeight: 128)
//            // Fonts
//            mainTitle.font = .setSourceSerifPro(weight: .regular, size: 35)
//            subtitle.font = .setSourceSerifPro(weight: .regular, size: 17)
//            // Constraints
//            productsCollectionView.widthAnchor.constraint(equalToConstant: cellWidth).isActive = true
//            purchaseButton.widthAnchor.constraint(equalTo: bottomSideStack.widthAnchor, constant: -36).isActive = true
//            purchaseButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
//        }
//        
//        
//    }
//    
//    private func playLoopedVideo() {
//        let ref = "PaywallVideo"
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        guard let path = Bundle.main.path(forResource: ref, ofType: "mov") else { return }
//        //
//        player.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: path)))
//        //
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        
//        self.view.addSubview(iv)
////        let margin = self.view.layoutMarginsGuide
//        NSLayoutConstraint.activate([
//            iv.topAnchor.constraint(equalTo: self.view.topAnchor),
//            iv.widthAnchor.constraint(equalToConstant: self.view.frame.width),
//            iv.heightAnchor.constraint(equalToConstant: self.view.frame.height-270),
//            iv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//        ])
//        
//        iv.layoutIfNeeded()
//        playerLayer.frame = iv.bounds
//        iv.layer.addSublayer(playerLayer)
//        player.play()
//        //
//        NotificationCenter.default.addObserver(
//            forName: .AVPlayerItemDidPlayToEndTime,
//            object: self.player.currentItem,
//            queue: .main) { [weak self] _ in
//                self?.player.seek(to: CMTime.zero)
//                self?.player.play()
//            }
//    }
//    
//}
//
//
//// MARK: - Products delegate
//extension SpecialOfferPaywall: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.storeProductArr?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let product = self.storeProductArr?[indexPath.row]
//        //
//        guard let product = product else { return UICollectionViewCell() }
//        
//        // MARK: - Config cells
//        //        if isIphone_66(view: self.view) {
//        //            return longCellsConfig(product: product, collectionView: collectionView, indexPath: IndexPath(row: 0, section: 0))
//        //        } else {
//        //            return miniCellsConfig(product: product, collectionView: collectionView, indexPath: indexPath)
//        //        }
//        
//        let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialOfferCVCell.reuseID, for: indexPath as IndexPath) as! SpecialOfferCVCell
//        
//        bigCell.configure(
//            discount: "special proposal🔥".capitalized,
//            title: "\(product.localizedTitle)",
//            subtitle: "Was 119.99 $",
//            price: "\(product.localizedPriceString) / one-time"
//        )
//        
//        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//        self.purchaseButton.stateConfig(state: true)
//        
//        return bigCell
//        
//    }
//    
//    // MARK: - mini Cells Config
//    //    private func miniCellsConfig(product: StoreProduct, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//    // FOR iphone 8 case
//    //        if indexPath.row == 0 {
//    //            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell().miniPromoCVCell_ID, for: indexPath as IndexPath) as! MiniPromoCVCell
//    //            miniCell.configure(
//    //                discount: "save 68%".uppercased(),
//    //                title: "\(product.localizedTitle)",
//    //                subtitle: "3.33 $ / month",
//    //                price: "\(product.localizedPriceString) / year"
//    //            )
//    ////            toggleOnState()
//    //            return miniCell
//    //        } else if indexPath.row == 1 {
//    //            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: Mini2PromoCVCell().mini2PromoCVCell_ID, for: indexPath as IndexPath) as! Mini2PromoCVCell
//    //
//    //            miniCell.configure(
//    //                title: "\(product.localizedTitle)",
//    //                price: "\(product.localizedPriceString) / month"
//    //            )
//    //            return miniCell
//    //        } else {
//    //            return UICollectionViewCell()
//    //        }
//    //    }
//    
//    // MARK: - long Cells Config
//    //    private func longCellsConfig(product: StoreProduct, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//    //        //        // Config Cell normal case
//    //        if indexPath.row == 0 {
//    //            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialOfferCVCell.reuseID, for: indexPath as IndexPath) as! SpecialOfferCVCell
//    //
//    //            bigCell.configure(
//    //                discount: "save 68%".uppercased(),
//    //                title: "\(product.localizedTitle)",
//    //                subtitle: "3.33 $ / month",
//    //                price: "\(product.localizedPriceString) / year"
//    //            )
//    ////            toggleOnState()
//    //            return bigCell
//    //        }
//    ////        else if indexPath.row == 1 {
//    ////            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: RegularPromoCVCell().regularPromoCVCell_ID, for: indexPath as IndexPath) as! RegularPromoCVCell
//    ////            regularCell.configure(
//    ////                title: "\(product.localizedTitle)",
//    ////                price: "\(product.localizedPriceString) / month"
//    ////            )
//    ////            return regularCell
//    ////        } else {
//    //            return UICollectionViewCell()
//    ////        }
//    //    }
//    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////        if !isIphone_12(view: self.view) {
////            return CGSize(width: (collectionView.frame.size.width/2)-4, height: 122)
////        } else {
////            return CGSize()
////        }
////    }
//    
//}
//
//
//
//// MARK: Initialize IAP
//extension SpecialOfferPaywall {
//    
//    func initializeIAP() {
//        
//        // MARK: IDs
//        let productIDs: [String] = ["Lifetime.Purchase"]
//        
//        // MARK: get Products
//        Purchases.shared.getProducts(productIDs) { arr in
//            self.storeProductArr = arr
//            //
//            DispatchQueue.main.async {
//                self.productsCollectionView.reloadData()
//            }
//        }
//    }
//}
