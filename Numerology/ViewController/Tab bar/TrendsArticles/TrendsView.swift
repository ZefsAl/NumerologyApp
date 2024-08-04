//
//  TrendsView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 13.06.2024.
//

import UIKit


final class TrendsView: UIView, LikeButtonDelegate {
    
    var articleID: String? = nil
    
    
    
    func likeAction() {
    }
    
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // MARK: -
    let imageTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Cinzel-Regular", size: 26)
        l.textAlignment = .left
        l.textColor = DesignSystem.TrendsArticles.textColor
        l.numberOfLines = 1
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    lazy var shareButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        let configImage = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
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
    required init(edgeMargin: CGFloat) {
        super.init(frame: .null)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        setupStack(edgeMargin: edgeMargin)
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
    
    private func setupStack(edgeMargin: CGFloat) {
        // add
        self.addSubview(bgImage) // 1
        self.addSubview(blackSmoothGradient) // 2
        self.addSubview(imageTitle)
        self.addSubview(shareButton)
        self.addSubview(likeButton)
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
            imageTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: edgeMargin),
            imageTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeMargin),
            imageTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeMargin),
            // share
            shareButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeMargin),
            shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeMargin),
            // like
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeMargin),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeMargin),
        ])
    }
    
}
