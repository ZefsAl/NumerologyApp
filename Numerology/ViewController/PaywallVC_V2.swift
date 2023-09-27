//
//  PaywallVC_V2.swift
//  Numerology
//
//  Created by Serj on 17.09.2023.
//

import UIKit
import RevenueCat
import SafariServices


final class PaywallVC_V2: UIViewController {
    
    // instances
    // MARK: offering
//    var offering: Offering?
    
    // MARK: store Product Arr
    var storeProductArr: [StoreProduct]? {
        didSet {
            self.storeProductArr = storeProductArr?.sorted(by: { one, two in
                one.price > two.price
            })
        }
    }

    // MARK: Scroll View
    private let mainScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    
    // MARK: Carousel CV
    private let customCarousel_CV: CustomCarousel_CV = {
       let cv = CustomCarousel_CV()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    // MARK: Collection View
    private let productsCollectionView: ContentCollectionView = {
        var cv = ContentCollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
//         For size cell by content + Constraints in Cell
//        if let collectionViewLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
        
//      Fill Width for cells by screen - Хорошее решение но конфликтует с авто высотой и не отображается, только в ViewController будет работать или указать высоту явно
//        let size = NSCollectionLayoutSize(
//            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
//            heightDimension: NSCollectionLayoutDimension.estimated(200)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: size)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        section.interGroupSpacing = 18
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        cv.collectionViewLayout = layout
        
        
        
        
//        cv.backgroundColor = .blue
        return cv
    }()
    
    // MARK: - config Compositional Layout CV
    private func configCompositionalLayoutCV() {
        // iphone 12
        
        //      Fill Width for cells by screen - Хорошее решение но конфликтует с авто высотой и не отображается, только в ViewController будет работать или указать высоту явно
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 18

        let layout = UICollectionViewCompositionalLayout(section: section)
        self.productsCollectionView.collectionViewLayout = layout
        self.productsCollectionView.heightAnchor.constraint(equalToConstant: 190).isActive = true // 😢
        
        // Register
        productsCollectionView.register(BigPromoCVCell.self, forCellWithReuseIdentifier: BigPromoCVCell().bigPromoCVCell_ID)
        productsCollectionView.register(RegularPromoCVCell.self, forCellWithReuseIdentifier: RegularPromoCVCell().regularPromoCVCell_ID)
        
    }
    // MARK: - config Flow Layout CV
    private func configFlowLayoutCV() {
        // iphone 8
        //         For size cell by content + Constraints in Cell
        if let collectionViewLayout = productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            // automaticSize by content width - without delegate config solution
            collectionViewLayout.minimumInteritemSpacing = 0
        }
        
        
//        productsCollectionView.register(MiniPromoCVCell.self, forCellWithReuseIdentifier: MiniPromoCVCell().miniPromoCVCell_ID)
    }
    
    /// Разный конфиг layout  для размеров экрана  и ячеек
    private func distributedSetupCVLayout() {
        if isIphone_66() {
            configCompositionalLayoutCV()
        } else {
            configFlowLayoutCV()
        }
        
    }
    
    // MARK: - register Cells
    private func registerCells() {
        
//        products Collection View
        productsCollectionView.register(MiniPromoCVCell.self, forCellWithReuseIdentifier: MiniPromoCVCell().miniPromoCVCell_ID)
        productsCollectionView.register(Mini2PromoCVCell.self, forCellWithReuseIdentifier: Mini2PromoCVCell().mini2PromoCVCell_ID)
        productsCollectionView.register(BigPromoCVCell.self, forCellWithReuseIdentifier: BigPromoCVCell().bigPromoCVCell_ID)
        productsCollectionView.register(RegularPromoCVCell.self, forCellWithReuseIdentifier: RegularPromoCVCell().regularPromoCVCell_ID)
    }
    
    
    
    
    
    // MARK: Main Promo Title
    private let mainPromoTitle: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(red: 0.92, green: 0.91, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.textAlignment = .center
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Get full access!",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        l.font = UIFont(weight: .semiBold, size: 44)
        return l
    }()
    
    // MARK: Purchase Button
    private let purchaseButton: PurchaseButton = {
        let b = PurchaseButton(frame: .zero, title: "Continue")
        b.addTarget(Any?.self, action: #selector(actPurchaseButton), for: .touchUpInside)
        return b
    }()
    
    // MARK: Action Purchase Button
    @objc private func actPurchaseButton() {
        print("Purchase Button")
        
//        self.purchaseButton.activityIndicatorView.startAnimating()
        
        
        
        // Free Trial
//        if subscriptionSwitch.isOn == true {
            // old
//            guard let package = self.offering?.monthly else { return }
//            Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
//                // Закрыть по окончанию покупки
//                self.purchaseButton.activityIndicatorView.stopAnimating()
//                if customerInfo?.entitlements["Access"]?.isActive == true {
//                    self.dismiss(animated: true)
//                }
//            }
//        }
        
        // Get product index
        let index = self.productsCollectionView.indexPathsForSelectedItems?.first?.row
        guard let index = index else { return }
        guard let storeProductIndex = self.storeProductArr?[index] else { return }
        self.purchaseButton.activityIndicatorView.startAnimating()
        
        
        
        
        // Purchase Products
        Purchases.shared.purchase(product: storeProductIndex) { transaction, customerInfo, error, userCancelled in
            // Закрыть по окончанию покупки
            self.purchaseButton.activityIndicatorView.stopAnimating()
            if customerInfo?.entitlements["Access"]?.isActive == true {
                self.dismiss(animated: true)
            }
        }
        
        
//        // Animation
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.2, animations: {
//                self.purchaseButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.2) {
//                    self.purchaseButton.transform = CGAffineTransform.identity
//                }
//            })
//        }
    }
    
    private func toggleOnState() {
//        subscriptionSwitch.isOn = true
        
        Purchases.shared.getOfferings { (offerings, error) in
            
            if let offering = offerings?.current {
                if let product = offering.availablePackages.first?.storeProduct {
                    // 2. Check
                    Purchases.shared.checkTrialOrIntroDiscountEligibility(product: product) { eligibility in
                        if eligibility == .eligible {
//                            print("user is eligible")
                            self.subscriptionSwitch.isOn = true
                        } else {
                            // user is not eligible
                        }
                    }
                }
            }
        }
        
        // Can check Eligibility
//        if subscriptionSwitch.isOn == true {
            // Select
            DispatchQueue.main.async {
                self.productsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
                self.purchaseButton.stateConfig(state: true)
            }
//        }
        
    }
    
    
    
    
    // MARK: subscription Lable
    private let subscriptionLable: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.numberOfLines = 0
        l.font = UIFont(weight: .regular, size: 15)
        
        l.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Not sure yet? Enable free trial!",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return l
    }()
    
    // MARK: Switch
    private let subscriptionSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(Any?.self, action: #selector(switchAction), for: .touchUpInside)
//        s.isOn = false
        s.onTintColor = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1)
        return s
    }()
    // MARK: Switch Action
    @objc private func switchAction(_ sender: UISwitch) {
        
        guard sender.isOn == true else {
            self.productsCollectionView.deselectItem(at: IndexPath(item: 0, section: 0), animated: true)
            self.purchaseButton.stateConfig(state: false)
            return
        }
        
        DispatchQueue.main.async {
//            let index = self.productsCollectionView.indexPathsForSelectedItems?.first?.startIndex
            self.productsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
            self.purchaseButton.stateConfig(state: true)
        }
        
        
        // Deselect cell
//        if let indexPath = self.productsCollectionView.indexPathsForSelectedItems?.first {
//            productsCollectionView.deselectItem(at: indexPath, animated: true)
//        }
//
//        // MARK: getOfferings
//        // 1. Запрос
//        Purchases.shared.getOfferings { (offerings, error) in
//
//            if let offering = offerings?.current {
//
////                self.offering = offering
//
//                if let product = offering.availablePackages.first?.storeProduct {
//
//                    // 2. Check
//                    Purchases.shared.checkTrialOrIntroDiscountEligibility(product: product) { eligibility in
//
//                        if eligibility == .eligible {
//                            self.purchaseButton.lable.text = "Try free trial".uppercased()
//                            print("user is eligible")
//                        } else {
//                            self.purchaseButton.lable.text = "Try it".uppercased()
//                            sender.isOn = false
//                            print("user is not eligible")
//
//                        }
//                    }
//                }
//            }
//        }
        //
    }
    
    
    // MARK: Terms Button
    private let termsButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Terms Of Use", for: .normal)
        b.titleLabel?.font = UIFont(weight: .regular, size: 13)
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
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Privacy Policy", for: .normal)
        b.titleLabel?.font = UIFont(weight: .regular, size: 13)
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
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Restore purchases", for: .normal)
        b.titleLabel?.font = UIFont(weight: .regular, size: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(restoreAct), for: .touchUpInside)
        return b
    }()
    @objc private func restoreAct() {
        print("Restore purchases")
        
        Purchases.shared.restorePurchases { (customerInfo, error) in
            // проверить есть ли подписка -> Предоставить доступ
            if customerInfo?.entitlements.all["Access"]?.isActive == true {
                print("User restored!")
                //                self.dismiss(animated: true)
            } else {
                print("User not restored")
            }
        }
    }
    
    
// MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self style
        setBackground(named: "EnterDataBG.png")
        self.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        // UI
        setupUI()
        // Delegate
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
//        // Register
        registerCells()
        
        
        // In-App
        initializeIAP()
        // Layout Config
//        configCompositionalLayoutCV()
//        configFlowLayoutCV()
        distributedSetupCVLayout()
        
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//    }
    

    
    // MARK: Set up Stack
    private func setupUI() {
        
        // MARK: Bottom Side Stack
        let topSideStack = UIStackView(arrangedSubviews: [mainPromoTitle])
        topSideStack.translatesAutoresizingMaskIntoConstraints = false
        topSideStack.axis = .vertical
        topSideStack.alignment = .center
        topSideStack.distribution = .fill
        topSideStack.spacing = 20
        topSideStack.layoutMargins = UIEdgeInsets(top: 0, left: 18, bottom: 18, right: 18)
        topSideStack.isLayoutMarginsRelativeArrangement = true
        
        
        // MARK: Docs Stack
        let docsStack = UIStackView(arrangedSubviews: [termsButton,restoreButton,privacyButton])
        docsStack.axis = .horizontal
        docsStack.spacing = 0
        docsStack.distribution = .fillEqually
        
        // MARK: Subscription Stack
        let subscriptionStack = UIStackView(arrangedSubviews: [subscriptionLable, subscriptionSwitch])
        subscriptionStack.axis = .horizontal
        subscriptionStack.alignment = .center
        subscriptionStack.spacing = 0
        subscriptionStack.layoutMargins = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18)
        subscriptionStack.isLayoutMarginsRelativeArrangement = true
        subscriptionStack.backgroundColor = UIColor.CellColors().cellActiveBG
        subscriptionStack.layer.cornerRadius = 16
        
        // MARK: Bottom Side Stack
        let bottomSideStack = UIStackView(arrangedSubviews: [
            subscriptionStack,
            productsCollectionView,
            purchaseButton,
            docsStack
        ])
        bottomSideStack.translatesAutoresizingMaskIntoConstraints = false
        bottomSideStack.axis = .vertical
        bottomSideStack.alignment = .fill
        bottomSideStack.distribution = .fill
        bottomSideStack.spacing = 18
        bottomSideStack.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 0, right: 18)
        bottomSideStack.isLayoutMarginsRelativeArrangement = true
        bottomSideStack.layer.cornerRadius = 16
        bottomSideStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomSideStack.backgroundColor = UIColor.CardColors().cardDefaultBG
        
        
        // MARK: Main Stack
        let mainStack = UIStackView(arrangedSubviews: [
            topSideStack,
            customCarousel_CV,
            bottomSideStack
        ])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        
        
        // Add addSubview
//        self.view.addSubview(mainScrollView)
//        self.mainScrollView.addSubview(mainStack)
        
        self.view.addSubview(mainStack)
        
        
//        customCarousel_CV.backgroundColor = .blue
        let scrollViewMargin = mainScrollView.contentLayoutGuide
        let viewMargin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            
            customCarousel_CV.heightAnchor.constraint(equalToConstant: 183),
//            productsCollectionView.heightAnchor.constraint(equalToConstant: 190), // 😢

            
//            mainStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 0),
            mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
//            mainStack.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, constant: 0),

            
            // Хороший вариант с scrollView
//            mainStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 0),
//            mainStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 0),
//            mainStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: 0),
//            mainStack.bottomAnchor.constraint(equalTo: scrollViewMargin.bottomAnchor, constant: 0),
//            mainStack.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, constant: 0),
//
//            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
}


extension PaywallVC_V2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.storeProductArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = self.storeProductArr?[indexPath.row]
        
        guard let product = product else { return UICollectionViewCell() }
        
        
//        // Config Cell normal case
//        if indexPath.row == 0 {
//            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPromoCVCell().bigPromoCVCell_ID, for: indexPath as IndexPath) as! BigPromoCVCell
//            bigCell.configure(
//                discount: "save 74%".uppercased(),
//                title: "\(product.localizedTitle) Plan",
//                subtitle: "12 mo - \(product.localizedPriceString) / year",
//                price: "2.49 $ / mo"
//            )
//            toggleOnState()
//            return bigCell
//        } else if indexPath.row == 1 {
//            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: RegularPromoCVCell().regularPromoCVCell_ID, for: indexPath as IndexPath) as! RegularPromoCVCell
//            regularCell.configure(
//                title: "\(product.localizedTitle)",
//                price: "\(product.localizedPriceString) / mo"
//            )
//            return regularCell
//        } else {
//            return UICollectionViewCell()
//        }
        
        

        // FOR iphone 8 case
//        if indexPath.row == 0 {
//            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell().miniPromoCVCell_ID, for: indexPath as IndexPath) as! MiniPromoCVCell
//            miniCell.configure(
//                discount: "save 74%".uppercased(),
//                title: "\(product.localizedTitle) Plan",
//                subtitle: "12 mo - \(product.localizedPriceString) / year",
//                price: "2.49 $ / mo"
//            )
//            toggleOnState()
//            return miniCell
//        } else if indexPath.row == 1 {
//            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell().miniPromoCVCell_ID, for: indexPath as IndexPath) as! MiniPromoCVCell
//
//            miniCell.discountCaption.isHidden = true
//            miniCell.subtitle.isHidden = true
//
//            miniCell.configure(
//                discount: "test".uppercased(),
//                title: "\(product.localizedTitle) Plan",
//                subtitle: nil,
//                price: "\(product.localizedPriceString) / mo"
//            )
//            return miniCell
//        } else {
//            return UICollectionViewCell()
//        }
        
        if isIphone_66() {
            return longCellsConfig(product: product, collectionView: collectionView, indexPath: indexPath)
        } else {
            return miniCellsConfig(product: product, collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func miniCellsConfig(product: StoreProduct, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // FOR iphone 8 case
        if indexPath.row == 0 {
            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell().miniPromoCVCell_ID, for: indexPath as IndexPath) as! MiniPromoCVCell
            miniCell.configure(
                discount: "save 74%".uppercased(),
                title: "\(product.localizedTitle) Plan",
                subtitle: "12 mo - \(product.localizedPriceString) / year",
                price: "2.49 $ / mo"
            )
            toggleOnState()
            return miniCell
        } else if indexPath.row == 1 {
            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: Mini2PromoCVCell().mini2PromoCVCell_ID, for: indexPath as IndexPath) as! Mini2PromoCVCell
            
            miniCell.configure(
                title: "\(product.localizedTitle)",
                price: "\(product.localizedPriceString) / mo"
            )
            return miniCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    private func longCellsConfig(product: StoreProduct, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        //        // Config Cell normal case
        if indexPath.row == 0 {
            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPromoCVCell().bigPromoCVCell_ID, for: indexPath as IndexPath) as! BigPromoCVCell
            bigCell.configure(
                discount: "save 74%".uppercased(),
                title: "\(product.localizedTitle) Plan",
                subtitle: "12 mo - \(product.localizedPriceString) / year",
                price: "2.49 $ / mo"
            )
            toggleOnState()
            return bigCell
        } else if indexPath.row == 1 {
            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: RegularPromoCVCell().regularPromoCVCell_ID, for: indexPath as IndexPath) as! RegularPromoCVCell
            regularCell.configure(
                title: "\(product.localizedTitle)",
                price: "\(product.localizedPriceString) / mo"
            )
            return regularCell
        } else {
            return UICollectionViewCell()
        }
    }

    
    // MARK: shouldSelectItemAt
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        // Deselect
        let item = collectionView.cellForItem(at: indexPath)
        
        guard let item = item else { return false }
        
//        print("was selected action ✅")
        
        if item.isSelected {
            collectionView.deselectItem(at: indexPath, animated: true)
            subscriptionSwitch.isOn = false
            self.purchaseButton.stateConfig(state: false)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//
            if indexPath.row == 0 {
                subscriptionSwitch.isOn = true
            } else if indexPath.row == 1 {
                subscriptionSwitch.isOn = false
            }
            self.purchaseButton.stateConfig(state: true)
            return true
        }
        
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        if !isIphone_66() {
            return CGSize(width: (collectionView.frame.size.width/2)-4, height: 122)
        } else {
            return CGSize()
        }
    }
        
}



extension PaywallVC_V2 {
    
    // MARK: Initialize IAP
    func initializeIAP() {
        
        // MARK: IDs
        let productIDs: [String] = ["Month_9.99","Year_29.99"]
        
        // MARK: getProducts
        Purchases.shared.getProducts(productIDs) { arr in
            self.storeProductArr = arr
            
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
        
        // Restore
        Purchases.shared.restorePurchases { (customerInfo, error) in
            // проверить есть ли подписка -> Предоставить доступ
            if customerInfo?.entitlements.all["Access"]?.isActive == true {
                print("User restored!")
                self.dismiss(animated: true)
            } else {
                print("User not restored!")
            }
        }
    }
}


extension PaywallVC_V2 {
    // MARK: isIphone_66
    private func isIphone_66() -> Bool {
        // tryFix content size
        if (self.view.frame.height < 844.0) {
            print("✅ iphone 8")
            return false
        } else {
            print("✅ iphone 12")
            return true
        }
        //        8 iphone - Screen height: 667.0
        //        12 iphone - Screen height: 844.0
    }
}
