//
//  PayWallViewController.swift
//  Numerology
//
//  Created by Serj on 15.08.2023.
//

import UIKit
import RevenueCat
import SafariServices

// Managed in tab bar
class PaywallViewController: UIViewController {
    
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
    
    // MARK: Collection View
    private let contentCollectionView: ContentCollectionView = {
        let cv = ContentCollectionView()
        // For size cell by content + Constraints in Cell
        if let collectionViewLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        return cv
    }()
    
    // MARK: title
    let promoMainTitle: UILabel = {
        let l = UILabel()
        //        l.translatesAutoresizingMaskIntoConstraints = false
//        l.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        l.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        l.text = "Full access by subscription!"
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let promoSubtitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.numberOfLines = 0
        l.text = """
        Get personalized numerological predictions for your date of birth.\n
        Learn about your life stages, partner compatibility and more...
        """
        l.textAlignment = .left

        return l
    }()
    
    // MARK: paymentSubtitle ScrollView
    let paymentSubtitle_SV: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    // MARK: Payment Subtitle
    let paymentSubtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .light)
//        l.text = """
//        • Payment will be charged to iTunes Account at confirmation of purchase
//        • Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period
//        • Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal
//        • Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase
//        • Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable
//        """
        l.text = "Plan automatically renews monthly until canceled."
        l.numberOfLines = 0
        l.textAlignment = .left

        return l
    }()
    
    // MARK: subscription Lable
    let subscriptionLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = "Not sure yet? Enable 7-day free trial"
        l.textAlignment = .left
        
        return l
    }()
    
    
    // MARK: Switch subscription
    let subscriptionSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(Any?.self, action: #selector(switchAction), for: .touchUpInside)
        s.isOn = false
        
        return s
    }()
    // MARK: Switch Action
    @objc func switchAction(_ sender: UISwitch) {
        
        guard sender.isOn == true else {
            self.purchaseButton.lable.text = "Try it".uppercased()
            return
        }
        
        // Deselect cell
        if let indexPath = self.contentCollectionView.indexPathsForSelectedItems?.first {
            contentCollectionView.deselectItem(at: indexPath, animated: true)
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
                            // user is not eligible
                            self.purchaseButton.lable.text = "Try it".uppercased()
                            sender.isOn = false
                            print("user is not eligible")
                            
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: Purchase Button
    let purchaseButton: PurchaseButton = {
        let b = PurchaseButton()
        b.addTarget(Any?.self, action: #selector(actPurchaseButton), for: .touchUpInside)
        return b
    }()
    
    // MARK: Action Purchase Button
    @objc func actPurchaseButton() {
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
        let index = self.contentCollectionView.indexPathsForSelectedItems?.first?.row
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
    
    
    
    // MARK: Terms Button
    let termsButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Terms Of Use", for: .normal)
        b.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(termsOfUseAct), for: .touchUpInside)
        return b
    }()
    
    @objc func termsOfUseAct() {
        print("termsOfUseAct")
        
        // Может понадобится?
//        FirebaseManager().getInformationDocuments(byName: "TermsOfUse") { model in
//            let vc = DescriptionVC()
//            vc.configure(
//                title: "Terms Of Use",
//                info: model.info,
//                about: nil
//            )
//            let navVC = UINavigationController(rootViewController: vc)
//            navVC.modalPresentationStyle = .overFullScreen
//            self.present(navVC, animated: true)
        
        
        guard let url = URL(string: "https://numerology-terms.web.app/") else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .pageSheet
            self.present(safariVC, animated: true)
        }
    }
    
    // MARK: Privacy Button
    let privacyButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Privacy Policy", for: .normal)
        b.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
        b.setTitleColor(UIColor.white, for: .normal)

        b.addTarget(Any?.self, action: #selector(privacyPolicyAct), for: .touchUpInside)
        return b
    }()
    @objc func privacyPolicyAct() {
//        FirebaseManager().getInformationDocuments(byName: "PrivacyPolicy") { model in
//            let vc = DescriptionVC()
//            vc.configure(
//                title: "Privacy Policy",
//                info: model.info,
//                about: nil
//            )
//            let navVC = UINavigationController(rootViewController: vc)
//            navVC.modalPresentationStyle = .overFullScreen
//            self.present(navVC, animated: true)
//        }
        
        
        guard let url = URL(string: "https://numerology-privacy.web.app/") else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .pageSheet
            self.present(safariVC, animated: true)
        }
        
    }
    
    // MARK: Restore Button
    let restoreButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Restore purchases", for: .normal)
        b.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(restoreAct), for: .touchUpInside)
        return b
    }()
    @objc func restoreAct() {
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
    
    
    
    
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style BG
//        view.backgroundColor = .systemGray4
        setBackground(named: "PaywallBG.png")
        self.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        
        // Delegate
        self.contentCollectionView.delegate = self
        self.contentCollectionView.dataSource = self
        self.contentCollectionView.register(PaywallCVCell.self, forCellWithReuseIdentifier: PaywallCVCell().payWallCVCellID)
        // UI content
        setUpStack()
        // Manager
        initializeIAP()
        
        
    }
    
    // MARK: view Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: Initialize IAP
    func initializeIAP() {
        
        // MARK: IDs
        let productIDs: [String] = ["Month_9.99","Year_29.99"]
        
        // MARK: getProducts
        Purchases.shared.getProducts(productIDs) { arr in
            self.storeProductArr = arr
            DispatchQueue.main.async {
                self.contentCollectionView.reloadData()
            }
        }
        
        // MARK: get Customer Info
//        Purchases.shared.getCustomerInfo { (customerInfo, error) in
////            if customerInfo?.entitlements["Access"]?.isActive == true {
////                // Nav
////                self.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
////            }
//        }
        
        
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
    
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // DocsStack
        let docsStack = UIStackView(arrangedSubviews: [termsButton,restoreButton,privacyButton])
        docsStack.axis = .horizontal
        docsStack.spacing = 0
        docsStack.distribution = .fillEqually
        
        
        // Scroll View
//        self.paymentSubtitle_SV.addSubview(paymentSubtitle)
//        paymentSubtitle_SV.contentSize = CGSize(width: paymentSubtitle.frame.size.width, height: paymentSubtitle.frame.size.height)
        
        // Button Stack
        let buttonStack = UIStackView(arrangedSubviews: [paymentSubtitle,purchaseButton]) // , paymentSubtitle_SV
        buttonStack.axis = .vertical
//        buttonStack.alignment = .fill // для Scroll view
        buttonStack.alignment = .fill
        buttonStack.spacing = 10
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Subscription Stack
        let subscriptionStack = UIStackView(arrangedSubviews: [subscriptionLable, subscriptionSwitch])
        subscriptionStack.axis = .horizontal
        subscriptionStack.alignment = .center
//        subscriptionStack.distribution = .fill
        subscriptionStack.spacing = 0
        
        // Top Content Stack
        let topContentStack = UIStackView(arrangedSubviews: [promoMainTitle,promoSubtitle,subscriptionStack])
        topContentStack.axis = .vertical
        topContentStack.alignment = .fill
        topContentStack.distribution = .fill
        topContentStack.spacing = 10
        
        // Middle Content Stack
        let middleContentStack = UIStackView(arrangedSubviews: [contentCollectionView])
        middleContentStack.axis = .vertical
        middleContentStack.alignment = .fill
        middleContentStack.distribution = .fill
        middleContentStack.spacing = 20
        
        // Top And Middle Stack
        let topAndMiddleStack = UIStackView(arrangedSubviews: [topContentStack,middleContentStack])
        topAndMiddleStack.axis = .vertical
        //        topAndMiddleStack.alignment = .fill
        //        topAndMiddleStack.distribution = .fill
        topAndMiddleStack.spacing = 32
        
        // Bottom Content Stack
        let bottomContentStack = UIStackView(arrangedSubviews: [UIView(),buttonStack,docsStack])
        bottomContentStack.axis = .vertical
        bottomContentStack.alignment = .center
//        bottomContentStack.distribution = .fill
        bottomContentStack.spacing = 10
//        bottomContentStack.backgroundColor = .purple
        
        
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [topAndMiddleStack,UIView(),bottomContentStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        // Большая вложенность потому что UI ломался.
        
        self.view.addSubview(contentStack)
        
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            // Уведомление перед покупкой !!!
//            paymentSubtitle.widthAnchor.constraint(equalTo: paymentSubtitle_SV.widthAnchor, constant: 0),
//            paymentSubtitle.topAnchor.constraint(equalTo: paymentSubtitle_SV.topAnchor),
//            paymentSubtitle.bottomAnchor.constraint(equalTo: paymentSubtitle_SV.bottomAnchor),
//            paymentSubtitle.leadingAnchor.constraint(equalTo: paymentSubtitle_SV.leadingAnchor),
//            paymentSubtitle.trailingAnchor.constraint(equalTo: paymentSubtitle_SV.trailingAnchor),
//
//            paymentSubtitle_SV.heightAnchor.constraint(equalToConstant: 34),
            purchaseButton.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor, constant: 0),
            purchaseButton.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor, constant: 0),
            buttonStack.leadingAnchor.constraint(equalTo: bottomContentStack.leadingAnchor, constant: 0),
            buttonStack.trailingAnchor.constraint(equalTo: bottomContentStack.trailingAnchor, constant: 0),
            
            contentCollectionView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            contentCollectionView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
            
            purchaseButton.heightAnchor.constraint(equalToConstant: 50),
            
            contentStack.topAnchor.constraint(equalTo: margin.topAnchor, constant: 8),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -20)
        ])
    }
    
}





// MARK: Collection View Delegate
extension PaywallViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.storeProductArr?.count ?? 0
        // Тут можно добавлять лоадер и убирать
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaywallCVCell().payWallCVCellID, for: indexPath as IndexPath) as! PaywallCVCell
        
        // MARK: Cell size
        cell.widthAnchor.constraint(equalToConstant: collectionView.frame.size.width).isActive = true
        
        let product = self.storeProductArr?[indexPath.row]
        
        guard let product = product else { return cell }
        
        // Config Cell 👎
        if indexPath.row == 0 {
            cell.configure(
                title: ((product.localizedTitle != " ") ? product.localizedTitle : "Yearly"),
                subtitle: "\(product.localizedPriceString ?? "0.00")/year billed annually"
            )
            
            
            
            
        } else if indexPath.row == 1 {
            cell.configure(
                title: product.localizedTitle ?? "Monthly",
                subtitle: "\(product.localizedPriceString ?? "0.00")/month"
            )
        }
        
        return cell
    }
    
    // MARK: Did Select Item At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
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
            
            if indexPath.row == 0 {
                self.purchaseButton.lable.text = "Buy Yearly".uppercased()
            } else if indexPath.row == 1 {
                self.purchaseButton.lable.text = "Buy Monthly".uppercased()
            }
            
            return true
        }
        
        return false
    }
    
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
