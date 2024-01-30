//
//  RegionOfbirth.swift
//  Numerology
//
//  Created by Serj on 25.01.2024.
//

import UIKit
import AVFoundation


class RegionOfbirthVC: UIViewController {
    
    let locationSearchVC = LocationSearchVC()
    
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
    
    
    // MARK: Name Field
    private let userPlaceTF: CustomTF = {
        let tf = CustomTF(frame: .null, setPlaceholder: "City of birth*")
        return tf
    }()
    
    
    // MARK: user Time Of Birth
    private let userTimeOfBirth: CustomTF = {
        let tf = CustomTF(frame: .null, setPlaceholder: "Time of birth")
        tf.textAlignment = .center
        tf.rightViewMode = .never
        tf.leftViewMode = .never
        
        // MARK: Date Picker
        let datePicker: UIDatePicker = {
            let dp = UIDatePicker()
            dp.datePickerMode = .time
            dp.preferredDatePickerStyle = .wheels
            dp.addTarget(Any?.self, action: #selector(timeOfBirthAct), for: .valueChanged)
            return dp
        }()
        tf.inputView = datePicker
        
        return tf
    }()
    @objc func timeOfBirthAct(_ sender: UIDatePicker) {
        userTimeOfBirth.text = setTimeFormat(date: sender.date)
    }
    
    private func playVideo() {
        let ref = "planet"
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        guard let path = Bundle.main.path(forResource: ref, ofType: "mp4") else { return }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.borderColor = UIColor.white.cgColor
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
    func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    // MARK: View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegate
        self.userPlaceTF.additionalActionDelegate = self
        self.locationSearchVC.locationValueDelegate = self
        // Visual
        self.setBackground(named: "RegionBG.png")
        AnimatableBG().setBackground(vc: self)
        playVideo()
        // Config
        setUpStack()
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
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // titles Stack
        let titlesStack = UIStackView(arrangedSubviews: [largeTitle,subtitle])
        titlesStack.axis = .vertical
        titlesStack.alignment = .fill
        titlesStack.spacing = 16
        
        // name Field Stack
        let nameFieldStack = UIStackView(arrangedSubviews: [userPlaceTF,userTimeOfBirth])
        nameFieldStack.axis = .vertical
        nameFieldStack.alignment = .fill
        nameFieldStack.spacing = 32
        
        // Fields Stack
        let fieldsStack = UIStackView(arrangedSubviews: [titlesStack,nameFieldStack])
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 32
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [fieldsStack,UIView(),nextButton])
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

extension RegionOfbirthVC: AdditionalActionDelegate, LocationValueDelegate  {
    // LocationValueDelegate
    func getLocationString(value: String) {
        print("⚠️", value)
        userPlaceTF.text = value
    }
    
    // AdditionalActionDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.inputAccessoryView = nil
        textField.inputView = UIView()
        
        let navVC = UINavigationController(rootViewController: self.locationSearchVC)
        navVC.modalPresentationStyle = .popover
        self.present(navVC, animated: true)
    }
}

