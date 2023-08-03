//
//  FirstViewController.swift
//  Numerology
//
//  Created by Serj on 18.07.2023.
//

import UIKit

class FirstViewController: UIViewController {

    // models instance
    var boardOfDayModel: BoardOfDayModel?
    var numbersOfSoulModel: NumbersOfSoulModel?
    var numbersOfDestinyModel: NumbersOfDestinyModel?
    var numbersOfNameModel: NumbersOfNameModel?
    var numbersOfMoneyModel: NumbersOfMoneyModel?
    var powerCodeModel: PowerCodeModel?
    
    
    
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    let cardCollectionView = CardCollectionView()
    
//    var items = ["0","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    
    
    
    
    
    
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Style
        view.backgroundColor = .systemGray
        
        
        setBackground()
        // Setup
//        configureNavView()
        setupView()
        setConstraints()
        setStackContentSV()
        
        
        
        
        // Delegate Collection View
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        cardCollectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell().cardCollectionID)
        cardCollectionView.register(BigCardCVCell.self, forCellWithReuseIdentifier: BigCardCVCell().bigCardCVCID)
        
        
        
        
    }
    
    
    
    
    
    // MARK: View Did Appear // GRADIENT
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        Gradients().setBlackGradient(forView: self.tipCardView)
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: setBackground
    func setBackground() {
        let background = UIImage(named: "MainBG.png")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    
    
    
    // MARK: Setup View
    private func setupView() {
        view.addSubview(contentScrollView)
    }
    
    // MARK: Configure Nav View
    private func configureNavView() {
        
    }
}


// MARK: UICollectionView Delegate
extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 👎
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell().cardCollectionID, for: indexPath as IndexPath) as! CardCollectionViewCell
        
        let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigCardCVCell().bigCardCVCID, for: indexPath as IndexPath) as! BigCardCVCell
        
//        cell.configure(title: self.items[indexPath.row], subtitle: nil, bgImage: nil)
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        let name = UserDefaults.standard.object(forKey: "nameKey") as? String
        let surname = UserDefaults.standard.object(forKey: "surnameKey") as? String
        
        
        if indexPath.row == 0 {
            // MARK: TIP // 0
            FirebaseManager.shared.getBoardOfDay { model in
                self.boardOfDayModel = model
                bigCell.configure(
                    title: "Your tip of the day!",
                    subtitle: model.dayTip
                )
            }
          return bigCell
        } else if indexPath.row == 1 {
            // MARK: SOUL // 1
            let number = CalculateNumbers().calculateNumberOfSoul(date: dateOfBirth)
            FirebaseManager.shared.getNumbersOfSoul(number: number) { model, img in
                self.numbersOfSoulModel = model
                cell.configure(
                    title: "Soul",
                    subtitle: model.infoSoul,
                    bgImage: img
                )
            }
            return cell
        } else if indexPath.row == 2 {
            // MARK: Destiny // 2
            let number = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
            FirebaseManager.shared.getNumbersOfDestiny(number: number) { model, img in
                self.numbersOfDestinyModel = model
                cell.configure(
                    title: "Destiny",
                    subtitle: model.infoDestiny,
                    bgImage: img
                )
            }
            
            return cell
        } else if indexPath.row == 3 {
            // MARK: Name // 3
            guard 
                let name = name,
                let surname = surname
            else { return cell}
            let number = CalculateNumbers().calculateNumberOfName(name: name, surname: surname)
            FirebaseManager.shared.getNumbersOfName(number: number) { model, img in
                self.numbersOfNameModel = model
                cell.configure(
                    title: "Name",
                    subtitle: model.infoName,
                    bgImage: img
                )
            }
            
            return cell
        } else if indexPath.row == 4 {
            // MARK: Money // 4
            guard
                let name = name
            else { return cell}
            let number = CalculateNumbers().calculateNumberOfMoney(name: name, date: dateOfBirth)
            FirebaseManager.shared.getNumbersOfMoney(number: 1) { model, img in
                self.numbersOfMoneyModel = model
                cell.configure(
                    title: "Money",
                    subtitle: model.infoMoney,
                    bgImage: img
                )
            }
            
            return cell
        } else if indexPath.row == 5 {
            // MARK: Power Code // 5
            guard
                let name = name,
                let surname = surname
            else { return cell}
            
            let codeName = CalculateNumbers().calculateNumberOfName(name: name, surname: surname)
            let codeDestiny = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
            let number = CalculateNumbers().calculatePowerCode(codeName: codeName, codeDestiny: codeDestiny)
            
            FirebaseManager.shared.getPowerCode(number: number) { model, img in
                self.powerCodeModel = model
                cell.configure(
                    title: "Power Code",
                    subtitle: model.infoPower,
                    bgImage: img
                )
            }
            
            return cell
        }
        else {
            return cell
        }
        
    }
    
    // MARK: did Select ItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // handle tap events
           print("You selected cell #\(indexPath.item)!")
        
        // MARK: Tip // 0
        if indexPath.row == 0 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your tip of the day!",
                info: "Your tip of the day!",
//                info: boardOfDayModel?.dayTip,
                about: nil
            )
            if boardOfDayModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
            }
        }
        
        // MARK: Soul // 1
        if indexPath.row == 1 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your soul number",
                info: numbersOfSoulModel?.infoSoul,
                about: numbersOfSoulModel?.aboutSoul
            )
            if numbersOfSoulModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
            }
        }
        
        // MARK: Destiny // 2
        if indexPath.row == 2 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your destiny number",
                info: numbersOfDestinyModel?.infoDestiny,
                about: numbersOfDestinyModel?.aboutDestiny
            )
            if numbersOfDestinyModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
            }
        }
        
        // MARK: Name // 3
        if indexPath.row == 3 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your name number",
                info: numbersOfNameModel?.infoName,
                about: numbersOfNameModel?.aboutName
            )
            if numbersOfNameModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
            }
        }
        
        // MARK: Money // 4
        if indexPath.row == 4 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Your money number",
                info: numbersOfMoneyModel?.infoMoney,
                about: numbersOfMoneyModel?.aboutMoney
            )
            if numbersOfMoneyModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
            }
        }
        
        // MARK: Power Code // 5
        if indexPath.row == 5 {
            let vc = DescriptionVC()
            vc.configure(
                title: "Power Code",
                info: powerCodeModel?.infoPower,
                about: powerCodeModel?.aboutPower
            )
            if powerCodeModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
            }
        }
        
        
        
       }
}

// MARK: Collection View Delegate FlowLayout
extension FirstViewController: UICollectionViewDelegateFlowLayout {
 
    // Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: (collectionView.frame.size.width), height: 160)
        } else {
            return CGSize(width: (collectionView.frame.size.width/2)-10, height: 160)
        }
    }
    
    
    // Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    // Horizontal spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 40
//    }
}






// MARK: Stack Content ScrollView
extension FirstViewController {
    private func setStackContentSV() {
        
        // MARK: Content Stack
        let contentStack = UIStackView(arrangedSubviews: [cardCollectionView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 40

        contentScrollView.addSubview(contentStack)
        
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: scrollViewMargin.topAnchor, constant: 176),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: scrollViewMargin.bottomAnchor, constant: -24),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            // Example
//            contentStack.heightAnchor.constraint(equalToConstant: 2000),
        ])
    }
}




// MARK: Constraints
extension FirstViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
}
