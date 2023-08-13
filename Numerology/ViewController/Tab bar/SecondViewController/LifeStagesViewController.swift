//
//  LifeStagesViewController.swift
//  Numerology
//
//  Created by Serj on 04.08.2023.
//

import UIKit

class LifeStagesViewController: UIViewController {
    
    var firstModel: LifeStagesModel?
    var secondModel: LifeStagesModel?
    var thirdModel: LifeStagesModel?
    var fourthModel: LifeStagesModel?
    
    var firstStageNumber: Int = 0
    var secondStageNumber: Int = 0
    var thirdStageNumber: Int = 0
    var fourthStageNumber: Int = 0
    
    // MARK: Years title
    private let yearsTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.text = String("Years title 123")
        l.textAlignment = .left
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: contentTitle
    private let contentTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        l.text = String("TitleTitle")
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = "test testtest testtesttes ttest testtes ttesttest testte sttesttest testt esttesttest testtest testtest testtest testtest testtest"
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let about: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.text = "test testtest testtesttes ttest testtes ttesttest testte sttesttest testt esttesttest testtest testtest testtest testtest testtest"
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    

    let buttonsCollectionView: ContentCollectionView = {
        var cv = ContentCollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        // For size cell by content + Constraints in Cell
        if let collectionViewLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
//        cv.backgroundColor = .systemBlue
        return cv
    }()
    
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.setBackground(named: "SecondaryBG.png")
        
        setUpStack()
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        
        
        buttonsCollectionView.delegate = self
        buttonsCollectionView.dataSource = self
        buttonsCollectionView.register(ButtonCVCell.self, forCellWithReuseIdentifier: ButtonCVCell().buttonCVCellID)
        
        request()
        
        let indexPath = IndexPath(row: 0, section: 0)
        buttonsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
    }
    
    func request() {
        
        guard
            let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        else { return }
        
        let destiny = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
        let modelForRequest = CalculateNumbers().lifeStages(destiny: destiny, userDate: dateOfBirth)
        
        
        self.firstStageNumber = modelForRequest.firstStage
        self.secondStageNumber = modelForRequest.secondStage
        self.thirdStageNumber = modelForRequest.thirdStage
        self.fourthStageNumber = modelForRequest.fourthStage
        
        // First stage
        DispatchQueue.main.async {
            FirebaseManager().getLifeStages(number: modelForRequest.firstIndividualNumber) { model in
                self.firstModel = model
                self.yearsTitle.text = "The beginning of your life - \(modelForRequest.firstStage) years"
                self.contentTitle.text = "Your number of the first life stage"
                self.info.text = model.infoStages
                self.about.text = model.aboutStages
            }
            FirebaseManager().getLifeStages(number: modelForRequest.secondIndividualNumber) { model in
                self.secondModel = model
            }
            FirebaseManager().getLifeStages(number: modelForRequest.thirdIndividualNumber) { model in
                self.thirdModel = model
            }
            FirebaseManager().getLifeStages(number: modelForRequest.fourthIndividualNumber) { model in
                self.fourthModel = model
            }
        }
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
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
            v.layer.cornerRadius = 15
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.996, alpha: 1).cgColor
            return v
        }()
        cardView.addSubview(descriptionStack)
        
        
        let contentStack = UIStackView(arrangedSubviews: [buttonsCollectionView,yearsTitle, cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .fill
        contentStack.spacing = 24
//        contentStack.backgroundColor = .systemOrange
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        
        let margin = self.view.layoutMarginsGuide
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            descriptionStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            descriptionStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            descriptionStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
//
            
            buttonsCollectionView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            buttonsCollectionView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
//
            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 24),
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


    
    // MARK: Size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: (view.frame.size.width/4)-30, height: 40)
//    }
    
    // vertical Spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    
//  MARK: Horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 20
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 4
    }

    // MARK: Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCVCell().buttonCVCellID, for: indexPath as IndexPath) as! ButtonCVCell
        
        if indexPath.row == 0 {
            cell.configure(title: "First")
        } else if indexPath.row == 1 {
            cell.configure(title: "Second")
        } else if indexPath.row == 2 {
            cell.configure(title: "Third")
        } else if indexPath.row == 3 {
            cell.configure(title: "Fourth")
        }
        return cell
    }

    // MARK: Selected
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
        
        
        
        print("You selected cell #\(indexPath.item)!")
    }

}
