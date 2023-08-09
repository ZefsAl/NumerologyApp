//
//  UserEnterDateOfBirthVC.swift
//  Numerology
//
//  Created by Serj on 21.07.2023.
//

import UIKit

class UserEnterDateOfBirthVC: UIViewController {
    
    let largeTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        l.text = String("You're almost there!")
        l.numberOfLines = 2
        
        return l
    }()
    
    
    // MARK: Next Button
    let nextButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 8
        b.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.3568627451, blue: 0.6431372549, alpha: 1)
        
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .white
        l.text = "DONE"
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        b.addSubview(l)
        l.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        
        b.addTarget(Any?.self, action: #selector(doneBtnAction), for: .touchUpInside)
        
        return b
    }()
    
    // MARK: Date Title
    let dateOfBirthTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.text = "Enter your date of birth"
        return l
    }()
    
    // MARK: Text Field + Date Picker
    let userDateOfBirthField: RegularTextField = {
        let tf = RegularTextField(frame: .null, setPlaceholder: "\(setDateFormat(date: Date()))")
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
    
    // MARK: done Btn Action
    @objc func doneBtnAction() {
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
        
        
        // Replace RootViewController
        //            NotificationCenter.default.post(name: UserEnterDataVC.notificationDone, object: nil)
        
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
    
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "SecondaryBG.png")
        
//        configureNavView()
        setUpStack()
    }
    
    // MARK: Configure
    func configure(title: String, subtitle: String?, bgImage: UIImage?) {
        self.dateOfBirthTitle
    }

    
    
    // MARK: Configure Nav View
    private func configureNavView() {
    }
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        
        // titles Stack
        let titlesStack = UIStackView(arrangedSubviews: [largeTitle])
        titlesStack.axis = .vertical
        titlesStack.alignment = .fill
        titlesStack.spacing = 32
        
        // Date Of Birth Stack
        let dateOfBirthStack = UIStackView(arrangedSubviews: [dateOfBirthTitle,userDateOfBirthField])
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
            
            //            nextButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            //            nextButton.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: 0),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            contentStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44)
        ])
    }
    
    
}

