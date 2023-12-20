//
//  AccordionButton.swift
//  Numerology
//
//  Created by Serj on 27.11.2023.
//

import UIKit

class AccordionButton: UIButton {
    
    private var didTapState: Bool = false {
        didSet {
            changeIcon(bool: didTapState)
        }
    }
    // MARK: - isTouchInside
    override var isTouchInside: Bool {
        didTapState = didTapState ? false : true
        return true
    }
    // MARK: - main Title
    let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .semiBold, size: 24)
        l.textAlignment = .left
//        l.text = "Tap here"
        return l
    }()
    // MARK: - Icon
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        let configImage = UIImage(
            systemName: "chevron.up.circle",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        )
        iv.image = configImage
        return iv
    }()
    // MARK: - change Icon
    private func changeIcon(bool: Bool) {
        let configImage = UIImage(
            systemName: bool ? "chevron.down.circle" : "chevron.up.circle",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        )
        icon.image = configImage
    }
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - configure
    func configure(title: String) {
        changeIcon(bool: false)
        self.mainTitle.text = title
    }
    // MARK: - setupUI
    private func setupUI() {
        //
        let contentStack = UIStackView(arrangedSubviews: [mainTitle,UIView(),icon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 4
        //
        contentStack.isUserInteractionEnabled = false 
        //
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
