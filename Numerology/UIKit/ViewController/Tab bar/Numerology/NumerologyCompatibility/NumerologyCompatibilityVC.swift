//
//  UniversalCheckDateVC.swift
//  Numerology
//
//  Created by Serj on 03.08.2023.
//

import UIKit

final class NumerologyCompatibilityVC: UIViewController {
    
    var partnerDate: Date?
    
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
        l.font = UIFont(name: "Cinzel-Regular", size: 45)
        l.text = "Compatibility"
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
        l.text = "Enter your partner's date"
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: Text Field + Date Picker
    let userEnterDateTF: CustomTF = {
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
    @objc func datePickerAction(_ sender: UIDatePicker) {
        
        userEnterDateTF.text = setDateFormat(date: sender.date)
        self.partnerDate = sender.date
    }
    
    
    
    // MARK: button Action
    @objc func buttonAction() {
        print("BtnAction")
        
        // MARK: Check
        guard self.checkAndShowPaywall() == true else { return }
        
//        guard self.remoteOpenDelegate?.openFrom?.checkAccessContent() == true else { return }
        
        guard
            let partnerDate = self.partnerDate,
            let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date,
            let userName = UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as? String
        else { return }
        
        let userNum = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
        let partnerNum = CalculateNumbers().calculateNumberOfDestiny(date: partnerDate)
        
        let strNumber = String(userNum) + String(partnerNum)
        
        guard let compatibility = Int(strNumber) else { return }
    
        DispatchQueue.main.async {
            NumerologyManager().getCompatibility(number: compatibility) { model in
                
                print(model.aboutThisNumbers)
                
                let vc = CompatibilityViewController()
                vc.configure(
                    userNumber: String(userNum),
                    userLable: userName,
                    partnerNumber: String(partnerNum),
                    lableDescription: model.aboutThisNumbers
                )
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        print("compatibility: \(compatibility)")
    }
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nav
        self.setDetaiVcNavItems(shareTint: DS.Numerology.primaryColor)
        //
        self.setBackground(named: "MainBG2")
        setupStack()
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


