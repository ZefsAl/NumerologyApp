//
//  UniversalCheckDateVC.swift
//  Numerology
//
//  Created by Serj on 03.08.2023.
//

import UIKit

class ThirdViewController: UIViewController {
    

    var partnerDate: Date?
    
    
    // MARK: Next Button
    let nextButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 8
        b.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.09019607843, blue: 0.1725490196, alpha: 1)
        
        // MARK: Icon
            let iv = UIImageView()

            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.image = UIImage(systemName: "chevron.right")
        iv.contentMode = UIView.ContentMode.scaleAspectFit
            iv.tintColor = .white
            
            iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
            iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        b.addSubview(iv)
        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        
        iv.leadingAnchor.constraint(equalTo: b.leadingAnchor, constant: 16).isActive = true
        iv.trailingAnchor.constraint(equalTo: b.trailingAnchor, constant: -16).isActive = true
        
        b.heightAnchor.constraint(equalToConstant: 50).isActive = true
        b.addTarget(Any?.self, action: #selector(buttonAction), for: .touchUpInside)
        
        return b
    }()
    
    // MARK: Date Title
    let dateOfBirthTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.text = "Enter your partner's date"
        l.textAlignment = .center
        return l
    }()
    
    // MARK: Text Field + Date Picker
    let userEnterDateTF: RegularTextField = {
        let tf = RegularTextField(frame: .null, setPlaceholder: "\(setDateFormat(date: Date()))")
        tf.textAlignment = .center
        tf.rightViewMode = .never
        tf.leftViewMode = .never
        tf.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.09019607843, blue: 0.1725490196, alpha: 1)
        tf.layer.borderColor = UIColor.clear.cgColor
        
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
        guard self.checkAccessContent() == true else { return }
        
        guard
            let partnerDate = self.partnerDate,
            let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date,
            let userName = UserDefaults.standard.object(forKey: "nameKey") as? String
        else { return }
        
        let userNum = CalculateNumbers().calculateNumberOfDestiny(date: dateOfBirth)
        let partnerNum = CalculateNumbers().calculateNumberOfDestiny(date: partnerDate)
        
        let strNumber = String(userNum) + String(partnerNum)
        
        guard let compatibility = Int(strNumber) else { return }
    
        DispatchQueue.main.async {
            FirebaseManager().getCompatibility(number: compatibility) { model in
                
                print(model.aboutThisNumbers)
                
                let vc = CompatibilityViewController()
                vc.configure(
                    userNumber: String(userNum),
                    userLable: userName,
                    partnerNumber: String(partnerNum),
                    lableDescription: model.aboutThisNumbers
                )
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .overFullScreen
                self.present(navVC, animated: true)
                
            }
        }
        print("compatibility: \(compatibility)")
        
    }
    
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "MainBG.png")
        setUpStack()
    }
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        
        // Date Of Birth Stack
        let dateOfBirthStack = UIStackView(arrangedSubviews: [dateOfBirthTitle,userEnterDateTF])
        dateOfBirthStack.axis = .vertical
        dateOfBirthStack.alignment = .fill
        dateOfBirthStack.spacing = 10
        
        // Fields Stack
        let fieldsStack = UIStackView(arrangedSubviews: [dateOfBirthStack,nextButton])
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false 
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .center
        fieldsStack.spacing = 16
        
        // Card
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.07058823529, blue: 0.1490196078, alpha: 1)
            v.layer.cornerRadius = 15
            return v
        }()
        cardView.addSubview(fieldsStack)
        
        self.view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            
            dateOfBirthStack.leadingAnchor.constraint(equalTo: fieldsStack.leadingAnchor, constant: 0),
            dateOfBirthStack.trailingAnchor.constraint(equalTo: fieldsStack.trailingAnchor, constant: 0),
            
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            
            fieldsStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32),
            fieldsStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            fieldsStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32),
            fieldsStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -32),
            
        ])
    }
    
    
}


