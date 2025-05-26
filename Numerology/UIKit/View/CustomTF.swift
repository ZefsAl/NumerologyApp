//
//  CustomTF.swift
//  Numerology
//
//  Created by Serj on 04.09.2023.
//

import UIKit

protocol CustomTFActionDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidChangeSelection(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
}

class CustomTF: UITextField {
    
    lazy var customTFActionDelegate: CustomTFActionDelegate? = nil

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
        self.text = ""
    }

    
    // MARK: init
    init(setPlaceholder: String) {
        self.setPlaceholder = setPlaceholder
        super.init(frame: .null)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        // Delegate
        delegate = self
        
        // Style
        layer.cornerRadius = DS.maxCornerRadius
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
        textColor = .white
        backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 0.7)
        
        attributedPlaceholder = NSAttributedString(string: setPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        textAlignment = .center
        font = UIFont(name: "Cinzel-Regular", size: 20)
        tintColor = .white
        
        // Margins inside
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        leftViewMode = .always
        rightView = rightCancelButton
        rightViewMode = .always
        
        self.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        self.keyboardType = .asciiCapable
        self.addDoneKeyboardAccessoryButton()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Animate, UITextFieldDelegate
extension CustomTF: UITextFieldDelegate {
    
    // Did Change
    func textFieldDidChangeSelection(_ textField: UITextField) {
        customTFActionDelegate?.textFieldDidChangeSelection(textField)
    }
    
    // Did Begin
    // Animate, Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.rightCancelButton.isHidden = false
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            
            // Selected TF state
            textField.layer.borderWidth = DS.borderWidth
            textField.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
            textField.layer.shadowOpacity = 1
            textField.layer.shadowRadius = 16
            textField.layer.shadowOffset = CGSize(width: 0, height: 4)
            textField.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
            
            // Button animate
            self.rightCancelButton.alpha = 1
        }, completion: nil)
        self.customTFActionDelegate?.textFieldDidBeginEditing(textField)
    }
    
    
    // MARK: Animate, Delegate 
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Button animate
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            
            // Default TF state
            textField.layer.borderWidth = 1
            textField.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1).withAlphaComponent(0.7).cgColor
            textField.layer.shadowOffset = CGSize.zero
            textField.layer.shadowColor = UIColor.clear.cgColor
            
            // Button animate
            self.rightCancelButton.alpha = 0
        } completion: { _ in
            self.rightCancelButton.isHidden = true
        }
        
        customTFActionDelegate?.textFieldDidEndEditing(textField)
    }
    
    // MARK: Delegate shouldChangeCharactersIn
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        guard let newTextField = textField.text else { return false }
//        let text = newTextField + string
//        
//        // Replacing space + restrict
//        if text.contains(" ")  {
//            textField.text = text.replacingOccurrences(of: " ", with: "")
//
//            if text.contains(" ") {
//                return false
//            }
//        }
//        return true
//    }
}
