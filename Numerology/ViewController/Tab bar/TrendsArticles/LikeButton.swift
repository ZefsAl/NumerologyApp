//
//  LikeButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 10.06.2024.
//

import UIKit

class LikeButton: UIButton {
    
    private var amountLikes: Int = 0 {
        didSet {
            self.likeTitle.text = String(amountLikes)
        }
    }
    
    private var didTapState: Bool = false {
        didSet {
            self.amountLikes = didTapState ? amountLikes + 1 : amountLikes - 1
            setIconToggle(didTapState)
        }
    }
    
    // MARK: - isTouchInside
    override var isTouchInside: Bool {
        didTapState = didTapState ? false : true
        return true
    }
    
    private let likeTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.numberOfLines = 0
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 16)
        return l
    }()
    
    private let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.tintColor = .white
        let configImage = UIImage(
            systemName: "hand.thumbsup",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
        iv.image = configImage
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setUI()
        setAmountLikes(amount: self.amountLikes)
    }
    
    func setAmountLikes(amount: Int) {
        self.amountLikes = amount
    }
    
    private func setIconToggle(_ state: Bool) {
        let configImage = UIImage(
            systemName: state ? "hand.thumbsup.fill" : "hand.thumbsup",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        )
        icon.image = configImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        let contentStack = UIStackView(arrangedSubviews: [icon,likeTitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 6
        contentStack.isUserInteractionEnabled = false
        
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
