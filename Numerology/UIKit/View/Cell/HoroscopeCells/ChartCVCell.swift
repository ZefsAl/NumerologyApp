//
//  ChartCVCell.swift
//  Numerology
//
//  Created by Serj_M1Pro on 05.08.2024.
//

import UIKit

class ChartButtonCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet {
            DS.setCardStyle(
                to: self,
                tintColor: self.isSelected ? DS.Horoscope.primaryColor : UIColor.clear,
                cornerRadius: 16
            )
        }
    }
    
    let contentStack = UIStackView()
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.title_h6
        l.textAlignment = .left
        l.text = "test"
        return l
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(data: [ChartCVCellModel], indexPath: IndexPath) {

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
        )?.withTintColor(.white)
        let fullString = NSMutableAttributedString(string: "\(data[indexPath.row].title) ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        self.title.attributedText = fullString
        self.title.adjustsFontSizeToFitWidth = true
        //
        self.contentStack.removeFromSuperview()
        title.textAlignment = .center
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])

    }
    
//    func changeCellToBigBtn() {
//        self.contentStack.removeFromSuperview()
//        title.textAlignment = .center
//        self.addSubview(title)
//        NSLayoutConstraint.activate([
//            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//        ])
//    }
}


class ChartCVCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet {
            DS.setCardStyle(
                to: self,
                tintColor: self.isSelected ? DS.Horoscope.primaryColor : UIColor.clear,
                cornerRadius: 16
            )
        }
    }
    
    let contentStack = UIStackView()
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.title_h6
        l.textAlignment = .left
        l.text = "test"
        return l
    }()
    
    let percentTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.title_h6
        l.textAlignment = .right
        l.text = "0.0"
        return l
    }()
    
    private let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.layer.cornerRadius = 2.5
        pv.clipsToBounds = true
        
        pv.layer.sublayers![1].cornerRadius = 2.5
        pv.subviews[1].clipsToBounds = true
        
        NSLayoutConstraint.activate([
            pv.heightAnchor.constraint(equalToConstant: 5),
        ])
        return pv
    }()

    
    func setProgressValue(value: Int) {
        progressView.progress = Float(value)/Float(100)
    }
    func setProgressColor(_ color: UIColor) {
        self.progressView.trackTintColor = color.withAlphaComponent(0.2)
        self.progressView.tintColor = color
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    enum CellTypeEnum {
        case chart, button
    }
    
//    func cellConfigure(type: CellTypeEnum, data: [ChartCVCellModel], indexPath: IndexPath) {
//        
//        switch type {
//            
//        case .chart:
////            setupStack()
//            self.title.text = data[indexPath.row].title
//            self.percentTitle.text = "\(data[indexPath.row].percentTitle)%"
//            self.setProgressValue(value: data[indexPath.row].progressValue)
//            self.setProgressColor(data[indexPath.row].progressColor)
//            self.title.font = DesignSystem.SourceSerifProFont.title_h6
//            self.title.adjustsFontSizeToFitWidth = true
//            self.percentTitle.font = DesignSystem.SourceSerifProFont.title_h6
//            break
//        case .button:
//            let imageAttachment = NSTextAttachment()
//            imageAttachment.image = UIImage(
//                systemName: "chevron.right",
//                withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
//            )?.withTintColor(.white)
//            let fullString = NSMutableAttributedString(string: "\(data[indexPath.row].title) ")
//            fullString.append(NSAttributedString(attachment: imageAttachment))
//            self.title.attributedText = fullString
//            self.title.adjustsFontSizeToFitWidth = true
//            //
//            self.contentStack.removeFromSuperview()
//            title.textAlignment = .center
//            self.addSubview(title)
//            NSLayoutConstraint.activate([
//                title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//                title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            ])
//            
//            break
//        }
//        
//        
//    }
    
    func changeCellToBigBtn() {
        self.contentStack.removeFromSuperview()
        title.textAlignment = .center
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func setupStack() {
        let firstStack = UIStackView(arrangedSubviews: [title,percentTitle])
        firstStack.axis = .horizontal
        firstStack.alignment = .fill
        firstStack.distribution = .fill
        firstStack.spacing = 0
        
        let secondStack = UIStackView(arrangedSubviews: [progressView])
        secondStack.axis = .horizontal
        secondStack.alignment = .fill
        secondStack.distribution = .fill
        secondStack.spacing = 0
        
        //
        contentStack.addArrangedSubview(firstStack)
        contentStack.addArrangedSubview(secondStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .fill
        contentStack.spacing = 8
        
        // margin
        contentStack.layoutMargins = UIEdgeInsets(top: 10, left: 6, bottom: 12, right: 6)
        contentStack.isLayoutMarginsRelativeArrangement = true
        
        // constraints
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
