//
//  SecondViewController.swift
//  Numerology
//
//  Created by Serj on 03.08.2023.
//

import UIKit

class SecondViewController: UIViewController {

    // models instance
    var boardOfDayModel: BoardOfDayModel?
    var personalDayModel: PersonalDayModel?
    var personalMonthModel: PersonalMonthModel?
    var personalYearModel: PersonalYearModel?
    var lifeStagesModel: LifeStagesModel?
    
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    let cardCollectionView = ContentCollectionView()
    
    
    
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
    
    // MARK: View Did Appear
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
    
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
    
}


// MARK: UICollectionView Delegate
extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 👎
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell().cardCollectionID, for: indexPath as IndexPath) as! CardCollectionViewCell
        
        let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: BigCardCVCell().bigCardCVCID, for: indexPath as IndexPath) as! BigCardCVCell
        
        if indexPath.row == 0 {
            // MARK: TIP // 0
            // Get from UserDefaults
            
            if let data = UserDefaults.standard.object(forKey: "BoardOfDayModelKey") as? Data,
               let model = try? JSONDecoder().decode(BoardOfDayModel.self, from: data) {
                self.boardOfDayModel = model
                bigCell.configure(
                    title: "Your tip of the day!",
                    subtitle: model.dayTip
                )
            }
            
          return bigCell
        } else if indexPath.row == 1 {
            // MARK: Pers. Day // 2.1
            FirebaseManager.shared.getPersonalDay(number: 1) { model in
                self.personalDayModel = model
                cell.configure(
                    title: "Personal day",
                    subtitle: model.aboutPersDay,
                    bgImage: nil
                )
            }
            return cell
        } else if indexPath.row == 2 {
            // MARK: Pers. Month // 2.2
            FirebaseManager.shared.getPersonalMonth(number: 1) { model in
                self.personalMonthModel = model
                cell.configure(
                    title: "Pers. month",
                    subtitle: model.aboutPersMonth,
                    bgImage: nil
                )
            }
            return cell
        } else if indexPath.row == 3 {
            // MARK: Pers. Year // 2.3
            FirebaseManager.shared.getPersonalYear(number: 1) { model in
                self.personalYearModel = model
                cell.configure(
                    title: "Pers. year",
                    subtitle: model.aboutPersYear,
                    bgImage: nil
                )
            }
            return cell
        } else if indexPath.row == 4 {
            // MARK: Life Stages // 2.4
            FirebaseManager.shared.getLifeStages(number: 1) { model in
                self.lifeStagesModel = model
                cell.configure(
                    title: "Life Stages",
                    subtitle: model.aboutStages,
                    bgImage: nil
                )
            }
            return cell
        } else {
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
                info: boardOfDayModel?.dayTip,
                about: nil
            )
            if boardOfDayModel != nil {
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
            }
        }
        
        // MARK: pers. Day // 2.1
        if indexPath.row == 1 {
            
            // MARK: Check
            guard self.checkAccessContent() == true else { return }
            
            let vc = PersonalDayVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
        
        // MARK: pers. month // 2.2
        if indexPath.row == 2 {
            
            // MARK: Check
            guard self.checkAccessContent() == true else { return }
            
            let vc = PersonalMonthVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
        
        // MARK: pers. year // 2.3
        if indexPath.row == 3 {
            
            // MARK: Check
            guard self.checkAccessContent() == true else { return }
            
            let vc = PersonalYearVC()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
        
        // MARK: life stages // 2.4
        if indexPath.row == 4 {
            
            // MARK: Check
            guard self.checkAccessContent() == true else { return }
            
            let vc = LifeStagesViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)

        }
       }
}

// MARK: Collection View Delegate FlowLayout
extension SecondViewController: UICollectionViewDelegateFlowLayout {
 
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
extension SecondViewController {
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
extension SecondViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
}
