//
//  CalendarCell.swift
//  Numerology
//
//  Created by Serj on 01.12.2023.
//

import Foundation
import UIKit


protocol CustomCalendarCellDelagete {
//    var openFrom: UIViewController? { get set }
    func readMoreAction()
}

class CalendarCell: UICollectionViewCell {
    
    var customCalendarCellDelagete: CustomCalendarCellDelagete? = nil

    static var reuseID: String {
        String(describing: self)
    }
    
    
    var calendarView: CalendarView = {
        let v = CalendarView()
        v.isUserInteractionEnabled = false
//        v.backgroundColor = .black
        return v
    }()
    
    
    // MARK: - delete Data Button
    let readMoreBtn: UIButton = {
        let b = UIButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        b.layer.cornerRadius = 16
        
        // Lable
        let lable: UILabel = {
            let l = UILabel()
            l.translatesAutoresizingMaskIntoConstraints = false
            l.font = UIFont.init(weight: .semiBold, size: 15)
            l.textAlignment = .left
            l.textColor = .white
            l.text = "Read more"
            return l
        }()
        // Icon
        let icon: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = UIView.ContentMode.scaleAspectFill
            iv.tintColor = .white
            let configImage = UIImage(
                systemName: "chevron.right",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
            )
            iv.image = configImage
            return iv
        }()
        //
        let contentStack = UIStackView(arrangedSubviews: [lable,icon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 4
        //
        contentStack.isUserInteractionEnabled = false
        //
        b.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: b.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: b.trailingAnchor, constant: -16),
            contentStack.centerYAnchor.constraint(equalTo: b.centerYAnchor),
            contentStack.heightAnchor.constraint(equalToConstant: 40),
        ])
        b.addTarget(Any?.self, action: #selector(readMoreAction), for: .touchUpInside)
        return b
    }()
    
    @objc private func readMoreAction() {
        print("TEST🔴")
        self.customCalendarCellDelagete?.readMoreAction()
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
        
        // Setup
        setUpStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(title: String, subtitle: String?, bgImage: UIImage?) {
//        self.title.text = title
//        self.subtitle.text = subtitle
//
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            self.image.image = bgImage ?? UIImage(named: "plug")
//        }
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
//        let cellWidth = self.frame.width - 32
//        self.calendarView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth)
//        self.calendarView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
//        let titleStack = UIStackView(arrangedSubviews: [calendarView])
//        titleStack.axis = .vertical
//        titleStack.alignment = .fill
//        titleStack.spacing = 4
        
//        readMoreBtn
        let contentStack = UIStackView(arrangedSubviews: [calendarView,UIView(),readMoreBtn])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
//        contentStack.distribution = .fill
        contentStack.spacing = 0
        
        
        
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            calendarView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 0),
            calendarView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -0),
            calendarView.heightAnchor.constraint(equalTo: calendarView.widthAnchor),
        ])
    }
}
