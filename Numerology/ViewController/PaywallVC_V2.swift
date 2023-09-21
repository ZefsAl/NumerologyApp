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
    var offering: Offering?
    
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
        
//      Fill Width for cells - Хорошее решение но конфликтует с авто высотой и не отображается, только в ViewController будет работать или указать высоту явно
        
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
            heightDimension: NSCollectionLayoutDimension.estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 20

        let layout = UICollectionViewCompositionalLayout(section: section)
        cv.collectionViewLayout = layout
        
        return cv
    }()
    
    
    
    // MARK: Main Promo Title
    private let mainPromoTitle: UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
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
        let b = PurchaseButton()
        b.addTarget(Any?.self, action: #selector(actPurchaseButton), for: .touchUpInside)
        return b
    }()
    
    // MARK: Action Purchase Button
    @objc private func actPurchaseButton() {
        print("nextBtnAction")
        
        self.purchaseButton.activityIndicatorView.startAnimating()
        // Free Trial
        if subscriptionSwitch.isOn == true {
            guard let package = self.offering?.monthly else { return }
            Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
                // Закрыть по окончанию покупки
                self.purchaseButton.activityIndicatorView.stopAnimating()
                if customerInfo?.entitlements["Access"]?.isActive == true {
                    self.dismiss(animated: true)
                }
            }
        }
        
        // Get product index
        let index = self.productsCollectionView.indexPathsForSelectedItems?.first?.row
        guard let index = index else { return }
        guard let productIndex = self.storeProductArr?[index] else { return }
        
        // Purchase Products
        Purchases.shared.purchase(product: productIndex) { transaction, customerInfo, error, userCancelled in
            // Закрыть по окончанию покупки
            self.purchaseButton.activityIndicatorView.stopAnimating()
            if customerInfo?.entitlements["Access"]?.isActive == true {
                self.dismiss(animated: true)
            }
        }
        
        
        // Animation
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.purchaseButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.purchaseButton.transform = CGAffineTransform.identity
                }
            })
        }
    }
    
    
    // MARK: subscription Lable
    private let subscriptionLable: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.numberOfLines = 0
        l.font = UIFont(weight: .regular, size: 17)
        
        l.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Not sure yet?\nEnable 7-day free trial!",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return l
    }()
    
    // MARK: Switch
    private let subscriptionSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(Any?.self, action: #selector(switchAction), for: .touchUpInside)
        s.isOn = false
        s.onTintColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        return s
    }()
    // MARK: Switch Action
    @objc private func switchAction(_ sender: UISwitch) {
        
        guard sender.isOn == true else {
            self.purchaseButton.lable.text = "Try it".uppercased()
            return
        }
        
        // Deselect cell
        if let indexPath = self.productsCollectionView.indexPathsForSelectedItems?.first {
            productsCollectionView.deselectItem(at: indexPath, animated: true)
        }
        
        // MARK: getOfferings
        // 1. Запрос
        Purchases.shared.getOfferings { (offerings, error) in
            
            if let offering = offerings?.current {
                
                self.offering = offering
                
                if let product = offering.availablePackages.first?.storeProduct {
                    
                    // 2. Check
                    Purchases.shared.checkTrialOrIntroDiscountEligibility(product: product) { eligibility in
                        
                        if eligibility == .eligible {
                            self.purchaseButton.lable.text = "Try free trial".uppercased()
                            print("user is eligible")
                        } else {
                            self.purchaseButton.lable.text = "Try it".uppercased()
                            sender.isOn = false
                            print("user is not eligible")
                            
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: Terms Button
    private let termsButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Terms Of Use", for: .normal)
        b.titleLabel?.font = UIFont(weight: .bold, size: 13)
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
        b.titleLabel?.font = UIFont(weight: .bold, size: 13)
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
        b.titleLabel?.font = UIFont(weight: .bold, size: 13)
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
        setBackground(named: "SplashScreen.png")
        self.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        // UI
        setupUI()
        // Delegate
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        // Register
        productsCollectionView.register(BigPromoCVCell.self, forCellWithReuseIdentifier: BigPromoCVCell().bigPromoCVCell_ID)
        productsCollectionView.register(RegularPromoCVCell.self, forCellWithReuseIdentifier: RegularPromoCVCell().regularPromoCVCell_ID)
        // In-App
        initializeIAP()
        
    }
    
    

    
    // MARK: Set up Stack
    private func setupUI() {
        
        // MARK: Bottom Side Stack
        let topSideStack = UIStackView(arrangedSubviews: [mainPromoTitle])
        topSideStack.translatesAutoresizingMaskIntoConstraints = false
        topSideStack.axis = .vertical
        topSideStack.alignment = .center
        topSideStack.distribution = .fill
        topSideStack.spacing = 20
        topSideStack.layoutMargins = UIEdgeInsets(top: 60, left: 18, bottom: 24, right: 18)
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
        subscriptionStack.layoutMargins = UIEdgeInsets(top: 8, left: 18, bottom: 8, right: 18)
        subscriptionStack.isLayoutMarginsRelativeArrangement = true
        subscriptionStack.backgroundColor = UIColor.CellColors().cellDefaultBG
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
        bottomSideStack.spacing = 20
        bottomSideStack.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 18+44, right: 18)
        bottomSideStack.isLayoutMarginsRelativeArrangement = true
        bottomSideStack.layer.cornerRadius = 16
        bottomSideStack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomSideStack.backgroundColor = UIColor.CardColors().cardDefaultBG
        
        
        // MARK: Main Stack
        let mainStack = UIStackView(arrangedSubviews: [topSideStack, customCarousel_CV, bottomSideStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        
        
        // Add addSubview
        self.view.addSubview(mainScrollView)
        self.mainScrollView.addSubview(mainStack)
        
        
        let scrollViewMargin = mainScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            customCarousel_CV.heightAnchor.constraint(equalToConstant: 200),
            
            productsCollectionView.heightAnchor.constraint(equalToConstant: 210), // 😢
            
            mainStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 0),
            mainStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 44),
            mainStack.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, constant: 0),
            
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
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
        
        
        // Config Cell
        if indexPath.row == 0 {
            
            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPromoCVCell().bigPromoCVCell_ID, for: indexPath as IndexPath) as! BigPromoCVCell
            bigCell.configure(
                discount: "save 74%".uppercased(),
                title: "\(product.localizedTitle) Plan",
                subtitle: "12 mo - \(product.localizedPriceString) / year",
                price: "2.49 $ / mo"
            )
            
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
        
        if item.isSelected {
            collectionView.deselectItem(at: indexPath, animated: true)
            
            self.purchaseButton.lable.text = "Try it".uppercased()
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            subscriptionSwitch.isOn = false
//
            if indexPath.row == 0 {
                self.purchaseButton.lable.text = "Buy Yearly".uppercased()
            } else if indexPath.row == 1 {
                self.purchaseButton.lable.text = "Buy Monthly".uppercased()
            }
            
            return true
        }
        
        return false
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
