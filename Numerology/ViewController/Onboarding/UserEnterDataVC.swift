//
//  UserEnterDataVC.swift
//  Numerology
//
//  Created by Serj on 20.07.2023.
//

import UIKit

class UserEnterDataVC: UIViewController {
    
    let largeTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        l.text = "Just two steps!"
        l.numberOfLines = 2
        
        return l
    }()
    
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "And your personal numerological portrait is ready"
        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
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
        l.text = "NEXT"
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        b.addSubview(l)
        l.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        
        b.addTarget(Any?.self, action: #selector(doneBtnAction), for: .touchUpInside)
        
        return b
    }()
    
    // MARK: Name
    let nameFieldTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.text = "Your name"
        return l
    }()
    let userNameField = RegularTextField(frame: .null, setPlaceholder: "Enter your name")
    
    // MARK: Surname
    let surnameFieldTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        l.text = "Your Surname"
        
        return l
    }()
    let userSurnameField = RegularTextField(frame: .null, setPlaceholder: "Enter your surname")
    
    // MARK: done Btn Action
    @objc func doneBtnAction() {
        print("doneBtnAction")
        
        guard
            let nameVal = userNameField.text,
            let surnameVal = userSurnameField.text
        else { return }
        
        if nameVal != "" || surnameVal != "" {
            
            
            
            // Save data to UserDefaults
            DispatchQueue.main.async {
                UserDefaults.standard.setUserData(name: nameVal, surname: surnameVal)
                UserDefaults.standard.synchronize()
            }
            // TEST
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(UserDefaults.standard.object(forKey: "nameKey") as Any)
                print(UserDefaults.standard.object(forKey: "surnameKey") as Any)
            }
            
            
            self.navigationController?.pushViewController(UserEnterDateOfBirthVC(), animated: true)
            

            
            // Replace RootViewController
//            NotificationCenter.default.post(name: UserEnterDataVC.notificationDone, object: nil)
            
        }

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2,
                           animations: {
                self.nextButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                           completion: { _ in
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
        
        configureNavView()
        setUpStack()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        let userInfo = sender.userInfo!
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height

//        self.view.frame.origin.y = self.view.frame.origin.y + keyboardHeight
         self.view.frame.origin.y = -100 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    // MARK: Configure Nav View
    private func configureNavView() {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
    }
    
    
    
    // MARK: Set up Stack
    private func setUpStack() {

        
        // titles Stack
        let titlesStack = UIStackView(arrangedSubviews: [largeTitle,subtitle])
        titlesStack.axis = .vertical
        titlesStack.alignment = .fill
        titlesStack.spacing = 24
        
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
        
        
        // Fields Stack
        let fieldsStack = UIStackView(arrangedSubviews: [titlesStack,nameFieldStack,surnameFieldStack])
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
