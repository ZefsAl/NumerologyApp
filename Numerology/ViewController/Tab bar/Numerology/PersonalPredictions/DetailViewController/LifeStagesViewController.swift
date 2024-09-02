//
//  LifeStagesViewController.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

class LifeStagesViewController: UIViewController {
    
    var firstModel:  LifeStagesModel?
    var secondModel: LifeStagesModel?
    var thirdModel:  LifeStagesModel?
    var fourthModel: LifeStagesModel?
    
    var firstStageNumber: Int = 0
    var secondStageNumber: Int = 0
    var thirdStageNumber: Int = 0
    var fourthStageNumber: Int = 0
    
    
    // MARK: - Top Image
    private lazy var topImage: TopImage = TopImage(
        tint: DesignSystem.Numerology.primaryColor,
        referenceView: self.view
    )
    
    // MARK: Years title
    private let yearsTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 26)
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: contentTitle
    private let contentTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 26)
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 17)
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let about: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 17)
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    

    let buttonsCollectionView: ContentCollectionView = {
        var cv = ContentCollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.clipsToBounds = false
        return cv
    }()
    
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: 🟢 View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DesignSystem.Numerology.primaryColor)
        //
        self.setBackground(named: "MainBG2")
        //
        setupStack()
        //
        buttonsCollectionView.delegate = self
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.register(ChipsCVCell.self, forCellWithReuseIdentifier: ChipsCVCell().buttonCVCellID)
        //
        self.requestReview()
        requestLifeStages()
        //
        let indexPath = IndexPath(row: 0, section: 0)
        buttonsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
        // Notification
        self.numerologyImagesDataUpdated()
        NotificationCenter.default.addObserver(self, selector: #selector(numerologyImagesDataUpdated), name: .numerologyImagesDataUpdated, object: nil)
    }
    
    @objc private func numerologyImagesDataUpdated() {
        NumerologyImagesManager.shared.setTopImage(self.topImage, key: .lifeStages)
    }
    
    func requestLifeStages() {
        
        guard
            let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        else { return }
        
        let destiny = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
        let modelForRequest = CalculateNumbers().lifeStages(destiny: destiny, userDate: dateOfBirth)
        
        
        self.firstStageNumber = modelForRequest.firstStage
        self.secondStageNumber = modelForRequest.secondStage
        self.thirdStageNumber = modelForRequest.thirdStage
        self.fourthStageNumber = modelForRequest.fourthStage
        
        // First stage
        DispatchQueue.main.async {
            NumerologyManager().getLifeStages(number: modelForRequest.firstIndividualNumber) { model in
                self.firstModel = model
                self.yearsTitle.text = "The beginning of your life - \(modelForRequest.firstStage) years"
                self.contentTitle.text = "Your number of the first life stage"
                self.info.text = model.infoStages
                self.about.text = model.aboutStages
            }
            NumerologyManager().getLifeStages(number: modelForRequest.secondIndividualNumber) { model in
                self.secondModel = model
            }
            NumerologyManager().getLifeStages(number: modelForRequest.thirdIndividualNumber) { model in
                self.thirdModel = model
            }
            NumerologyManager().getLifeStages(number: modelForRequest.fourthIndividualNumber) { model in
                self.fourthModel = model
            }
        }
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        // MARK: description
        let descriptionStack = UIStackView(arrangedSubviews: [contentTitle,info,about])
        descriptionStack.alignment = .fill
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.spacing = 16
        descriptionStack.axis = .vertical

        // MARK: Card View + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = DesignSystem.maxCornerRadius
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
            
            return v
        }()
        cardView.addSubview(descriptionStack)
        
        
        let contentStack = UIStackView(arrangedSubviews: [topImage,buttonsCollectionView,yearsTitle, cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .fill
        contentStack.spacing = 24
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            descriptionStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            descriptionStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            descriptionStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),

            buttonsCollectionView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            buttonsCollectionView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),

            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: scrollViewMargin.bottomAnchor, constant: -24),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
}

// MARK: Collection View Delegate
extension LifeStagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (collectionView.frame.size.width / 4) - 4,
            height: 30
        )
    }
    
//  MARK: Horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 4
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 4
    }

    // MARK: Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipsCVCell().buttonCVCellID, for: indexPath as IndexPath) as! ChipsCVCell
        
        if indexPath.row == 0 {
            cell.configure(title: "First")
//            cell.premiumBadgeManager.invalidateBadgeAndNotification() // cust Reject
        } else if indexPath.row == 1 {
            cell.configure(title: "Second")
        } else if indexPath.row == 2 {
            cell.configure(title: "Third")
        } else if indexPath.row == 3 {
            cell.configure(title: "Fourth")
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard [0].contains(indexPath.row) else {
            guard self.checkAccessContent() == true else { return false }
            return true
        }
        return true
    }

    // MARK: did Select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // First
        if indexPath.row == 0 {
            self.yearsTitle.text = "The beginning of your life - \(firstStageNumber) years"
            self.contentTitle.text = "Your number of the first life stage"
            self.info.text = firstModel?.infoStages
            self.about.text = firstModel?.aboutStages
        }
        // Second
        if indexPath.row == 1 {
            self.yearsTitle.text = "\(firstStageNumber) years - \(secondStageNumber) years"
            self.contentTitle.text = "Your number of the second life stage"
            self.info.text = secondModel?.infoStages
            self.about.text = secondModel?.aboutStages
        }
        // Third
        if indexPath.row == 2 {
            self.yearsTitle.text = "\(secondStageNumber) years - \(thirdStageNumber) years"
            self.contentTitle.text = "Your number of the third life stage"
            self.info.text = thirdModel?.infoStages
            self.about.text = thirdModel?.aboutStages
        }
        // Fourth
        if indexPath.row == 3 {
            self.yearsTitle.text = "\(fourthStageNumber) years - the end of your life"
            self.contentTitle.text = "Your number of the fourth life stage"
            self.info.text = fourthModel?.infoStages
            self.about.text = fourthModel?.aboutStages
        }
    }
}



