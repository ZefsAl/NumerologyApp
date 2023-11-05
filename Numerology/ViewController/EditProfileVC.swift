//
//  EditProfileVC.swift
//  Numerology
//
//  Created by Serj on 23.07.2023.
//

import UIKit


class EditProfileVC: UIViewController {
    
    
    var newDateOfBirth: Date?
    
    // MARK: Name
    let nameFieldTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.text = "Change name"
        
        return l
    }()
    let userNameField = RegularTextField(frame: .null, setPlaceholder: "Enter your name")
    
    // MARK: Surname
    let surnameFieldTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.text = "Change Surname"
        
        return l
    }()
    let userSurnameField = RegularTextField(frame: .null, setPlaceholder: "Enter your surname")
    
    // MARK: Date Title
    let dateOfBirthTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.text = "Select Date of Birth"
        return l
    }()
    
    // MARK: Text Field + Date Picker
    let userDateOfBirthField: RegularTextField = {
        let tf = RegularTextField(frame: .null, setPlaceholder: "\(setDateFormat(date: Date()))")
        tf.textAlignment = .left
        tf.rightViewMode = .never
        
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
            self.newDateOfBirth = sender.date
            print("new Date is \(self.newDateOfBirth as Any)")
        }
    }
    
    let deleteDataButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("Delete Account Data", for: .normal)
        b.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        b.tintColor = .white
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 16
        
        b.addTarget(Any?.self, action: #selector(deleteAct), for: .touchUpInside)
        return b
    }()
    
    @objc private func deleteAct() {
        
        let alert = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { act in
            UserDefaults.standard.setUserData(name: "", surname: "")
            UserDefaults.standard.setDateOfBirth(dateOfBirth: Date())
            UserDefaults.standard.synchronize()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { act in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
        
    }
    

    
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBackground(named: "ProfileBG.png")
        
        configureNavView()
        setUpStack()
        configureEditData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Configure Nav View
    private func configureNavView() {
        self.title = "Profile"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction(_:)))
        barButtonItem.tintColor = .white
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: saveAction + Validation
    @objc func saveAction(_ sender: UIBarButtonItem) {
        
        guard
            let nameVal = userNameField.text,
            let surnameVal = userSurnameField.text,
            let dateOfBirthVal = userDateOfBirthField.text,
            let newDateOfBirth = self.newDateOfBirth ?? UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        else {
            print("Error getting data for save")
            return
        }
        
//        print(userNameField.text)
//        print(userSurnameField.text)
//        print(newDateOfBirth)
//        print(userDateOfBirthField.text)
        
        if nameVal != "" && surnameVal != "" && dateOfBirthVal != "" {
            UserDefaults.standard.setUserData(name: nameVal, surname: surnameVal)
            UserDefaults.standard.setDateOfBirth(dateOfBirth: newDateOfBirth)
            UserDefaults.standard.synchronize()
            print("saved")
        } else {
            print("NOT saved")
        }
        
    }
    
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // Name Field Stack
        let nameFieldStack = UIStackView(arrangedSubviews: [nameFieldTitle,userNameField])
        nameFieldStack.axis = .vertical
        nameFieldStack.alignment = .fill
        nameFieldStack.spacing = 10
        
        // Surname Field Stack
        let surnameFieldStack = UIStackView(arrangedSubviews: [surnameFieldTitle,userSurnameField])
        surnameFieldStack.axis = .vertical
        surnameFieldStack.alignment = .fill
        surnameFieldStack.spacing = 10
        
        // Date Of Birth Stack
        let dateOfBirthStack = UIStackView(arrangedSubviews: [dateOfBirthTitle,userDateOfBirthField])
        dateOfBirthStack.axis = .vertical
        dateOfBirthStack.alignment = .fill
        dateOfBirthStack.spacing = 10
        
        // Fields Stack
        let fieldsStack = UIStackView(arrangedSubviews: [nameFieldStack,surnameFieldStack,dateOfBirthStack])
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 40
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [fieldsStack,UIView(),deleteDataButton])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 40

        
        self.view.addSubview(contentStack)
//        self.view.addSubview(deleteDataButton)
        
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: margin.topAnchor, constant: 40),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44),
            
//            deleteDataButton.topAnchor.constraint(equalTo: contentStack.bottomAnchor),
            deleteDataButton.heightAnchor.constraint(equalToConstant: 40),
//            deleteDataButton.widthAnchor.constraint(equalToConstant: 120),
//            deleteDataButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    
}


extension EditProfileVC {
    private func configureEditData() {
        
        guard
            let name = UserDefaults.standard.object(forKey: "nameKey") as? String,
            let surname = UserDefaults.standard.object(forKey: "surnameKey") as? String,
            let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date
        else {
            return
        }

        self.userNameField.text = name
        self.userSurnameField.text = surname
        self.userDateOfBirthField.text = setDateFormat(date: dateOfBirth)
    }
}
