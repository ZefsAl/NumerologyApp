//
//  MoneyCalendarDescriptionVC.swift
//  Numerology
//
//  Created by Serj_M1Pro on 17.04.2024.
//

import UIKit

class MoneyCalendarDescriptionVC: UIViewController {
    
    var primaryColor: UIColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
    var bgImageNamed: String?

    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        sv.clipsToBounds = false
        return sv
    }()
    
    let descriptionCardView: DescriptionCardView = {
       let v = DescriptionCardView()
        return v
    }()
    
    var calendarView: CalendarView = {
        let v = CalendarView()
        v.isUserInteractionEnabled = false
        return v
    }()
    
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        setBackground(named: self.bgImageNamed ?? "MainBG2.png")
        
        setupStack()
    }
    
    convenience init(primaryColor: UIColor) {
        self.init()
        self.primaryColor = primaryColor
    }
    
    
    
    
    func setNewBackground(named: String) {
        self.bgImageNamed = named
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // оффера небыло ⚠️
        let cardView: UIView = {
            let v = UIView()
//            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = self.primaryColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = self.primaryColor.withAlphaComponent(0.5).cgColor
            
            v.addSubview(calendarView)
            
            let const: CGFloat = 20
            NSLayoutConstraint.activate([
                calendarView.topAnchor.constraint(     equalTo: v.topAnchor,        constant: const),
                calendarView.leadingAnchor.constraint( equalTo: v.leadingAnchor,    constant: const),
                calendarView.trailingAnchor.constraint(equalTo: v.trailingAnchor,   constant: -const),
                calendarView.bottomAnchor.constraint(  equalTo: v.bottomAnchor,     constant: -const),
            ])
            return v
        }()
        
        
        // оффера небыло ⚠️
        let scrollContentStack = UIStackView(arrangedSubviews: [descriptionCardView])
        scrollContentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollContentStack.axis = .vertical
        scrollContentStack.spacing = 8
        
        
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(scrollContentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            
            // оффера то небыло ⚠️
//            calendarView.heightAnchor.constraint(equalToConstant: 340).isActive = true
//
//            // Card View
            scrollContentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 24),
            scrollContentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            scrollContentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            scrollContentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            scrollContentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
        
        
    }


}


class DescriptionCardView: UIView {
    
    var primaryColor: UIColor = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
    
    let mainTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .regular, size: 26)
        l.textAlignment = .left
        return l
    }()
    
    let info: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .regular, size: 17)
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    let about: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.init(weight: .regular, size: 17)
        l.textAlignment = .left
        l.numberOfLines = 0
        
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
        setupStack()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = 16
        self.layer.borderWidth = DesignSystem.borderWidth
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func configure(title: String, info: String?, about: String?, tintColor: UIColor?) {
        self.mainTitle.text = title
        self.info.text = info
        self.about.text = about
        // Style
        self.layer.borderColor = tintColor?.cgColor
        self.layer.shadowColor = tintColor?.withAlphaComponent(0.5).cgColor
    }
    
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        let contentStack = UIStackView(arrangedSubviews: [mainTitle,info,about])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 8
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            // contentStack
            contentStack.topAnchor.constraint(equalTo:      self.topAnchor,     constant:  16),
            contentStack.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant:  16),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            contentStack.bottomAnchor.constraint(equalTo:   self.bottomAnchor,  constant: -16),
            contentStack.widthAnchor.constraint(equalTo:    self.widthAnchor,   constant: -32),
            contentStack.heightAnchor.constraint(equalTo:   self.heightAnchor,  constant: -32),
        ])
    }
    
    
}
