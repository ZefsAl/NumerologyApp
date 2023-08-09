//
//  RegularTextField.swift
//  Numerology
//
//  Created by Serj on 20.07.2023.
//


import UIKit

class RegularTextField: UITextField, UITextFieldDelegate {

    var setPlaceholder: String?
    
    let rightCancelButton: UIButton = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "xmark.circle.fill")
        iv.tintColor = .systemGray
        iv.contentMode = .left

        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.addSubview(iv)
        
        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        iv.leadingAnchor.constraint(equalTo: b.leadingAnchor).isActive = true
        
        b.addTarget(Any?.self, action: #selector(clearAction), for: .touchUpInside)
        
        b.isHidden = true
        b.alpha = 0
        
        return b
    }()
    @objc func clearAction() {
//        print("Clear")
        self.text = ""
    }
    
    
    // MARK: Animate, Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.rightCancelButton.isHidden = false
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.rightCancelButton.alpha = 1
        }, completion: nil)

    }
    
    // MARK: Animate, Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {

        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            self.rightCancelButton.alpha = 0
        } completion: { _ in
            self.rightCancelButton.isHidden = true
        }

    }
    
    
    // MARK: init
    init(frame: CGRect, setPlaceholder: String) {
        self.setPlaceholder = setPlaceholder
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        // Delegate
        delegate = self
        
        // Style
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
//        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: setPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tintColor = .white
        
        
        // Margins inside
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        leftViewMode = .always
        rightView = rightCancelButton
        rightViewMode = .always
        
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

        self.regularAccessoryViewOnKeyboard()
        
    }
    
    
    // MARK: Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let newTextField = textField.text else { return false }
        let text = newTextField + string

        
        // Replacing space + restrict
        if text.contains(" ")  {
            textField.text = text.replacingOccurrences(of: " ", with: "")

            if text.contains(" ") {
                return false
            }
        }

        return true
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Extension Accessory View
extension RegularTextField {
    
    func regularAccessoryViewOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .systemGray5
        
        
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = .white
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.endEditing(true)
    }
}


