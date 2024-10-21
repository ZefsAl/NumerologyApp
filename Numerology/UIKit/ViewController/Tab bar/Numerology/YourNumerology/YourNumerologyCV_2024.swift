//
//  YourNumerologyCV_2024.swift
//  Numerology
//
//  Created by Serj_M1Pro on 20.04.2024.
//

import UIKit


class YourNumerologyCV_2024: ContentCollectionView {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // models instance
    private var numbersOfSoulModel: NumbersOfSoulModel?
    private var numbersOfDestinyModel: NumbersOfDestinyModel?
    private var numbersOfNameModel: NumbersOfNameModel?
    private var powerCodeModel: PowerCodeModel?
    
    
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
extension YourNumerologyCV_2024: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YourNumerologyCVCell.reuseID, for: indexPath as IndexPath) as! YourNumerologyCVCell
        
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        let name = UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as? String
        let surname = UserDefaults.standard.object(forKey: UserDefaultsKeys.surname) as? String
        
        if indexPath.row == 0 {
            // MARK: SOUL
            let number = CalculateNumbers().calculateNumberOfSoul(date: dateOfBirth)
            DispatchQueue.global().async {
                NumerologyManager.shared.getNumbersOfSoul(number: number) { model, img in
                    self.numbersOfSoulModel = model
                    cell.configure(
                        title: "Soul",
                        subtitle: model.infoSoul,
                        bgImage: img
                    )
                }
            }
            return cell
        }
        if indexPath.row == 1 {
            // MARK: Destiny
            let number = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
            DispatchQueue.global().async {
                NumerologyManager.shared.getNumbersOfDestiny(number: number) { model, img in
                    self.numbersOfDestinyModel = model
                    cell.configure(
                        title: "Destiny",
                        subtitle: model.infoDestiny,
                        bgImage: img
                    )
                }
            }
            
            return cell
        }
        if indexPath.row == 2 {
            // MARK: Name
            guard
                let name = name,
                let surname = surname
            else { return cell}
            let number = CalculateNumbers().calculateNumberOfName(name: name, surname: surname)
            
            DispatchQueue.global().async {
                NumerologyManager.shared.getNumbersOfName(number: number) { model, img in
                    self.numbersOfNameModel = model
                    cell.configure(
                        title: "Name",
                        subtitle: model.infoName,
                        bgImage: img
                    )
                }
            }
            
            return cell
        }
        if indexPath.row == 3 {
            // MARK: Power Code
            guard
                let name = name,
                let surname = surname
            else { return cell}
            
            let codeName = CalculateNumbers().calculateNumberOfName(name: name, surname: surname)
            let codeDestiny = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
            let number = CalculateNumbers().calculatePowerCode(codeName: codeName, codeDestiny: codeDestiny)
            
            DispatchQueue.global().async {
                NumerologyManager.shared.getPowerCode(number: number) { model, img in
                    self.powerCodeModel = model
                    cell.configure(
                        title: "Power",
                        subtitle: model.infoPower,
                        bgImage: img
                    )
                }
            }
            
            return cell
        }
        
        return cell
        
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            // MARK: Soul // 0
            guard
                let info = numbersOfSoulModel?.infoSoul,
                let about = numbersOfSoulModel?.aboutSoul
            else { return }
            //
            let vc = NumerologyPremiumDescriptionVC (
                title: "Your soul number",
                info: info + about,
                isPremium: false,
                //visibleConstant: getVisibleConstant(),
                topImageKey: .soul
            )
            //
            guard numbersOfSoulModel != nil else { return }
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        case 1:
            // MARK: Destiny // 1
            guard
                let info = numbersOfDestinyModel?.infoDestiny,
                let about = numbersOfDestinyModel?.aboutDestiny
            else { return }
            //
            let vc = NumerologyPremiumDescriptionVC (
                title: "Your destiny number",
                info: info + about,
                //visibleConstant: getVisibleConstant(),
                topImageKey: .destiny
            )
            //
            guard numbersOfDestinyModel != nil else { return }
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            // MARK: Name // 2
            guard
                let info = numbersOfNameModel?.infoName,
                let about = numbersOfNameModel?.aboutName
            else { return }
            //
            let vc = NumerologyPremiumDescriptionVC (
                title: "Your name number",
                info: info + about,
                //visibleConstant: getVisibleConstant(),
                topImageKey: .name
            )
            //
            guard numbersOfNameModel != nil else { return }
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        case 3:
            // MARK: Power Code // 3
            guard
                let info = powerCodeModel?.infoPower,
                let about = powerCodeModel?.aboutPower
            else { return }
            //
            let vc = NumerologyPremiumDescriptionVC (
                title: "Power Code",
                info: info + about,
                //visibleConstant: getVisibleConstant(),
                topImageKey: .power
            )
            //
            guard powerCodeModel != nil else { return }
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        default:
            break
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
            sectionHeader?.label.text = "Your Numerology"
            return sectionHeader ?? UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.size.width-36)/2)-8, height: 112)
    }
    
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

