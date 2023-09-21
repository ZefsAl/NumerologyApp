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
        cv.clipsToBounds = false
        
        return cv
    }()
    
    // MARK: title
    let promoMainTitle: UILabel = {
        let l = UILabel()
        
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Full access by subscription!",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return l
    }()
    
    // MARK: promo Subtitle
    let promoSubtitle: UILabel = {
        let l = UILabel()
        
        l.textColor = .white
        l.numberOfLines = 0
        l.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Get personalized numerological predictions for your date of birth.",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return l
    }()
    // MARK: promo Subtitle 2
    let promoSubtitle2: UILabel = {
        let l = UILabel()
        
        l.textColor = .white
        l.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Learn about your life stages, partner compatibility and more...",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        l.font = UIFont(name: "SourceSerifPro-Light", size: 13)
        l.text = "Plan automatically renews monthly until canceled."
        l.numberOfLines = 0
        l.textAlignment = .left
        
        return l
    }()
    
    // MARK: subscription Lable
    let subscriptionLable: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.numberOfLines = 0
        l.font = UIFont(name: "Cinzel-Regular", size: 17)
        l.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Not sure yet?\nEnable 7-day free trial!",attributes: [NSAttributedString.Key.kern: -0.8, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return l
    }()
    
    // MARK: Switch subscription
    let subscriptionSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(Any?.self, action: #selector(switchAction), for: .touchUpInside)
        s.isOn = false
        s.onTintColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        
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
        b.titleLabel?.font = UIFont(name: "Cinzel-Bold", size: 11)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(termsOfUseAct), for: .touchUpInside)
        return b
    }()
    @objc func termsOfUseAct() {
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
    let privacyButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Privacy Policy", for: .normal)
        b.titleLabel?.font = UIFont(name: "Cinzel-Bold", size: 11)
        b.setTitleColor(UIColor.white, for: .normal)
        
        b.addTarget(Any?.self, action: #selector(privacyPolicyAct), for: .touchUpInside)
        return b
    }()
    @objc func privacyPolicyAct() {
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
        b.titleLabel?.font = UIFont(name: "Cinzel-Bold", size: 11)
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
    
    
    
    // MARK: tryFixFontScale
    private func tryFixFontScale() {
        if (self.view.frame.height < 844.0) {
            print("iphone 8")
            promoMainTitle.font = UIFont(name: "Cinzel-Regular", size: 26)
            promoSubtitle.font = UIFont(name: "Cinzel-Regular", size: 13)
            promoSubtitle2.font = UIFont(name: "Cinzel-Regular", size: 13)
            subscriptionLable.font = UIFont(name: "Cinzel-Regular", size: 15)
        } else {
            print("iphone 12")
            promoMainTitle.font = UIFont(name: "Cinzel-Regular", size: 34)
            promoSubtitle.font = UIFont(name: "Cinzel-Regular", size: 15)
            promoSubtitle2.font = UIFont(name: "Cinzel-Regular", size: 15)
            subscriptionLable.font = UIFont(name: "Cinzel-Regular", size: 17)
        }
        
        print("Screen height: \(self.view.frame.height)")
        //        8 iphone - Screen height: 667.0
        //        12 iphone - Screen height: 844.0
        
    }
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style BG
        setBackground(named: "SplashScreen.png")
        self.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        
        // Delegate
        self.contentCollectionView.delegate = self
        self.contentCollectionView.dataSource = self
        self.contentCollectionView.register(PaywallCVCell.self, forCellWithReuseIdentifier: PaywallCVCell().payWallCVCellID)
        // UI content
        setUpStack()
        // Manager
        initializeIAP()
        
        //fix
        self.tryFixFontScale()
        
        
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
        
        // Button Stack
        let buttonStack = UIStackView(arrangedSubviews: [paymentSubtitle,purchaseButton])
        buttonStack.axis = .vertical
        //        buttonStack.alignment = .fill // для Scroll view
        buttonStack.alignment = .fill
        buttonStack.spacing = 10
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Subscription Stack
        let subscriptionStack = UIStackView(arrangedSubviews: [subscriptionLable, subscriptionSwitch])
        subscriptionStack.axis = .horizontal
        subscriptionStack.alignment = .center
        subscriptionStack.spacing = 0
        
        // Top Content Stack
        let topContentStack = UIStackView(arrangedSubviews: [promoMainTitle,promoSubtitle,promoSubtitle2,subscriptionStack])
        topContentStack.axis = .vertical
        topContentStack.alignment = .fill
        topContentStack.distribution = .fill
        topContentStack.spacing = 4
        
        // Middle Content Stack
        let middleContentStack = UIStackView(arrangedSubviews: [contentCollectionView])
        middleContentStack.axis = .vertical
        middleContentStack.alignment = .fill
        middleContentStack.distribution = .fill
        middleContentStack.spacing = 20
        
        // Top And Middle Stack
        let topAndMiddleStack = UIStackView(arrangedSubviews: [topContentStack,middleContentStack])
        topAndMiddleStack.axis = .vertical
        topAndMiddleStack.spacing = 32
        
        // Bottom Content Stack
        let bottomContentStack = UIStackView(arrangedSubviews: [UIView(),buttonStack,docsStack])
        bottomContentStack.axis = .vertical
        bottomContentStack.alignment = .center
        bottomContentStack.spacing = 10
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [topAndMiddleStack,UIView(),bottomContentStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        // Большая вложенность потому что UI ломался.
        
        self.view.addSubview(contentStack)
        
        // MARK: Constraint
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            purchaseButton.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor, constant: 0),
            purchaseButton.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor, constant: 0),
            buttonStack.leadingAnchor.constraint(equalTo: bottomContentStack.leadingAnchor, constant: 0),
            buttonStack.trailingAnchor.constraint(equalTo: bottomContentStack.trailingAnchor, constant: 0),
            
            contentCollectionView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            contentCollectionView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
            
            
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
                title: ((product.localizedTitle != "") ? product.localizedTitle : "Yearly"),
                subtitle: "\(product.localizedPriceString) / year billed annually"
            )
        } else if indexPath.row == 1 {
            cell.configure(
                title: ((product.localizedTitle != "") ? product.localizedTitle : "Monthly") ,
                subtitle: "\(product.localizedPriceString) / month"
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
