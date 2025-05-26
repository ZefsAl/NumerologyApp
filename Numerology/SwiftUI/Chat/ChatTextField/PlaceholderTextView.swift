//
//  PlaceholderTextView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 25.05.2025.
//

import Foundation
import UIKit

class PlaceholderTextView: UITextView {
    // Лейбл для плейсхолдера
    private let phLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.textAlignment = .left
        return label
    }()
    
    // Текст плейсхолдера
    var placeholder: String? {
        get { phLabel.text }
        set {
            phLabel.text = newValue
            updatePlaceholderVisibility()
        }
    }
    
    override var text: String! {
        didSet { updatePlaceholderVisibility() }
    }
    
//    let insets: UIEdgeInsets
    
//    init() {
//        super.init(frame: .zero, textContainer: .none)
//        setup()
//        
//        // Font
//        self.phLabel.font = self.font
//        //
//        self.textAlignment = .left
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func setup() {
        // Добавляем лейбл
        addSubview(phLabel)
        phLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.textContainerInset.left + 4),
            phLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            phLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        // Настройка делегата
        updatePlaceholderVisibility()
    }
    
    // Обновляем видимость плейсхолдера
    private func updatePlaceholderVisibility() {
        phLabel.isHidden = !text.isEmpty
    }
}
