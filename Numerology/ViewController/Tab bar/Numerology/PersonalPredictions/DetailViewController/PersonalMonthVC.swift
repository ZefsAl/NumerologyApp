//
//  UniversalCheckDateVC.swift
//  Numerology
//
//  Created by Serj on 09.08.2023.
//

import UIKit

final class PersonalMonthVC: UIViewController {
    
    private var enteredDate: Date?
    
    // MARK: Next Button
    private let nextButton: RegularBigButton = {
        let b = RegularBigButton(frame: .zero, lable: "Continue")
        b.addTarget(Any?.self, action: #selector(buttonAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: Date Title
    private let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 48)
        l.text = "Personal Month"
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Subtitle
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .light, size: 26)
        l.text = "Select the month and year to find out the forecast for it"
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Custom Date Textfield
    let customDateTextfield: PersonalMonthTF = {
        let df = DateFormatter()
        let langStr = Locale.current.languageCode
        if langStr == "ru" {
            df.dateFormat = "LLLL / yyyy"
        } else {
            df.dateFormat = "MMMM / yyyy"
        }
        let todayPlaceholder = df.string(from: Date())
        let p = PersonalMonthTF(frame: .zero, setPlaceholder: todayPlaceholder)
        return p
    }()
    
    
    // MARK: button Action
    @objc private func buttonAction() {
        print("button Action")
        
        // Get data
        guard
            let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date,
            let receivedDate = self.customDateTextfield.receivedDate
        else { return }
        print(receivedDate)
        
        // Calculated month
        let personalYearVal = CalculateNumbers().personalYear(userDate: dateOfBirth, enteredDate: receivedDate)
        let personalMonth = CalculateNumbers().personalMonth(personalYear: personalYearVal, enteredDate: receivedDate)
        
        // Present VC
        DispatchQueue.main.async {
            NumerologyManager().getPersonalMonth(number: personalMonth) { model in
                let vc = PremiumDescriptionVC(
                    title: "Your personal month",
                    info: model.infoPersMonth + model.aboutPersMonth
                )
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackground(named: "MainBG2.png")
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        configureNavView()
        setupStack()
    }
    
    // MARK: Configure Nav View
    private func configureNavView() {
    }
    
    // MARK: Set up Stack
    private func setupStack() {
                
        // MARK: Content Stack
        let titleStack = UIStackView(arrangedSubviews: [mainTitle,subtitle])
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .vertical
        titleStack.alignment = .fill
        titleStack.spacing = 16
        
        // MARK: Content Stack
        let contentStack = UIStackView(arrangedSubviews: [titleStack,customDateTextfield])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 32
        
        self.view.addSubview(contentStack)
        self.view.addSubview(nextButton)
        
        let viewMargin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
                        
            nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            nextButton.bottomAnchor.constraint(equalTo: viewMargin.bottomAnchor, constant: -24)
        ])
    }   
}
