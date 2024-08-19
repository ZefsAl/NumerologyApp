//
//  PersonalYearVC.swift
//  Numerology
//
//  Created by Serj on 11.08.2023.
//

import UIKit

final class PersonalYearVC: UIViewController {
    
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
        l.text = "Personal Year"
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Date Title
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .light, size: 26)
        l.text = "Select the year to find out the forecast for it"
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Custom Date Textfield
    let customDateTextfield: PersonalYearTF = {
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        let todayPlaceholder = df.string(from: Date())
        let p = PersonalYearTF(frame: .zero, setPlaceholder: todayPlaceholder)
        return p
    }()
    
    
    // MARK: button Action
    @objc func buttonAction() {
        print("button Action")
        
        // Get data
        guard
            let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date,
            let receivedDate = self.customDateTextfield.receivedDate
        else { return }
        print(receivedDate)
        
        // Calculated Year
        let personalYearVal = CalculateNumbers().personalYear(userDate: dateOfBirth, enteredDate: receivedDate)
        
        // Present VC
        DispatchQueue.main.async {
            NumerologyManager().getPersonalYear(number: personalYearVal) { model in
                let vc = PremiumDescriptionVC(
                    title: "Your personal year",
                    info: model.infoPersYear + model.aboutPersYear
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

