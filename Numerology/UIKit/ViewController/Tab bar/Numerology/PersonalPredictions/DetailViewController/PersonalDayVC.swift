//
//  PersonalDayVC.swift
//  Numerology
//
//  Created by Serj on 11.08.2023.
//

import UIKit

final class PersonalDayVC: UIViewController {
    
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
        l.font = DS.CinzelFont.title_Extra
        l.text = "Personal Day"
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Date Title
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.setSourceSerifPro(weight: .light, size: 26)
        l.text = "Choose a date to find out the forecast for it"
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Text Field + Date Picker
    private let userEnterDateTF: CustomTF = {
        let tf = CustomTF(setPlaceholder: "\(setDateFormat(date: Date()))")
        tf.textAlignment = .center
        tf.rightViewMode = .never
        tf.leftViewMode = .never
        
        // MARK: Date Picker
        let datePicker: UIDatePicker = {
            let dp = UIDatePicker()
            dp.datePickerMode = .date
            dp.preferredDatePickerStyle = .wheels
            dp.addTarget(Any?.self, action: #selector(datePickerAction), for: .valueChanged)

            var minDateComponents = DateComponents()
            minDateComponents.year = 1950
            var maxDateComponents = DateComponents()
            maxDateComponents.year = 2100
            let userCalendar = Calendar(identifier: .gregorian)
            
            if let start = userCalendar.date(from: minDateComponents),
               let end = userCalendar.date(from: maxDateComponents) {
                dp.minimumDate = Date(timeInterval: 0, since: start)
                dp.maximumDate = Date(timeInterval: 0, since: end)
            }
            
            return dp
        }()
        tf.inputView = datePicker
        
        return tf
    }()
    // MARK: Date Picker Action
    @objc private func datePickerAction(_ sender: UIDatePicker) {
        
        userEnterDateTF.text = setDateFormat(date: sender.date)
        self.enteredDate = sender.date
    }
    
    // MARK: button Action
    @objc private func buttonAction() {
        print("button Action")

        // Get data
        guard
            let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date,
            let enteredDate = self.enteredDate
        else { return }

        // Calculate Day
        let personalDay = CalculateNumbers().personalDay(userDate: dateOfBirth, enteredDate: enteredDate)
                
        // Present VC
        DispatchQueue.main.async {
            NumerologyManager().getPersonalDay(number: personalDay) { model in
                let vc = NumerologyPremiumDescriptionVC(
                    title: "Your personal day",
                    info: model.infoPersDay + model.aboutPersDay,
                    topImageKey: .day
                )
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DS.Numerology.primaryColor)
        //
        self.setBackground(named: "MainBG2")
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
        let contentStack = UIStackView(arrangedSubviews: [titleStack,userEnterDateTF])
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

