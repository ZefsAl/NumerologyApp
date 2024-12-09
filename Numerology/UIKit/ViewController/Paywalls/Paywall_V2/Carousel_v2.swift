//
//  Carousel_v2.swift
//  Numerology
//
//  Created by Serj_M1Pro on 21.11.2024.
//

import UIKit
import MMMHorizontalPicker

class Carousel_v2: UIView, MMMHorizontalPickerDelegate {
    
    var timer = Timer()
    
    private let pickerView = MMMHorizontalPicker(style: .default)
    
    // View Models
    private var items = [CarouselItem]()
    
    let cardContentData: [CardContentModel] = [
        
        CardContentModel(index: 0, title: "Deeply Insightful",
                         date: "September 18.2024",
                         fullname: "Lisa Wilson",
                         comment: "The insights I've gained through this app are profound. It's like having a wise mentor at your fingertips. I can't recommend it enough for personal growth."),
        
        CardContentModel(index: 1, title: "A Must-Have!",
                         date: "December 03.2024",
                         fullname: "Mark Taylor",
                         comment: "This app is a must-have for anyone interested in numerology. It's user-friendly, insightful, and has become an integral part of my daily routine. Recommend it enough!"),
        //
        CardContentModel(index: 2, title: "Awesome App!",
                         date: "July 25.2024",
                         fullname: "John Doe",
                         comment: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"),
        
        CardContentModel(index: 3, title: "Life-Changing!",
                         date: "August 12.2024",
                         fullname: "Sarah Smith",
                         comment: "I've been using this app for months, and I'm amazed at the precision of its predictions.\nIt's like having a personal numerologist in my pocket!"),
        
        CardContentModel(index: 4, title: "Amazing Insights!",
                         date: "September 05.2024",
                         fullname: "Emily Davis",
                         comment: "The readings from this app are deeply insightful and thought-provoking. It feels like a guiding light through the mysteries of life.\nI absolutely love it!"),
        
        CardContentModel(index: 5, title: "Deeply Insightful",
                         date: "September 18.2024",
                         fullname: "Lisa Wilson",
                         comment: "The insights I've gained through this app are profound. It's like having a wise mentor at your fingertips. I can't recommend it enough for personal growth."),
        
        CardContentModel(index: 6, title: "A Must-Have!",
                         date: "December 03.2024",
                         fullname: "Mark Taylor",
                         comment: "This app is a must-have for anyone interested in numerology. It's user-friendly, insightful, and has become an integral part of my daily routine. Recommend it enough!"),
        
        //
        CardContentModel(index: 7, title: "Awesome App!",
                         date: "July 25.2024",
                         fullname: "John Doe",
                         comment: "This app is truly fantastic, and it has completely transformed my perspective on numerology. I highly recommend it to everyone seeking profound insights!"),
        
        CardContentModel(index: 8, title: "Life-Changing!",
                         date: "August 12.2024",
                         fullname: "Sarah Smith",
                         comment: "I've been using this app for months, and I'm amazed at the precision of its predictions.\nIt's like having a personal numerologist in my pocket!"),
    ]
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isMultipleTouchEnabled = false
        setupUI()
        // init UI Items
        DispatchQueue.main.async {
            self.items = self.cardContentData.compactMap { model in
                let item = CarouselItem(model: model)
                item.addTarget(self, action: #selector(self.itemDidTap), for: .touchUpInside)
                return item
            }
            self.pickerView.reload()
            self.setTimer()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Auto Scroll
    lazy var currentItem = 0
    
    func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        let index = self.pickerView.currentItemIndex + 1
        self.pickerView.setCurrentItemIndex(index, animated: true)
    }
    
    
    // MARK: - setup UI
    private func setupUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // picker
        setInitialState()
        pickerView.delegate = self
        pickerView.spacing = -35
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0)
        ])
    }
    
    private func setInitialState() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: { [self] in
            let initialIndex = 2
            self.currentItem = initialIndex
            pickerView.prototypeView = CarouselItem(model: self.cardContentData[initialIndex])
            self.pickerView.setCurrentItemIndex(2, animated: false)
        })
    }
    
    // MARK: - Actions
    @objc private func itemDidTap(_ sender: CarouselItem) {
        pickerView.setCurrentItemIndex(sender.model.index, animated: true)
    }
    
    
    func carousellIndex() -> Int? {
        switch self.cardContentData[self.pickerView.currentItemIndex].index {
        case 7: return 2
        case 8: return 3
        case 1: return 6
        case 0: return 5
        default: return nil
        }
    }
    
    // MARK: - MMMHorizontalPickerDelegate
    func horizontalPickerDidChangeCurrentItemIndex(_ picker: MMMHorizontalPicker) {
        if let index = carousellIndex() {
            picker.setCurrentItemIndex(index, animated: false)
        }
    }
    
    
    func numberOfItemsForHorizontalPicker(_ picker: MMMHorizontalPicker) -> Int {
        return items.count
    }
    
    func horizontalPicker(_ picker: MMMHorizontalPicker, viewForItemWith index: Int) -> UIView {
        return items[index]
    }
    
    func horizontalPicker(_ picker: MMMHorizontalPicker, update view: UIView, centerProximity: CGFloat) {
        // Scale
        let isCarousellIndex = [7,8,1,0].contains(picker.currentItemIndex)
        let scale = 1 - (abs(centerProximity) / 3.5)
        view.transform = isCarousellIndex ? CGAffineTransform.identity : CGAffineTransform(scaleX: scale, y: scale)
        //alpha
        guard let view = view as? CarouselItem else { return }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            view.alpha = picker.currentItemIndex == view.model.index ? 1 : 0.6
        }
    }
    
}

// MARK: - Item
private class CarouselItem: UIControl {
    
    var model: CardContentModel
    
       // MARK: Main Title
       private let mainTitle: UILabel = {
           let l = UILabel()
           l.translatesAutoresizingMaskIntoConstraints = false
           l.font = UIFont.setSourceSerifPro(weight: .regular, size: 20)
           l.textColor = .white
           return l
       }()
       
       // MARK: Rating Emoji Caption
       private let ratingEmojiCaption: UILabel = {
           // Картинка все ломает по этому Emoji
           let l = UILabel()
           l.text = "⭐️⭐️⭐️⭐️⭐️"
           l.font = UIFont.systemFont(ofSize: 13)
           return l
       }()
       
       // MARK: Date Caption
       private let dateCaption: UILabel = {
           let l = UILabel()
           l.font = UIFont.setSourceSerifPro(weight: .regular, size: 11)
           l.numberOfLines = 0
           l.textAlignment = .right
           l.textColor = .lightGray
           
           return l
       }()
       
       // MARK: Full Name
       private let fullNameLable: UILabel = {
           let l = UILabel()
           l.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
           l.numberOfLines = 0
           l.textAlignment = .right
           l.textColor = .white
           return l
       }()
       
       // MARK: Comment Text
       private let commentText: UILabel = {
           let l = UILabel()
           l.translatesAutoresizingMaskIntoConstraints = false
           l.font = UIFont.setSourceSerifPro(weight: .regular, size: 13)
           l.numberOfLines = 4
           l.textColor = .white
           
           return l
       }()
       
       
       // MARK: Init
    public init(model: CardContentModel) {
        self.model = model
        
        super.init(frame: .null)
        self.translatesAutoresizingMaskIntoConstraints = false
        // Style
        self.backgroundColor = DesignSystem.PaywallTint.primaryDarkBG.withAlphaComponent(0.7)
        // Border
        self.layer.cornerRadius = DesignSystem.maxCornerRadius
        // setup
        setupStack()
        
        self.configure(
            title:    model.title,
            date:     model.date,
            fullname: model.fullname,
            comment:  model.comment
        )
    }
//    init(model: CardContentModel) {
//           super.init(frame: .null)
//           self.translatesAutoresizingMaskIntoConstraints = false
//           // Style
//           self.backgroundColor = DesignSystem.PaywallTint.primaryDarkBG.withAlphaComponent(0.7)
//           // Border
//           self.layer.cornerRadius = DesignSystem.maxCornerRadius
//           // setup
//           setupStack()
//           
////           self.configure(
////               title:    cardContentData[currentCell].title,
////               date:     cardContentData[currentCell].date,
////               fullname: cardContentData[currentCell].fullname,
////               comment:  cardContentData[currentCell].comment
////           )
//       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       // MARK: Configure
       func configure(title: String, date: String, fullname: String, comment: String) {
           self.mainTitle.text = title
           self.dateCaption.text = date
           self.fullNameLable.text = fullname
           self.commentText.text = comment
       }
       
       // MARK: Set up Stack
       private func setupStack() {

           
           // Left Title Stack
           let leftStack = UIStackView(arrangedSubviews: [mainTitle,ratingEmojiCaption])
           leftStack.axis = .vertical
           leftStack.alignment = .fill
           leftStack.spacing = 4
           
           // Left Title Stack
           let rightStack = UIStackView(arrangedSubviews: [dateCaption, fullNameLable, UIView()])
           rightStack.axis = .vertical
           rightStack.alignment = .trailing
           rightStack.distribution = .fill
           
           // Top Stack
           let topStack = UIStackView(arrangedSubviews: [leftStack,rightStack])
           topStack.axis = .horizontal
           topStack.alignment = .fill
           topStack.distribution = .equalSpacing
           
           // Card Content
           let cardContent = UIStackView(arrangedSubviews: [topStack, commentText])
           cardContent.translatesAutoresizingMaskIntoConstraints = false
           cardContent.axis = .vertical
           cardContent.alignment = .fill
           cardContent.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
           cardContent.isLayoutMarginsRelativeArrangement = true
           cardContent.spacing = 10
           
           self.addSubview(cardContent)
           
           NSLayoutConstraint.activate([
               cardContent.topAnchor.constraint(equalTo: topAnchor, constant: 0),
               cardContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
               cardContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
               cardContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
               self.widthAnchor.constraint(equalToConstant: 324),
           ])
       }
}

