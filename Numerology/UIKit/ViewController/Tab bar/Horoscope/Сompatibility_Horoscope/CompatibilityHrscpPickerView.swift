//
//  Numerology
//
//  Created by Serj_M1Pro on 01.08.2024.
//

import UIKit
import MMMHorizontalPicker

struct CompatibilitySignsModel {
    let index: Int
    let sign: String
    let signDateRange: String
    let image: UIImage?
}

class CompatibilityData {
    static let compatibilitySignsData = [
        // Fake
        CompatibilitySignsModel(index: 0 , sign: "Sagittarius", signDateRange: "23.11 - 21.12", image: UIImage(named: "Sagittarius-CMPTB")),
        CompatibilitySignsModel(index: 1 , sign: "Capricorn",   signDateRange: "22.12 - 20.01",  image: UIImage(named: "Capricorn-CMPTB")),
        // Origin
        CompatibilitySignsModel(index: 2  , sign: "Aquarius",    signDateRange: "21.01 - 20.02",  image: UIImage(named: "Aquarius-CMPTB")),
        CompatibilitySignsModel(index: 3  , sign: "Pisces",      signDateRange: "21.02 - 20.03",  image: UIImage(named: "Pisces-CMPTB")),
        CompatibilitySignsModel(index: 4  , sign: "Aries",       signDateRange: "21.03 - 20.04", image: UIImage(named: "Aries-CMPTB")),
        CompatibilitySignsModel(index: 5  , sign: "Taurus",      signDateRange: "21.04 - 20.05", image: UIImage(named: "Taurus-CMPTB")),
        CompatibilitySignsModel(index: 6  , sign: "Gemini",      signDateRange: "21.05 - 21.06", image: UIImage(named: "Gemini-CMPTB")),
        CompatibilitySignsModel(index: 7  , sign: "Cancer",      signDateRange: "22.06 - 22.07", image: UIImage(named: "Cancer-CMPTB")),
        CompatibilitySignsModel(index: 8  , sign: "Leo",         signDateRange: "23.07 - 23.08", image: UIImage(named: "Leo-CMPTB")),
        CompatibilitySignsModel(index: 9  , sign: "Virgo",       signDateRange: "24.08 - 23.09", image: UIImage(named: "Virgo-CMPTB")),
        CompatibilitySignsModel(index: 10 , sign: "Libra",       signDateRange: "24.09 - 23.10", image: UIImage(named: "Libra-CMPTB")),
        CompatibilitySignsModel(index: 11 , sign: "Scorpio",     signDateRange: "24.10 - 22.11", image: UIImage(named: "Scorpio-CMPTB")),
        CompatibilitySignsModel(index: 12 , sign: "Sagittarius", signDateRange: "23.11 - 21.12", image: UIImage(named: "Sagittarius-CMPTB")),
        CompatibilitySignsModel(index: 13 , sign: "Capricorn",   signDateRange: "22.12 - 20.01",  image: UIImage(named: "Capricorn-CMPTB")),
        // Fake
        CompatibilitySignsModel(index: 14 , sign: "Aquarius",    signDateRange: "21.01 - 20.02",  image: UIImage(named: "Aquarius-CMPTB")),
        CompatibilitySignsModel(index: 15 , sign: "Pisces",      signDateRange: "21.02 - 20.03",  image: UIImage(named: "Pisces-CMPTB")),
    ]
}

class CompatibilityHrscpPickerView: UIView, MMMHorizontalPickerDelegate {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    
    private let pickerView = MMMHorizontalPicker(style: .uniform)
    
    // View Models
    private var items = [PickerItem]()
    
    // section Title
    private let sectionTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textColor = DS.Horoscope.lightTextColor
        l.textAlignment = .center
        l.font = UIFont(name: "Cinzel-Regular", size: 26)
        l.sizeToFit()
        l.text = "Compatibility of Signs"
        return l
    }()

    // section Subtitle
    private let sectionSubtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.textColor = DS.Horoscope.lightTextColor
        l.textAlignment = .center
        l.font = UIFont.setSourceSerifPro(weight: .bold, size: 11)
        l.text = "* Scroll to select"
        return l
    }()
    
    // signs Date Title
    private let signsDateTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = DS.SourceSerifProFont.title_h5
        l.textAlignment = .center
        l.textColor = .white
        l.numberOfLines = 2
        l.text = "123\n123"
        return l
    }()
    
    // capsule Hrscp Button
    lazy private var compareButton: CapsuleButton = {
        let b = CapsuleButton()
        b.heightAnchor.constraint(equalToConstant: 36).isActive = true
        b.widthAnchor.constraint(equalToConstant: 216).isActive = true
        b.addTarget(self, action: #selector(self.compareButtonAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isMultipleTouchEnabled = false 
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.pickerView.layoutSubviews()
        // init UI Items
        DispatchQueue.main.async {
            self.items = CompatibilityData.compatibilitySignsData.compactMap { model in
                let item = PickerItem(model: model)
                item.addTarget(self, action: #selector(self.itemDidTap), for: .touchUpInside)
                return item
            }
            self.pickerView.reload()
        }
    }
    
    
    // MARK: - setup UI
    private func setupUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // picker
        setInitialState()
        pickerView.delegate = self
        pickerView.spacing = -12
        
        // title Stack
        let titleStack = UIStackView(arrangedSubviews: [
            sectionTitle,
            sectionSubtitle,
        ])
        titleStack.alignment = .fill
        titleStack.axis = .vertical
        titleStack.distribution = .fill
        titleStack.spacing = 0
        
        // MARK: content Stack
        let contentStack = UIStackView(arrangedSubviews: [
            titleStack,
            pickerView,
            signsDateTitle,
            compareButton
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .center
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 12
        
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0)
        ])
    }
    
    private func setInitialState() {
        // initial
        let initialIndex = 2
        let data = CompatibilityData.compatibilitySignsData
        pickerView.prototypeView = PickerItem(model: data[initialIndex])
        //
        self.signsDateTitle.text = "\(data[initialIndex].sign)\n\(data[initialIndex].signDateRange)"
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        let sign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
        self.compareButton.title.text = "\(sign) + \(data[initialIndex].sign)"

        // Initial Select
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6, execute: {
            let currMonthSign = HoroscopeSign.shared.findHoroscopeSign(byDate: Date())
            let newData = data.filter { $0.index != 0 && $0.index != 1 && $0.index != 14 && $0.index != 15 }
            guard let currMonthSignIndex = newData.first(where: { $0.sign == currMonthSign })?.index else { return }
            self.pickerView.setCurrentItemIndex(currMonthSignIndex, animated: true)
        })
    }
    
    // MARK: - Actions
    @objc private func itemDidTap(_ sender: PickerItem) {
        pickerView.setCurrentItemIndex(sender.model.index, animated: true)
    }
    
    @objc private func compareButtonAction(_ sender: UIButton) {
        // user
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        let userSign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
        // selected sign
        let secondSign = CompatibilityData.compatibilitySignsData[pickerView.currentItemIndex].sign
        
        DispatchQueue.main.async {
            HoroscopeManager.shared.getSignСompatibility(zodiacSign: "\(userSign)-\(secondSign)") { model in
                let vc = DetailCompatibilityHrscpVC(
                    compatibilityHrscpModel: model,
                    secondSign: secondSign
                )
                self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - MMMHorizontalPickerDelegate
    func horizontalPickerDidChangeCurrentItemIndex(_ picker: MMMHorizontalPicker) {
        let data = CompatibilityData.compatibilitySignsData
        
        DispatchQueue.main.async {
            self.signsDateTitle.text = "\(data[picker.currentItemIndex].sign)\n\(data[picker.currentItemIndex].signDateRange)"
            self.signsDateTitle.fadeTransition(0.2)
            let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
            let sign = HoroscopeSign.shared.findHoroscopeSign(byDate: dateOfBirth)
            self.compareButton.title.text = "\(sign) + \(data[picker.currentItemIndex].sign)"
            self.compareButton.title.fadeTransition(0.2)
        }
        
        //carousell
        func carousellIndex() -> Int? {
            switch data[picker.currentItemIndex].index {
            case 0: return 12
            case 1: return 13
            case 14: return 2
            case 15: return 3
            default: return nil
            }
        }
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
    
    func horizontalPicker(_ picker: MMMHorizontalPicker, recycle view: UIView) {
        // Called after an item view becomes invisible and is removed from the picker. The delegate can choose to store it somewhere and reuse it later or can just forget it and simply use a new view next time.
    }
    
    func horizontalPicker(_ picker: MMMHorizontalPicker, prepare view: UIView) {
        // Called after the given item view is added into the view hierarchy.
    }
    
    func horizontalPicker(_ picker: MMMHorizontalPicker, didScroll offset: CGFloat) {
        // Called when the picker scrolls to a new offset.
        //print("🔴🔴✅ new", offset) // зотел пофиксить если очень длинный свайп
//        self.hor
        // ⬅️ -0 || >15
//        if offset < 0 {
//            picker.setCurrentItemIndex(12, animated: false)
//        } else if offset > 15 {
//            picker.setCurrentItemIndex(3, animated: false)
//        }
    }
    
    func horizontalPicker(_ picker: MMMHorizontalPicker, update view: UIView, centerProximity: CGFloat) {
        
        // Called every time the viewport position changes (every frame in case of animation or dragging) with an updated "center proximity" value for each visible item view.
        //
        // "Center proximity" is a difference between the center of the item and the current viewport  position in "index space" coordinates.
        //
        // For example, if the current item is in the center of the view port already, then its "center proximiy" value will be 0, and the same value for the view right (left) to the central item will be 1 (-1). When dragging the contents so the right view gets closer to the center, then its center proximity will be continously approaching 0.
        //
        // This is handy when you need to dim or transforms items when they get farther from the center, but be careful with doing heavy things here.        
        
        // Scale
        let isCarousellIndex = [0,1,14,15].contains(picker.currentItemIndex)
        let scale = 1 - (abs(centerProximity) / 3.5)
        view.transform = isCarousellIndex ? CGAffineTransform.identity : CGAffineTransform(scaleX: scale, y: scale)
        //alpha
        guard let view = view as? PickerItem else { return }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            view.alpha = picker.currentItemIndex == view.model.index ? 1 : 0.3
        }
    }
}

// MARK: - Item
private class PickerItem: UIControl {

    public var model: CompatibilitySignsModel
    
    // bgImage
    let image: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    public init(model: CompatibilitySignsModel) {
        self.model = model
        self.image.image = model.image
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setStyle()
        setupStack()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStack() {
        self.addSubview(self.image)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0),
            
            self.heightAnchor.constraint(equalToConstant: 230),
            self.widthAnchor.constraint(equalToConstant: 230),
        ])
    }
    
    private func setStyle() {
        // Style
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        self.layer.borderWidth = DS.borderWidth
        self.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.5).cgColor
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width/2
    }
}

