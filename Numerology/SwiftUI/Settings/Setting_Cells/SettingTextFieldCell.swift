//
//  File.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

// MARK: - "Setting Text Field Cell"
import SwiftUI
import UIKit

class PlainTextField: UITextField, UITextFieldDelegate {
    
    @Binding var enteredText: String?
    
    init(enteredText: Binding<String?>, setPlaceholder: String) {
        self._enteredText = enteredText
        super.init(frame: .null)
        self.text = self.enteredText
        self.delegate = self
        // Setup
        self.tintColor = .white
        self.clearButtonMode = .whileEditing
        self.addDoneKeyboardAccessoryButton()
        self.attributedPlaceholder = NSAttributedString(string: setPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let text = textField.text {
//            self.enteredText = text
//        }
//    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            self.enteredText = text
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let newTextField = textField.text else { return false }
        let text = newTextField + string

        // Replacing space + restrict
        if text.contains(" ")  {
            textField.text = text.replacingOccurrences(of: " ", with: "")

            if text.contains(" ") {
                return false
            } 
//            else if text.contains(".") {
//                return false
//            }
        }
        return true
    }
    
}


struct PlainTextField_SUI: UIViewRepresentable {
    
    @Binding var enteredText: String?
    var setPlaceholder: String

    func makeUIView(context: Context) -> PlainTextField {
        let dp = PlainTextField(enteredText: $enteredText, setPlaceholder: setPlaceholder)
        return dp
    }

    func updateUIView(_ uiView: PlainTextField, context: Context) {

    }

}
