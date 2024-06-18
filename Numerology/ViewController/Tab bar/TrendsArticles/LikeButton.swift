//
//  LikeButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 10.06.2024.
//

import UIKit

protocol LikeButtonDelegate {
    func likeAction()
}

class LikeButton: UIButton {
    
    // MARK: - Const
    var likeButtonDelegate: LikeButtonDelegate? = nil
    
    private var articleID: String? = nil
    
    private var amountLikes: Int = 0 {
        didSet {
            self.likeTitle.text = String(amountLikes)
        }
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
        //
        self.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    }
    
    @objc private func likeAction(_ sender: UIButton) {
        sender.isSelected.toggle() // 1
        print("🔵✅likeAction", sender.isSelected)
        self.likeButtonDelegate?.likeAction() // delegate trigger
        self.amountLikes = sender.isSelected ? amountLikes + 1 : amountLikes - 1
        setIconToggle(sender.isSelected)
        postLikeEvent(sender.isSelected)
        //
        NotificationCenter.default.post(
            name: Notification.Name(TrendsArticlesVM.notificationKey),
            object: nil
        )
    }
    
    private func postLikeEvent(_ isSelected: Bool) {
        guard let articleID = articleID else { return }
        // User defaults
        TrendsArticlesUserDefaults.set(likeState: isSelected, for: articleID)
        // post Firbase field
        TrendsArticlesManager.shared.setToggleLike(docID: articleID, bool: isSelected)
        // upd locale data
        TrendsArticlesVM.shared.updateLikes(
            model: &TrendsArticlesVM.shared.trendsArticlesModel,
            likeValue: self.amountLikes,
            articleID: articleID
        )
    }
    
    func configureLike(
        model: TrendsCellModel
    ) {
        self.amountLikes = model.likes
        self.articleID = model.articleID

        guard let articleID = model.articleID else { return }

        if model.likes <= 0 { // couldn't be liked
            TrendsArticlesUserDefaults.set(likeState: false, for: articleID)
            self.isSelected = false
            self.setIconToggle(false)
        } else {
            self.isSelected = TrendsArticlesUserDefaults.getLikeState(for: articleID)
            self.setIconToggle(TrendsArticlesUserDefaults.getLikeState(for: articleID))
        }
    }
    
    
    // MARK: - set Icon Toggle
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
