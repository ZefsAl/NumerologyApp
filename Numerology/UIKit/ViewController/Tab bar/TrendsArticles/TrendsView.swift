//
//  TrendsView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 13.06.2024.
//

import UIKit


final class TrendsView: UIView, LikeButtonDelegate {
    
    var articleID: String? = nil
    
    func likeAction() {} // ???
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // MARK: -
    let imageTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 26)
        l.textAlignment = .center
        l.textColor = DS.TrendsArticles.textColor
        l.numberOfLines = 1
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    lazy var shareButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        let configImage = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        )?.withTintColor(DS.TrendsArticles.primaryColor, renderingMode: .alwaysOriginal)
        b.setImage(configImage, for: .normal)
        b.addTarget(self, action: #selector(shareCellAction), for: .touchUpInside)
        return b
    }()
    @objc func shareCellAction() {
        self.remoteOpenDelegate?.openFrom?.shareButtonClicked()
    }
    
    let likeButton = LikeButton()
    
    // MARK: Icon
    let bgImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    // MARK: - Gradient
    private let blackSmoothGradient: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "BlackSmoothGradient")
        iv.contentMode = .scaleAspectFill
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    // MARK: - required init
    required init() {
        super.init(frame: .null)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        setupStack()
        self.likeButton.likeButtonDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataModel(model: TrendsCellModel) {
        self.imageTitle.text = model.imageTitle
        self.bgImage.image = model.image
        // like
        self.articleID = model.articleID
        self.likeButton.configureLike(model: model)
    }
    
    private func setupStack() {
        // MARK: content Stack
        let buttonsStack = UIStackView(arrangedSubviews: [
            shareButton,
            UIView(),
            likeButton,
        ])
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.alignment = .center
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fill

        // add
        self.addSubview(bgImage) // 1
        self.addSubview(blackSmoothGradient) // 2
        self.addSubview(imageTitle)
        self.addSubview(buttonsStack)
        //
        NSLayoutConstraint.activate([
            // bg Image
            bgImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            // black Smooth Gradient
            blackSmoothGradient.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            blackSmoothGradient.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            blackSmoothGradient.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            blackSmoothGradient.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            // title
            imageTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            // buttons
            buttonsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            buttonsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
    
}
