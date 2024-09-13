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
        l.textColor = .hexColor("F3789B").withAlphaComponent(0.7)
        l.numberOfLines = 0
        l.font = UIFont.setSourceSerifPro(weight: .regular, size: 17)
        return l
    }()
    
    private let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.tintColor = .white
        let configImage = UIImage(
            systemName: "heart",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        )?.withTintColor(.hexColor("F3789B").withAlphaComponent(0.7), renderingMode: .alwaysOriginal)
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
    
    func configureLike(model: TrendsCellModel) {
        guard 
            let likes = model.likes,
            let articleID = model.articleID
        else { return }
        
        self.amountLikes = likes
        self.articleID = articleID

        if likes <= 0 { // couldn't be liked
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
            systemName: state ? "heart.fill" : "heart",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        )?.withTintColor(.hexColor("F3789B").withAlphaComponent(0.7), renderingMode: .alwaysOriginal)
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
        
        
        contentStack.setNeedsLayout()
        contentStack.layoutIfNeeded()
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: contentStack.frame.height)
        ])
    }
    
}
