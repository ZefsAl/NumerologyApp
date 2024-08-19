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
    
    var onboardingIsCompleted: Bool?
    
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
    
    // MARK: - config Compositional Layout CV
    private func configCompositionalLayoutCV() {
        // iphone 12
        
        // Fill Width for cells by screen - Хорошее решение но конфликтует с авто высотой и не отображается, только в ViewController будет работать или указать высоту явно
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
    }
    // MARK: - config Flow Layout CV
    private func configFlowLayoutCV() {
        // iphone 8
        // For size cell by content + Constraints in Cell
        if let collectionViewLayout = productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.minimumInteritemSpacing = 0
        }
    }
    
    // Разный конфиг layout для размеров экрана и ячеек
    private func distributedsetupCVLayout() {
        if isIphone_12(view: self.view) {
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
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
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
        let color = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1)
        let b = PurchaseButton(frame: .zero, title: "Continue", primaryColor: color)
        b.heightAnchor.constraint(equalToConstant: 64).isActive = true
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
        
        if subscriptionSwitch.isOn && storeProductIndex.productIdentifier == "Year_29.99" {
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
    
    // MARK: toggle On State
    private func toggleOnState() {
        DispatchQueue.main.async {
            // Default Select
            self.productsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
            self.purchaseButton.stateConfig(state: true)
        }
    }
    
    // MARK: subscription Lable
    private let subscriptionLable: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.numberOfLines = 0
        l.font = UIFont(weight: .regular, size: 15)
        l.textAlignment = .left
        l.text =  "Not sure yet? Enable free trial!"
        return l
    }()
    
    // MARK: Switch
    private let subscriptionSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(Any?.self, action: #selector(switchAction), for: .valueChanged)
        s.onTintColor = #colorLiteral(red: 0.2980392157, green: 0.2901960784, blue: 0.5411764706, alpha: 1)
        return s
    }()
    
    
    // MARK: Switch Action
    @objc private func switchAction(_ sender: UISwitch) {
        
        guard sender.isOn == true else {
            self.subscriptionLable.text = "Not sure yet? Enable free trial!"
            return
        }
        
        self.purchaseButton.stateConfig(state: true)
        self.subscriptionLable.text = "7-day FREE trial enable"
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
        guard let bool = onboardingIsCompleted else { return }
        if bool {
            self.dismiss(animated: true)
        } else {
            
            AppRouter.shared.setAppFlow(.app, animated: true)
            // 🔴 Test
            let dataName = UserDefaults.standard.object(forKey: UserDefaultsKeys.name)
            let dataSurname = UserDefaults.standard.object(forKey: UserDefaultsKeys.surname)
            let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth)
            
            print(dataName as Any)
            print(dataSurname as Any)
            print(dateOfBirth as Any)
            
        }
    }
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // view style
        self.setBackground(named: "DarkBG.png")
        AnimatableBG().setBackground(vc: self)
        // UI
        setupUI()
        // Delegate
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        // Register
        registerCells()
        // In-App
        initializeIAP()
        // Layout Config
        distributedsetupCVLayout()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.customCarousel_CV.timer.invalidate()
    }
    
    // MARK: - init
    init(onboardingIsCompleted: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.onboardingIsCompleted = onboardingIsCompleted
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup UI
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
        self.view.addSubview(mainStack)
        self.view.addSubview(closeButton)
        let viewMargin = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: viewMargin.trailingAnchor),
            customCarousel_CV.heightAnchor.constraint(equalToConstant: 183),
            mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
    }
}


// MARK: - Products delegate
extension PaywallVC_V2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.storeProductArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = self.storeProductArr?[indexPath.row]
        
        guard let product = product else { return UICollectionViewCell() }
        
        // MARK: - Config cells
        if isIphone_12(view: self.view) {
            return longCellsConfig(product: product, collectionView: collectionView, indexPath: indexPath)
        } else {
            return miniCellsConfig(product: product, collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    // MARK: - mini Cells Config
    private func miniCellsConfig(product: StoreProduct, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // FOR iphone 8 case
        if indexPath.row == 0 {
            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPromoCVCell().miniPromoCVCell_ID, for: indexPath as IndexPath) as! MiniPromoCVCell
            miniCell.configure(
                discount: "save 68%".uppercased(),
                title: "\(product.localizedTitle)",
                subtitle: "3.33 $ / month",
                price: "\(product.localizedPriceString) / year"
            )
            toggleOnState()
            return miniCell
        } else if indexPath.row == 1 {
            let miniCell = collectionView.dequeueReusableCell(withReuseIdentifier: Mini2PromoCVCell().mini2PromoCVCell_ID, for: indexPath as IndexPath) as! Mini2PromoCVCell
            
            miniCell.configure(
                title: "\(product.localizedTitle)",
                price: "\(product.localizedPriceString) / month"
            )
            return miniCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // MARK: - long Cells Config
    private func longCellsConfig(product: StoreProduct, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        //        // Config Cell normal case
        if indexPath.row == 0 {
            let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPromoCVCell().bigPromoCVCell_ID, for: indexPath as IndexPath) as! BigPromoCVCell
            bigCell.configure(
                discount: "save 68%".uppercased(),
                title: "\(product.localizedTitle)",
                subtitle: "3.33 $ / month",
                price: "\(product.localizedPriceString) / year"
            )
            toggleOnState()
            return bigCell
        } else if indexPath.row == 1 {
            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: RegularPromoCVCell().regularPromoCVCell_ID, for: indexPath as IndexPath) as! RegularPromoCVCell
            regularCell.configure(
                title: "\(product.localizedTitle)",
                price: "\(product.localizedPriceString) / month"
            )
            return regularCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    // MARK: should Select Item At
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        // Deselect
        let item = collectionView.cellForItem(at: indexPath)
        
        guard let item = item else { return false }
        
        if item.isSelected {
            collectionView.deselectItem(at: indexPath, animated: true)
            subscriptionSwitch.isOn = false
            self.purchaseButton.stateConfig(state: false)
            self.switchAction(self.subscriptionSwitch)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            
            self.purchaseButton.stateConfig(state: true)
            return true
        }
        
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if !isIphone_12(view: self.view) {
            return CGSize(width: (collectionView.frame.size.width/2)-4, height: 122)
        } else {
            return CGSize()
        }
    }
    
}



// MARK: Initialize IAP
extension PaywallVC_V2 {
    
    func initializeIAP() {
        
        // MARK: IDs
        let productIDs: [String] = ["Month_9.99","Year_29.99"]
        
        // MARK: get Products
        Purchases.shared.getProducts(productIDs) { arr in
            self.storeProductArr = arr
            
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
        
    }
}
