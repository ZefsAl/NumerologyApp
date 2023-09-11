//
//  PersonalYearVC.swift
//  Numerology
//
//  Created by Serj on 11.08.2023.
//

import UIKit

class PersonalYearVC: UIViewController {
    
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
            let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date,
            let receivedDate = self.customDateTextfield.receivedDate
        else { return }
        print(receivedDate)
        
        // Calculated Year
        let personalYearVal = CalculateNumbers().personalYear(userDate: dateOfBirth, enteredDate: receivedDate)
        
        // Present VC
        DispatchQueue.main.async {
            FirebaseManager().getPersonalYear(number: personalYearVal) { model in
                let vc = DescriptionVC()
                vc.configure(
                    title: "Your personal year",
                    info: model.infoPersYear,
                    about: model.aboutPersYear
                )
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        

    }
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(named: "SecondaryBG.png")
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        
        configureNavView()
        setUpStack()
    }
    
    

    
    
    // MARK: Configure Nav View
    private func configureNavView() {
    }
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // Date Of Birth Stack
        let dateOfBirthStack = UIStackView(arrangedSubviews: [dateOfBirthTitle,customDateTextfield])
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


