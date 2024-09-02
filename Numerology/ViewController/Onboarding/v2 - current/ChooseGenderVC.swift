//
//  ChooseGenderVC.swift
//  Numerology
//
//  Created by Serj on 25.10.2023.
//

import UIKit

class ChooseGenderVC: UIViewController {
    
    // MARK: title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.font = UIFont(name: "Cinzel-Regular", size: 48)
        l.textAlignment = .center
        l.text = "Choose your gender"
        l.adjustsFontSizeToFitWidth = true
        
        return l
    }()
    // MARK: Continue Btn
    let continueButton: RegularBigButton = {
        let b = RegularBigButton(frame: .zero, lable: "Continue")
        b.addTarget(Any?.self, action: #selector(continueBtnAction), for: .touchUpInside)
        return b
    }()
    // MARK: Continue Btn Action
    @objc private func continueBtnAction() {
        print("continueBtnAction")
        let selected = self.contentCollectionView.indexPathsForSelectedItems
        guard selected != [] else { return }
        self.navigationController?.pushViewController(EnterUserDataVC(), animated: true)
    }
    
    private let contentCollectionView: ContentCollectionView = {
       let cv = ContentCollectionView()
        cv.clipsToBounds = false
        return cv
    }()
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBackground(named: "Slice5")
        AnimatableBG().setBackground(vc: self)
        
        configureCollectionView()
        setupStack()
        
    }
    
    private func setSelect() {
        DispatchQueue.main.async {
            let select: IndexPath = [0,1]
            self.contentCollectionView.selectItem(at: select, animated: true, scrollPosition: .left)
        }
    }
    
    private func configureCollectionView() {
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        
        contentCollectionView.register(GenderCVCell.self, forCellWithReuseIdentifier: GenderCVCell.reuseID)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [mainTitle,contentCollectionView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 32
        
        
        self.view.addSubview(contentStack)
        self.view.addSubview(continueButton)
        
        let viewMargin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            continueButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            continueButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            continueButton.bottomAnchor.constraint(equalTo: viewMargin.bottomAnchor, constant: -52),
            
            contentStack.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 44),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
    }

}

// MARK: Delegate
extension ChooseGenderVC: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
}

// MARK: - DataSource
extension ChooseGenderVC: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        onboardingQuizData.answer.count
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderCVCell.reuseID, for: indexPath as IndexPath) as? GenderCVCell
        
        if indexPath.row == 0 {
            cell?.configure(title: "Man", iconNamed: "Man.png")
            return cell ?? UICollectionViewCell()
        } else {
            cell?.configure(title: "Female", iconNamed: "Female.png")
            return cell ?? UICollectionViewCell()
        }
        
        
    }
    
}

// MARK: - FlowLayout
extension ChooseGenderVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        return CGSize(width: (collectionView.frame.size.width)/2, height: 64)
        return CGSize(width: (collectionView.frame.size.width-20)/2, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    // Vertical spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
}


