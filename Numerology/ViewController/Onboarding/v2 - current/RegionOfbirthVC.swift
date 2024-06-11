//
//  RegionOfbirth.swift
//  Numerology
//
//  Created by Serj on 25.01.2024.
//

import UIKit
import AVFoundation
import MapKit


class TouchThroughStackVeiw: UIStackView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}

class RegionOfbirthVC: UIViewController {
    
    private lazy var completer: MKLocalSearchCompleter = {
       let lsc = MKLocalSearchCompleter()
        lsc.delegate = self
        lsc.region = MKCoordinateRegion(.world)
        lsc.filterType = .locationsOnly
        lsc.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        return lsc
    }()
    
    let locationSearchView: LocationSearchView = {
        let v = LocationSearchView()
        v.alpha = 0
        return v
    }()
    
    
    let fieldsStack = TouchThroughStackVeiw()
    
    // MARK: - largeTitle
    private let largeTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = #colorLiteral(red: 0.9647058824, green: 0.8549019608, blue: 1, alpha: 1)
        l.numberOfLines = 0
        l.font = UIFont(name: "Cinzel-Regular", size: 42)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.04
        l.attributedText = NSMutableAttributedString(string: "Region of birth", attributes: [NSAttributedString.Key.kern: -1.92, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        l.textAlignment = .center
        return l
    }()
    
    // MARK: subtitle
    private let subtitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.numberOfLines = 0
        l.font = UIFont(name: "SourceSerifPro-Light", size: 16)
        l.lineBreakMode = .byWordWrapping
        l.textAlignment = .center
        l.text = "Indicate the city in which you were born; it is not necessary to indicate the time of birth."
        return l
    }()
    
    // MARK: Next Button
    private let nextButton: RegularBigButton = {
        let b = RegularBigButton(frame: .zero, lable: "Continue")
        b.addTarget(Any?.self, action: #selector(nextBtnAction), for: .touchUpInside)
        return b
    }()
    
    // MARK: Next Btn Action
    @objc private func nextBtnAction() {
        guard userPlaceTF.text != "" else { return }
        self.navigationController?.pushViewController(ChooseGenderVC(), animated: true)
    }
    
    
    // MARK: User Place TF
    private let userPlaceTF: CustomTF = {
        let tf = CustomTF(frame: .null, setPlaceholder: "City of birth*")
        return tf
    }()
    
    // MARK: user Time Of Birth
    private lazy var userTimeOfBirth: CustomTF = {
        let tf = CustomTF(frame: .null, setPlaceholder: "Time of birth")
        tf.textAlignment = .center
        tf.rightViewMode = .never
        tf.leftViewMode = .never
        
        // MARK: Date Picker
        let datePicker: UIDatePicker = {
            let dp = UIDatePicker()
            dp.datePickerMode = .time
            dp.preferredDatePickerStyle = .wheels
            
            if let timeDate = makeTimeFromTodayDate(at: (12, 0)) {
                dp.setDate(timeDate, animated: true)
            }
            
            dp.addTarget(Any?.self, action: #selector(timeOfBirthAct), for: .valueChanged)
            return dp
        }()
        tf.inputView = datePicker
        
        return tf
    }()
    @objc func timeOfBirthAct(_ sender: UIDatePicker) {
        userTimeOfBirth.text = makeTimeString(date: sender.date)
    }
    
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegate
        self.userPlaceTF.customTFActionDelegate = self
        self.locationSearchView.locationValueDelegate = self
        // Visual
        self.setBackground(named: "RegionBG.png")
        AnimatableBG().setBackground(vc: self)
        playVideo()
        // Config
        setupStack()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -130
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    private func playVideo() {
        let ref = "planet"
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        guard let path = Bundle.main.path(forResource: ref, ofType: "mp4") else { return }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.borderColor = UIColor.white.cgColor
        self.view.addSubview(iv)
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            iv.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            iv.heightAnchor.constraint(equalToConstant: self.view.frame.width),
            iv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            iv.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -32),
        ])
        
        iv.layoutIfNeeded()
        iv.layer.cornerRadius = iv.frame.width/2
        iv.clipsToBounds = true
        playerLayer.frame = iv.bounds
        iv.layer.addSublayer(playerLayer)
        iv.image = nil
        player.play()
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {
        
        // titles Stack
        let titlesStack = UIStackView(arrangedSubviews: [largeTitle,subtitle])
        titlesStack.axis = .vertical
        titlesStack.alignment = .fill
        titlesStack.spacing = 16
        
        // Field Stack
        fieldsStack.addArrangedSubview(userPlaceTF)
        fieldsStack.addArrangedSubview(userTimeOfBirth)
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 32
        
        // Fields Stack
        let fieldsStack = TouchThroughStackVeiw(arrangedSubviews: [titlesStack,fieldsStack])
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 32
        
        // Content Stack
        let contentStack = TouchThroughStackVeiw(arrangedSubviews: [fieldsStack,UIView(),nextButton])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 0
        
        self.view.addSubview(contentStack)
        
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: margin.topAnchor, constant: 44),
            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            contentStack.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -52)
        ])
    }
}


// MARK: - User Place TF Delegate
extension RegionOfbirthVC: CustomTFActionDelegate, LocationValueDelegate, MKLocalSearchCompleterDelegate  {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if let search = textField.text, textField.text != "" {
            self.locationSearchView.searchFor(term: search)
        } else {
            self.locationSearchView.searchCompletion = []
            self.locationSearchView.searchTableView.reloadData()
        }
    }
    
    // LocationValueDelegate
    func getLocationString(value: String) {
        userPlaceTF.text = value
    }
    
    // AdditionalActionDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
        addSearchPlaceSheet(isActive: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        addSearchPlaceSheet(isActive: false)
        
        guard textField.text != nil && textField.text != "" else { return }
        userTimeOfBirth.text = "12 : 00 PM"
    }
    
    
    private func addSearchPlaceSheet(isActive: Bool) {
        
        guard isActive else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.locationSearchView.alpha = 0
            } completion: { _ in
                self.locationSearchView.removeFromSuperview()
            }
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.view.addSubview(self.locationSearchView)
            self.locationSearchView.alpha = 1
        } completion: { _ in }
        
        NSLayoutConstraint.activate([
            locationSearchView.topAnchor.constraint(equalTo: userPlaceTF.bottomAnchor, constant: 0),
            locationSearchView.leadingAnchor.constraint(equalTo: userPlaceTF.leadingAnchor, constant: 0),
            locationSearchView.trailingAnchor.constraint(equalTo: userPlaceTF.trailingAnchor, constant: -0),
            locationSearchView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
}

