//
//  AboutYouCV.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit

class CharismaCV: ContentCollectionView {
    
    // data
    private var signsModel: SignsModel?
    private var signImage: UIImage?
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // MARK: - init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
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
        self.register(CharismaCVCell.self, forCellWithReuseIdentifier: CharismaCVCell.reuseID)
    }
    
}


// MARK: Delegate
extension CharismaCV: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharismaCVCell.reuseID, for: indexPath as IndexPath) as! CharismaCVCell
        
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        let sign = HoroscopeSign().findHoroscopeSign(byDate: dateOfBirth)
        
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                HoroscopeManager.shared.getSign(zodiacSign: sign) { model, image1, image2  in
                    //
                    self.signsModel = model
                    self.signImage = image1
                    //
                    cell.configure(
                        signDates: model.dateAboutYou,
                        setImage: image1
                    )
                }
            }
        }
        return cell
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        // MARK: Soul // 0
        if indexPath.row == 0 {
            
            guard let model = self.signsModel else { return }
            let vc = CharismaDetailVC()
            vc.signContent.configure(
                image: self.signImage ?? UIImage(named: "plug")!
            )
            
            vc.signTitle.text = model.zodiacSigns ?? ""
            vc.signSubtitle.text = model.dateAboutYou ?? ""
            
            vc.configureUI(
                title: "",
                info: "model.signCharacteristics",
                isPremium: true,
                visibleConstant: 120
            )

            vc.charismaCVViewModel = CharismaCVViewModel(signsModel: model)
            
            self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    
    // MARK: - layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 151, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let val = (collectionView.frame.width-151)/2
        return UIEdgeInsets(top: 0, left: val, bottom: 0, right: val)
    }
    
}
