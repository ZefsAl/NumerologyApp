//
//  EnterUserDataVC.swift
//  Numerology
//
//  Created by Serj on 25.10.2023.
//

import UIKit

//  onboarding v2
class EnterUserDataVC: UIViewController {
    
    // MARK: - largeTitle
    private let largeTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.font = UIFont(name: "Cinzel-Regular", size: 46)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Just two steps!", attributes: [NSAttributedString.Key.kern: -1.92, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        l.textAlignment = .center
        return l
    }()
    
    // MARK: Next Button
    private let nextButton: RegularBigButton = {
        let b = RegularBigButton(frame: .zero, lable: "Continue")
        b.addTarget(Any?.self, action: #selector(nextBtnAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: Next Btn Action
    @objc private func nextBtnAction() {
        print("doneBtnAction")
        
        guard
            let nameVal = userNameField.text,
            let surnameVal = userSurnameField.text,
            let valDateOfBirth = userDateOfBirthField.text
        else { return }
        
        if nameVal != "" || surnameVal != "" {
            // Save data to UserDefaults
            DispatchQueue.main.async {
                UserDefaults.standard.setUserData(name: nameVal, surname: surnameVal)
                UserDefaults.standard.synchronize()
            }
            guard (nameVal != "" && surnameVal != "" && valDateOfBirth != "") else { return }
            self.navigationController?.pushViewController(QuizVC(), animated: true)
        }
    }
    
    
    // MARK: Name Field
    private let userNameField = CustomTF(frame: .null, setPlaceholder: "Enter your name")
    
    
    // MARK: Surname Field
    private let userSurnameField = CustomTF(frame: .null, setPlaceholder: "Enter your surname")


    // MARK: Text Field + Date Picker
    private let userDateOfBirthField: CustomTF = {
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

        self.setBackground(named: "DarkBG.png")
        AnimatableBG().setBackground(vc: self)
        
        setupStack()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -130
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // titles Stack
        let titlesStack = UIStackView(arrangedSubviews: [largeTitle])
        titlesStack.axis = .vertical
        titlesStack.alignment = .fill
        titlesStack.spacing = 16
        
        // Field Stack
        let nameFieldStack = UIStackView(arrangedSubviews: [userNameField,userSurnameField,userDateOfBirthField])
        nameFieldStack.axis = .vertical
        nameFieldStack.alignment = .fill
        nameFieldStack.spacing = 32
        
        // Fields Stack
        let fieldsStack = UIStackView(arrangedSubviews: [titlesStack,nameFieldStack])
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 32
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [fieldsStack,UIView(),nextButton])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 0

        self.view.addSubview(contentStack)
        
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: margin.topAnchor, constant: 44),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            contentStack.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -52)
        ])
    }
    
}
