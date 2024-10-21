//
//  OnboardingVC_v2.swift
//  Numerology
//
//  Created by Serj on 24.10.2023.
//

import UIKit


class QuizVC: UIViewController {
    
    var currentQuiz: Int = 0
    
    // MARK: title
    private let questionTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.font = UIFont(name: "Cinzel-Regular", size: 44)
        l.textAlignment = .center
        l.text = "One step left"
        
        return l
    }()
    
    // MARK: subtitle
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.numberOfLines = 0
        l.font = UIFont(name: "SourceSerifPro-Light", size: 28)
        l.lineBreakMode = .byWordWrapping
        l.textAlignment = .center
        l.text = "Are you ready to use the signs of destiny?"
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
        
        self.navigationController?.pushViewController(PaywallVC_V2(onboardingIsCompleted: false), animated: true)
//        AppRouter.shared.setAppFlow(.app, animated: true)
    }
    
    // MARK: - content Collection View
    private let contentCollectionView: ContentCollectionView = {
       let cv = ContentCollectionView()
        cv.clipsToBounds = false
        return cv
    }()
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "Slice7")
        AnimatableBG().setBackground(vc: self)
        
        configureCollectionView()
        setupStack()
        setSelect()
    }
    // MARK: - set Select
    private func setSelect() {
        DispatchQueue.main.async {
            let select: IndexPath = [0,0]
            self.contentCollectionView.selectItem(at: select, animated: true, scrollPosition: .left)
        }
    }
    // MARK: - configure Collection View
    private func configureCollectionView() {
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(OnboardingQuizCell.self, forCellWithReuseIdentifier: OnboardingQuizCell.reuseID)
    }
    
    // MARK: - view Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: UI
    private func setupStack() {
        
        // titleStack
        let textStack = UIStackView(arrangedSubviews: [questionTitle,subtitle])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .fill
        textStack.spacing = 12
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [textStack,contentCollectionView])
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
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
        ])
    }

}

// MARK: Delegate
extension QuizVC: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
}

// MARK: - DataSource
extension QuizVC: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Data
//        let data = onboardingQuizData.answer[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingQuizCell.reuseID, for: indexPath as IndexPath) as? OnboardingQuizCell
        
        if indexPath.row == 0 {
            cell?.configure(title: "Yes")
            return cell ?? UICollectionViewCell()
        } else if indexPath.row == 1 {
            cell?.configure(title: "No")
            return cell ?? UICollectionViewCell()
        }
        return cell ?? UICollectionViewCell()
    }
    
}

// MARK: - FlowLayout
extension QuizVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width)-9, height: 64)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}
