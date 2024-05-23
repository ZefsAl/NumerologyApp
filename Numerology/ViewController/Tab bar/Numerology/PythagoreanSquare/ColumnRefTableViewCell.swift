//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.05.2024.
//

import UIKit


class ColumnRefTableViewCell: UITableViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    // MARK: title
    private let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .setCinzelRegular(size: 24)
        l.textAlignment = .center
        l.textColor = DesignSystem.Numerology.lightTextColor
        return l
    }()
    
    // MARK: subtitle
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .setCinzelRegular(size: 16)
        l.numberOfLines = 0
        l.textAlignment = .center
        l.textColor = DesignSystem.Numerology.lightTextColor
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String?, subtitle: String?) {
        self.title.text = title
        self.subtitle.text = subtitle
    }
    
    private func setupUI() {
        
        let titleStack = UIStackView(arrangedSubviews: [title,subtitle])
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .vertical
        titleStack.alignment = .center
        titleStack.spacing = 0
        
        self.addSubview(titleStack)
        NSLayoutConstraint.activate([
            titleStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
}
