//
//  ViewController.swift
//  Numerology
//
//  Created by Serj on 18.01.2024.
//

import UIKit


struct SignCellModel {
    let title: String
    let signImage: UIImage?
    var itemIndexPath: IndexPath?
}

class CompatibilityHoroscopeVC: UIViewController {
    
    let signsArr: [SignCellModel] = [
        SignCellModel(title: "aries",       signImage: UIImage(named: "aries")!),
        SignCellModel(title: "taurus",      signImage: UIImage(named: "taurus")!),
        SignCellModel(title: "gemini",      signImage: UIImage(named: "gemini")!),
        SignCellModel(title: "cancer",      signImage: UIImage(named: "cancer")!),
        SignCellModel(title: "leo",         signImage: UIImage(named: "leo")!),
        SignCellModel(title: "virgo",       signImage: UIImage(named: "virgo")!),
        SignCellModel(title: "sagittarius", signImage: UIImage(named: "sagittarius")!),
        SignCellModel(title: "pisces",      signImage: UIImage(named: "pisces")!),
        SignCellModel(title: "libra",       signImage: UIImage(named: "libra")!),
        SignCellModel(title: "capricorn",   signImage: UIImage(named: "capricorn")!),
        SignCellModel(title: "aquarius",    signImage: UIImage(named: "aquarius")!),
        SignCellModel(title: "scorpio",     signImage: UIImage(named: "scorpio")!),
    ]
    
    private let vcAccentColor: UIColor = #colorLiteral(red: 0.5254901961, green: 0.8078431373, blue: 1, alpha: 1)
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    private lazy var compareSignsStackView: CompareSignsStackView = {
        let sv = CompareSignsStackView(frame: .null, accentColor: vcAccentColor)
        return sv
    }()

    // MARK: - Сompatibility Button
    private lazy var compatibilityButton: RegularBigButton = {
        let b = RegularBigButton(
            frame: .zero,
            lable: "Compatibility",
            primaryColor: vcAccentColor
        )
        b.lable.font = UIFont(weight: .bold, size: 20)
        b.lable.textColor = UIColor(red: 0.05, green: 0.192, blue: 0.289, alpha: 1)
        b.addTarget(Any?.self, action: #selector(compatibilityAct), for: .touchUpInside)
        return b
    }()
    @objc private func compatibilityAct() {
        let firstSign = self.compareSignsStackView.firstSignModel?.title
        let secondSign = self.compareSignsStackView.secondSignModel?.title
        
        guard let firstSign = firstSign, let secondSign = secondSign else { return }
        HoroscopeManager.shared.getSignСompatibility(signOfUser: "\(firstSign)-\(secondSign)") { model in
            let navVC = UINavigationController(rootViewController: DetailCompatibilityHrscpVC(
                compatibilityHrscpModel: model,
                compareSignsStackView: self.compareSignsStackView
            ))
            navVC.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(navVC, animated: true)
        }
    }
    
    private let signsPickerCV: ContentCollectionView = {
        let cv = ContentCollectionView()
        // For size cell by content + Constraints in Cell
        if let collectionViewLayout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        cv.clipsToBounds = false
        return cv
    }()
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "CompatibilityBG.png")
        AnimatableBG().setBackground(vc: self)
        //
        setUpStack()
        register()
    }
    
    // MARK: - register
    private func register() {
        // Delegate Collection View
        self.signsPickerCV.delegate = self
        self.signsPickerCV.dataSource = self
        self.signsPickerCV.register(CompatibilityCVCell.self, forCellWithReuseIdentifier: CompatibilityCVCell.reuseID)
        //
        self.compareSignsStackView.compareSignsStackDelegate = self
    }

    // MARK: Set up Stack
    private func setUpStack() {

        // MARK: content Stack
        let contentStack = UIStackView(arrangedSubviews: [
            compareSignsStackView,
            compatibilityButton,
            signsPickerCV
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 32
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            compatibilityButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            compatibilityButton.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
            
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 32),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

// MARK: - Delegate
extension CompatibilityHoroscopeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func custDeselectAct(indexPath: IndexPath) {
        if self.compareSignsStackView.firstSignModel?.itemIndexPath == indexPath {
            self.compareSignsStackView.firstSignModel = nil
        } else if (self.compareSignsStackView.secondSignModel?.itemIndexPath == indexPath) && (self.compareSignsStackView.secondSignModel?.itemIndexPath != nil) {
            self.compareSignsStackView.secondSignModel = nil
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Переключание и установка SIgn - т.e при отсутствии одного из SIgn выбирая cell устанавливается на отсутствующее место.
        collectionView.deselectItem(at: indexPath, animated: true)

        var tap = 0
        
        if self.compareSignsStackView.firstSignModel == nil {
            let model = self.signsArr[indexPath.row]
            self.compareSignsStackView.firstSignModel = SignCellModel(
                title: model.title.capitalized,
                signImage: model.signImage,
                itemIndexPath: indexPath
            )
            tap += 1
        }
        
        if (self.compareSignsStackView.secondSignModel == nil) && (self.compareSignsStackView.firstSignModel != nil) && (tap != 1) {
            let model = self.signsArr[indexPath.row]
            self.compareSignsStackView.secondSignModel = SignCellModel(
                title: model.title.capitalized,
                signImage: model.signImage,
                itemIndexPath: indexPath
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        signsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompatibilityCVCell.reuseID, for: indexPath as IndexPath) as! CompatibilityCVCell
        
        let data = self.signsArr[indexPath.row]
        cell.configure(title: data.title.capitalized, signImage: data.signImage, primaryColor: vcAccentColor)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 69, height: 97)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.width/4)-69
    }

}

extension CompatibilityHoroscopeVC: CompareSignsStackDelegate {
    func firstRemoveButtonAct() {
        self.compareSignsStackView.firstSignModel = nil
    }
    
    func secondRemoveButtonAct() {
        self.compareSignsStackView.secondSignModel = nil
    }
}
