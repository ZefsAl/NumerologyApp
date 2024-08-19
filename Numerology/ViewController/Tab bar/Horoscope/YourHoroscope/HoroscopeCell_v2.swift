//
//  HoroscopeCell.swift
//  Numerology
//
//  Created by Serj on 26.11.2023.
//

import UIKit


//extension NSTextAttachment {
//    func setImageHeight(height: CGFloat) {
//        guard let image = image else { return }
//        let ratio = image.size.width / image.size.height
//        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
//    }
//}

class HoroscopeCell_v2: UICollectionViewCell, SegmentedControlCustomDelegate {
    
    // MARK: - Constants
    
    static var reuseID: String {
        String(describing: self)
    }
    

    let horoscopeCellViewModel = HoroscopeCellViewModel()
    // MARK: - 🌕 UI
    
    // MARK: title
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.CinzelFont.title
        l.textAlignment = .center
        l.textColor = DesignSystem.Horoscope.lightTextColor
        return l
    }()
    
    // MARK: subtitle
    let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.CinzelFont.subtitle
        l.numberOfLines = 0
        l.textAlignment = .center
        l.textColor = DesignSystem.Horoscope.lightTextColor
        return l
    }()
    
    let segmentedControlData: [String] = ["Today","Tomorrow","Week","Month","Year"]
    
    // MARK: - segmented Control
    lazy var segmentedControl: SegmentedControlHRSCP = {
        let sc = SegmentedControlHRSCP(items: segmentedControlData)
        sc.customDelegate = self
        sc.translatesAutoresizingMaskIntoConstraints = true
        return sc
    }()
    
    // Delegate act
    func currentSegment(index: Int) {
        print("🟣✅ currentSegment", index)
        
        self.chartsTitle.fadeTransition(0.3)
        self.chartsText.fadeTransition(0.3)
        
        switch index {
        case 0:
            
            DispatchQueue.main.async {
                self.horoscopeCellViewModel.setTodayData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                self.setCardText(model: model)
                self.chartsCV.reloadData()
            }
            break
        case 1:
            DispatchQueue.main.async {
                self.horoscopeCellViewModel.setTomorrowData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                self.setCardText(model: model)
                self.chartsCV.reloadData()
            }
            break
        case 2:
            DispatchQueue.main.async {
                self.horoscopeCellViewModel.setWeekData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                self.setCardText(model: model)
                self.chartsCV.reloadData()
            }
            break
        case 3:
            DispatchQueue.main.async {
                self.horoscopeCellViewModel.setMonthData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                self.chartsTitle.text = "Generally"
                self.chartsText.text = model.text
                self.chartsCV.reloadData()
            }
            break
        case 4:
            DispatchQueue.main.async {
                self.horoscopeCellViewModel.setYearData()
                guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
                self.chartsTitle.text = "Generally"
                self.chartsText.text = model.text
                self.chartsCV.reloadData()
            }
            break
            //
        default: break;
        }
        
    }
    
    // MARK: - Loader
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.contentMode = .scaleAspectFill
        aiv.color = .white
        aiv.hidesWhenStopped = true
        aiv.startAnimating()
        aiv.color = #colorLiteral(red: 0.6980392157, green: 0.6901960784, blue: 0.9725490196, alpha: 1)
        return aiv
    }()
    
    let chartsCV: ContentCollectionView = {
        let cv = ContentCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.clipsToBounds = false
        return cv
    }()
    
    
    let chartsTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.subtitle_Sb_15
        l.numberOfLines = 3
        l.textAlignment = .left
        l.textColor = .white
        return l
    }()
    
    let chartsText: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.caption2_Sb_11
        l.numberOfLines = 3
        l.textAlignment = .left
        l.textColor = .white
        return l
    }()
    
    // Read more
    let readMoreLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DesignSystem.SourceSerifProFont.footnote_Sb_13
        l.textAlignment = .left
        l.textColor = .white
        //
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
        )?.withTintColor(.white)
        let fullString = NSMutableAttributedString(string: "Read more ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        l.attributedText = fullString
        return l
    }()
    
    
    
    // MARK: - 🟢 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setStyle()
        // setup
        self.setupStack()
        //
        self.registerChartsCV()
        
        // Initial UI state
        if YourHoroscopeManager.shared.todayHoroscope == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(hrscpTodayDataUpdated), name: .hrscpTodayDataUpdated, object: nil)
        } else {
            self.hrscpTodayDataUpdated()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.cornerRadius = DesignSystem.maxCornerRadius
        self.layer.borderWidth = DesignSystem.borderWidth
        self.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = DesignSystem.maxCornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
    }
    
    // MARK: Configure
    func configureUserGreeting(title: String, subtitle: String?) {
        self.title.text = title
        self.subtitle.text = subtitle
    }
    
    // MARK: - Notification Action
    @objc private func hrscpTodayDataUpdated() {
        DispatchQueue.main.async {
            self.horoscopeCellViewModel.setTodayData()
            guard let model = self.horoscopeCellViewModel.chartsDataSource.first else { return }
            self.setCardText(model: model)
            self.chartsCV.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func setCardText(model: ChartCVCellModel) {
        self.chartsTitle.text = model.title
        self.chartsText.text = model.text
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // Views Priority ->
        // low ⬅️➡️
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        activityIndicatorView.setContentHuggingPriority(.defaultLow, for: .vertical)
        // high ➡️⬅️
        readMoreLable.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        readMoreLable.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // Stacks ->
        
        // 1
        let titleStack = UIStackView(arrangedSubviews: [title,subtitle])
        titleStack.axis = .vertical
        titleStack.alignment = .fill
        titleStack.spacing = 0
        titleStack.arrangedSubviews.forEach { view in
            // high
            view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
        
        // 2
        let secondContentStack = UIStackView(arrangedSubviews: [
            chartsTitle,
            chartsText,
        ])
        secondContentStack.axis = .vertical
        secondContentStack.alignment = .fill
        secondContentStack.distribution = .fill
        secondContentStack.spacing = 8
        secondContentStack.arrangedSubviews.forEach { view in
            // high
            view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
        
        // 3
        let thirdContentStack = UIStackView(arrangedSubviews: [
            segmentedControl,
            activityIndicatorView,
            chartsCV,
            secondContentStack,
        ])
        thirdContentStack.axis = .vertical
        thirdContentStack.alignment = .fill
        thirdContentStack.distribution = .fill
        thirdContentStack.spacing = 16
        

        // 4 main
        let contentStack = UIStackView(arrangedSubviews: [
            titleStack,
            thirdContentStack,
            readMoreLable
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.distribution = .fill
        contentStack.spacing = 16
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            chartsText.heightAnchor.constraint(greaterThanOrEqualToConstant: 38),
            
            titleStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            titleStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            
            thirdContentStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            thirdContentStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
}



