//
//  HoroscopeDescriptionVC.swift
//  Numerology
//
//  Created by Serj on 28.11.2023.
//

import Foundation
import UIKit


class HoroscopeDescriptionVC: UIViewController {
    
    // model
    private var todayHoroscope: HoroscopeDefaultModel?
    private var tomorrowHoroscope: HoroscopeDefaultModel?
    private var weekHoroscope: HoroscopeDefaultModel?
    private var monthHoroscope: MonthModel?
    private var year2023Horoscope: Year2023Model?
    private var year2024Horoscope: Year2024Model?
    
    // MARK: - AboutYouCV
    let horoscopeDescriptionAboutCV = HoroscopeDescriptionAboutCV()
    
    let horoscopeButtonsCV: HoroscopeButtonsCV = {
        var cv = HoroscopeButtonsCV()
        return cv
    }()
    
    let mainInfo: AccordionView = {
        let v = AccordionView()
        v.showAccordion()
        return v
    }()
    
    let learnMore: AccordionView = {
       let v = AccordionView()
       v.showAccordion()
       return v
   }()
    
    // MARK: Scroll View
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
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        setBackground(named: "bgHoroscope")
        AnimatableBG().setBackground(vc: self)
        setUpStack()
        requestAllHoroscope()
        register()
    }
    
    private func register() {
        self.horoscopeButtonsCV.delegate = self
        self.horoscopeButtonsCV.dataSource = self
    }
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [mainInfo,learnMore])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 8
        
        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = 2
            v.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
            return v
        }()
        cardView.addSubview(contentStack)
        //
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(horoscopeDescriptionAboutCV)
        contentScrollView.addSubview(horoscopeButtonsCV)
        contentScrollView.addSubview(cardView)
        //
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            //
            // contentStack
            contentStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -0),
            contentStack.widthAnchor.constraint(equalTo: cardView.widthAnchor, constant: -32),
            //
            horoscopeDescriptionAboutCV.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: -24),
            horoscopeDescriptionAboutCV.widthAnchor.constraint(equalTo: scrollViewMargin.widthAnchor, constant: 0),
            horoscopeDescriptionAboutCV.heightAnchor.constraint(equalToConstant: 117),
            //
            horoscopeButtonsCV.topAnchor.constraint(equalTo: horoscopeDescriptionAboutCV.bottomAnchor, constant: 74),
            horoscopeButtonsCV.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            horoscopeButtonsCV.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            // Card View
            cardView.topAnchor.constraint(equalTo: horoscopeButtonsCV.bottomAnchor, constant: 24),
            cardView.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            cardView.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            cardView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            cardView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            //
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}


extension HoroscopeDescriptionVC {
    private func requestAllHoroscope() {
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let sign = HoroscopeSign().findHoroscopeSign(find: dateOfBirth)

        // Today // fix
        HoroscopeManager.shared.getTodayHoroscope { model in
            self.todayHoroscope = model
            //
            self.mainInfo.accordionButton.configure(title: "Today horoscope")
            self.mainInfo.info.text = nil
            self.mainInfo.about.text = model.info
            self.learnMore.isHidden = true
        }
        // Tomorrow
        HoroscopeManager.shared.getTodayHoroscope { model in
            self.tomorrowHoroscope = model
        }
        // Week
        HoroscopeManager.shared.getWeekHoroscope { model in
            self.weekHoroscope = model
        }
        // Month
        HoroscopeManager.shared.getMonthHoroscope(zodiacSigns: sign) { model in
            self.monthHoroscope = model
        }
        // Year 2023
        HoroscopeManager.shared.getYear2023Horoscope(zodiacSigns: sign) { model in
            self.year2023Horoscope = model
        }
        // Year 2024
        HoroscopeManager.shared.getYear2024Horoscope(zodiacSigns: sign) { model in
            self.year2024Horoscope = model
        }
    }
}





// MARK: - buttons Collection View
extension HoroscopeDescriptionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (collectionView.frame.size.width / 3) - 10,
            height: 40
        )
    }
    
    //  MARK: Horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    // MARK: Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipsCVCell().buttonCVCellID, for: indexPath as IndexPath) as! ChipsCVCell
        cell.primaryColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        
        collectionView.selectItem(
            at: IndexPath(row: 0, section: 0),
            animated: true,
            scrollPosition: .centeredVertically
        )
        if indexPath.row == 0 {
            cell.configure(title: "Today")
        } else if indexPath.row == 1 {
            cell.configure(title: "Tomorrow")
        } else if indexPath.row == 2 {
            cell.configure(title: "Week")
        } else if indexPath.row == 3 {
            cell.configure(title: "Month")
        } else if indexPath.row == 4 {
            cell.configure(title: "Year 2023")
        } else if indexPath.row == 5 {
            cell.configure(title: "Year 2024")
        }
        return cell
    }
    
    // MARK: Selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            self.mainInfo.accordionButton.configure(title: "Today horoscope")
            self.mainInfo.info.text = nil
            self.mainInfo.about.text = self.todayHoroscope?.info
            self.learnMore.isHidden = true
        }
        if indexPath.row == 1 {
            //check
            guard self.checkAccessContent() == true else { return }
            self.mainInfo.accordionButton.configure(title: "Tomorrow horoscope")
            self.mainInfo.info.text = nil
            self.mainInfo.about.text = self.tomorrowHoroscope?.info
            self.learnMore.isHidden = true
        }
        if indexPath.row == 2 {
            //check
            guard self.checkAccessContent() == true else { return }
            self.mainInfo.accordionButton.configure(title: "Week horoscope")
            self.mainInfo.info.text = nil
            self.mainInfo.about.text = self.weekHoroscope?.info
            self.learnMore.isHidden = true
        }
        if indexPath.row == 3 {
            //check
            guard self.checkAccessContent() == true else { return }
            self.mainInfo.accordionButton.configure(title: "Month horoscope")
            self.mainInfo.info.text = nil
            self.mainInfo.about.text = self.monthHoroscope?.yourMonthlyHoroscope
            //
            self.learnMore.isHidden = false
            self.learnMore.accordionButton.configure(title: "Main trends")
            self.learnMore.info.text = nil
            self.learnMore.about.text = self.monthHoroscope?.mainTrends
        }
        if indexPath.row == 4 {
            //check
            guard self.checkAccessContent() == true else { return }
            self.mainInfo.accordionButton.configure(title: "Year 2023 horoscope")
            self.mainInfo.info.text = nil
            self.mainInfo.about.text = self.year2023Horoscope?.yourHoroscope
            self.learnMore.isHidden = true
        }
        if indexPath.row == 5 {
            //check
            guard self.checkAccessContent() == true else { return }
            self.mainInfo.accordionButton.configure(title: "Year 2024 horoscope")
            self.mainInfo.info.text = nil
            self.mainInfo.about.text = self.year2024Horoscope?.yourHoroscope
            //
            self.learnMore.isHidden = false
            self.learnMore.accordionButton.configure(title: "Main trends")
            self.learnMore.info.text = nil
            self.learnMore.about.text = self.year2024Horoscope?.mainTrends
        }
    }
}

