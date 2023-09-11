//
//  UserEnterDateOfBirthVC.swift
//  Numerology
//
//  Created by Serj on 21.07.2023.
//

import UIKit

class UserEnterDateOfBirthVC: UIViewController {
    
    // MARK: largeTitle
    let largeTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.font = UIFont(name: "Cinzel-Regular", size: 46)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "You're almost there!", attributes: [NSAttributedString.Key.kern: -1.92, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        l.textAlignment = .center
        
        return l
    }()
    
    // MARK: Date Of Birth Title
    let dateOfBirthTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Enter your date of birth"

        // Style
        l.font = UIFont(name: "SourceSerifPro-Light", size: 24)
        l.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        l.numberOfLines = 0
        l.textAlignment = .center
        
        return l
    }()
    
    
    
    // MARK: Next Button
    private let nextButton: RegularBigButton = {
        let b = RegularBigButton(frame: .zero, lable: "Continue")
        b.addTarget(Any?.self, action: #selector(nextBtnAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: next Btn Action
    @objc private func nextBtnAction() {
        print("doneBtnAction")
        
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey")
        print(dateOfBirth as Any)
        guard
            let valDateOfBirth = userDateOfBirthField.text
        else { return }
        
        // MARK: Validation
        if valDateOfBirth != "" || dateOfBirth != nil {
            // Next VC
            self.navigationController?.pushViewController(MainTabBarController(), animated: true)
        }
        
        // Button Animation
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.nextButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.nextButton.transform = CGAffineTransform.identity
                }
            })
        }
    }
    
    
    
    // MARK: Text Field + Date Picker
    let userDateOfBirthField: CustomTF = {
        let tf = CustomTF(frame: .null, setPlaceholder: "\(setDateFormat(date: Date()))")
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
        userDateOfBirthField.text = setDateFormat(date: sender.date)
        
        // Save data to UserDefaults
        DispatchQueue.main.async {
            UserDefaults.standard.setDateOfBirth(dateOfBirth: sender.date)
            UserDefaults.standard.synchronize()
            // test
            print(UserDefaults.standard.object(forKey: "dateOfBirthKey") as Any)
        }
    }
    
    
    
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "EnterDataBG2.png")
        setUpStack()
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        
        // titles Stack
        let titlesStack = UIStackView(arrangedSubviews: [largeTitle,dateOfBirthTitle])
        titlesStack.axis = .vertical
        titlesStack.alignment = .fill
        titlesStack.spacing = 16
        
        // Date Of Birth Stack
        let dateOfBirthStack = UIStackView(arrangedSubviews: [userDateOfBirthField])
        dateOfBirthStack.axis = .vertical
        dateOfBirthStack.alignment = .fill
        dateOfBirthStack.spacing = 10
        
        
        // Fields Stack
        let fieldsStack = UIStackView(arrangedSubviews: [titlesStack,dateOfBirthStack])
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 40
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [fieldsStack,UIView(),nextButton])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        
        contentStack.spacing = 40
        
        self.view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36),
            contentStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44)
        ])
    }
    
    
}

