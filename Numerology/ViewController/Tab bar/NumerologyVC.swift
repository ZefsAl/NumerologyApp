//
//  NumerologyVC.swift
//  Numerology
//
//  Created by Serj on 20.10.2023.
//

import UIKit

class NumerologyVC: UIViewController {
    
    let contentCollectionView: ContentCollectionView = {
       let cv = ContentCollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.backgroundColor = .systemOrange
        return cv
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.175999999, green: 0.09000000358, blue: 0.172999993, alpha: 1)
        setupUI()
        
        AnimatableBG().setBackground(vc: self)
    }
    
    
    
    // MARK: - Register
    private func setupContentCollectionView() {
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        // Cell
        contentCollectionView.register(BigCardCVCell.self, forCellWithReuseIdentifier: BigCardCVCell().bigCardCVCID)
    }
    
    
    
}

// MARK: setup UI
extension NumerologyVC {
    private func setupUI() {
        
        self.view.addSubview(contentCollectionView)
        
        let viewMargin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentCollectionView.topAnchor.constraint(equalTo: viewMargin.topAnchor, constant: 0),
            contentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentCollectionView.bottomAnchor.constraint(equalTo: viewMargin.bottomAnchor, constant: 0),
            
        ])
    }
}


// MARK: - Delegate
extension NumerologyVC: UICollectionViewDelegate {
    
}

// MARK: - DataSource
extension NumerologyVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}

// MARK: - FlowLayout
extension NumerologyVC: UICollectionViewDelegateFlowLayout {
    
}
