//
//  YourNumerologyCV_2024.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.04.2024.
//

import UIKit


class YourMoneyCV: ContentCollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // models
    private var numbersOfMoneyModel: NumbersOfMoneyModel?
    
    // MARK: - init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        //
        self.backgroundColor = .clear
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func register() {
        // Delegate Collection View
        self.delegate = self
        self.dataSource = self
        self.register(YourNumerologyCVCell.self, forCellWithReuseIdentifier: YourNumerologyCVCell.reuseID)
        // Header
        self.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
    }
    
}


// MARK: Delegate
extension YourMoneyCV: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YourNumerologyCVCell.reuseID, for: indexPath as IndexPath) as! YourNumerologyCVCell
        
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        let name = UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as? String
        
        // MARK: Money
        guard let name = name else { return cell }
        let number = CalculateNumbers().calculateNumberOfMoney(name: name, date: dateOfBirth)
        NumerologyManager.shared.getNumbersOfMoney(number: number) { model, img in
            self.numbersOfMoneyModel = model
            cell.configure(
                title: "Money",
                subtitle: model.infoMoney,
                bgImage: img
            )
        }
        
        return cell
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        func getVisibleConstant() -> CGFloat? {
            guard let height = self.remoteOpenDelegate?.openFrom?.view.bounds.height else { return nil }
            let visibleConstant: CGFloat? = height/4
            return visibleConstant ?? nil
        }
        
        if indexPath.row == 0 {
            // MARK: Money // 1
            guard
                let info = numbersOfMoneyModel?.infoMoney,
                let about = numbersOfMoneyModel?.aboutMoney
            else { return }
            //
            let vc = NumerologyPremiumDescriptionVC (
                title: "Your money number",
                info: info + about,
                visibleConstant: getVisibleConstant(),
                topImageKey: .money
            )
            //
            guard numbersOfMoneyModel != nil else { return }
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    // MARK: - Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    //  Supplementary Element
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: IndexPath(item: 0, section: 0)) as? SectionHeaderView
            sectionHeader?.label.text = "Your Money"
            return sectionHeader ?? UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width-36, height: 112)
    }
    
    
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

