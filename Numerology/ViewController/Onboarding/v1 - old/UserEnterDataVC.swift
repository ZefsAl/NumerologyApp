////
////  UserEnterDataVC.swift
////  Numerology
////
////  Created by Serj on 20.07.2023.
////
//
//import UIKit
//
//class UserEnterDataVC: UIViewController {
//    
//    let largeTitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        
//        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
//        l.numberOfLines = 0
//        l.font = UIFont(name: "Cinzel-Regular", size: 46)
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.04
//        l.attributedText = NSMutableAttributedString(string: "Just two steps!", attributes: [NSAttributedString.Key.kern: -1.92, NSAttributedString.Key.paragraphStyle: paragraphStyle])
//        l.textAlignment = .center
//        
//        return l
//    }()
//    
//    let subtitle: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "And your personal numerological portrait is ready"
//
//        // Style
//        l.font = UIFont(name: "SourceSerifPro-Light", size: 24)
//        l.lineBreakMode = .byWordWrapping
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.2
//        l.numberOfLines = 0
//        l.textAlignment = .center
//        
//        return l
//    }()
//    
//    
//    // MARK: Next Button
//    let nextButton: RegularBigButton = {
//        let b = RegularBigButton(frame: .zero, lable: "Continue")
//        b.addTarget(Any?.self, action: #selector(nextBtnAction), for: .touchUpInside)
//        return b
//    }()
//    // MARK: Next Btn Action
//    @objc private func nextBtnAction() {
//        print("doneBtnAction")
//        
//        guard
//            let nameVal = userNameField.text,
//            let surnameVal = userSurnameField.text
//        else { return }
//        
//        if nameVal != "" || surnameVal != "" {
//            // Save data to UserDefaults
//            DispatchQueue.main.async {
//                UserDefaults.standard.setUserData(name: nameVal, surname: surnameVal)
//                UserDefaults.standard.synchronize()
//            }
//            // TEST
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                print(UserDefaults.standard.object(forKey: UserDefaultsKeys.name) as Any)
//                print(UserDefaults.standard.object(forKey: UserDefaultsKeys.surname) as Any)
//            }
//            
//            self.navigationController?.pushViewController(UserEnterDateOfBirthVC(), animated: true)
//        }
//
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.2,
//                           animations: {
//                self.nextButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//            },
//                           completion: { _ in
//                UIView.animate(withDuration: 0.2) {
//                    self.nextButton.transform = CGAffineTransform.identity
//                }
//            })
//        }
//    }
//    
//    
//    // MARK: Name Field
//    let userNameField = CustomTF(frame: .null, setPlaceholder: "Enter your name")
//    
//    // MARK: Surname Field
//    let userSurnameField = CustomTF(frame: .null, setPlaceholder: "Enter your surname")
//
//
//    
//    
//    // MARK: View Did load
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setBackground(named: "EnterDataBG.png")
//        
//        setupStack()
//    }
//    
//    // MARK: viewWillAppear
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self);
//    }
//    
//    @objc func keyboardWillShow(sender: NSNotification) {
////        let userInfo = sender.userInfo!
////        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
//
////        self.view.frame.origin.y = self.view.frame.origin.y + keyboardHeight
//         self.view.frame.origin.y = -155
//    }
//
//    @objc func keyboardWillHide(sender: NSNotification) {
//         self.view.frame.origin.y = 0
//    }
//    
//    
//    
//    
//    // MARK: Set up Stack
//    private func setupStack() {
//        
//        // titles Stack
//        let titlesStack = UIStackView(arrangedSubviews: [largeTitle,subtitle])
//        titlesStack.axis = .vertical
//        titlesStack.alignment = .fill
//        titlesStack.spacing = 16
//        
//        // Name Field Stack
//        let nameFieldStack = UIStackView(arrangedSubviews: [userNameField])
//        nameFieldStack.axis = .vertical
//        nameFieldStack.alignment = .fill
//        nameFieldStack.spacing = 0
//        
//        // Surname Field Stack
//        let surnameFieldStack = UIStackView(arrangedSubviews: [userSurnameField])
//        surnameFieldStack.axis = .vertical
//        surnameFieldStack.alignment = .fill
//        surnameFieldStack.spacing = 0
//        
//        // Fields Stack
//        let fieldsStack = UIStackView(arrangedSubviews: [titlesStack,nameFieldStack,surnameFieldStack])
//        fieldsStack.axis = .vertical
//        fieldsStack.alignment = .fill
//        fieldsStack.spacing = 40
//        
//        // Content Stack
//        let contentStack = UIStackView(arrangedSubviews: [fieldsStack,UIView(),nextButton])
//        contentStack.translatesAutoresizingMaskIntoConstraints = false
//        contentStack.axis = .vertical
//        contentStack.alignment = .fill
//        contentStack.spacing = 0
//
//        
//        self.view.addSubview(contentStack)
//        
//        let margin = self.view.layoutMarginsGuide
//        NSLayoutConstraint.activate([
//            
//            contentStack.topAnchor.constraint(equalTo: margin.topAnchor, constant: 16),
//            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36),
//            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36),
//            contentStack.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -16)
//        ])
//    }
//    
//    
//}
