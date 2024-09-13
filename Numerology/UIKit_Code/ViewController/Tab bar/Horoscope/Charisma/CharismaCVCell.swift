//

//  Numerology
//
//  Created by Serj_M1Pro on 16.08.2024.
//

import UIKit

class CharismaCVCell: UICollectionViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    
    private var timer = Timer()
    // MARK: image
    lazy var signImage: UIImageView = {
        let size: CGFloat = 150
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: size).isActive = true
        iv.widthAnchor.constraint(equalToConstant: size).isActive = true
        iv.contentMode = .scaleToFill
        // Style
        iv.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.2156862745, alpha: 0.6999999881)
        // Border
        iv.layer.cornerRadius = size/2
        iv.layer.borderWidth = DesignSystem.borderWidth
        iv.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        iv.layer.shadowOpacity = 1
        iv.layer.shadowRadius = 20
        iv.layer.shadowOffset = CGSize(width: 0, height: 4)
        iv.layer.shadowColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
        return iv
    }()
    
    @objc private func animate(_ sender: Timer) {
        let duration = sender.timeInterval/2
        
        let isOnState = self.signImage.layer.shadowOpacity == 1
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            //
            self.signImage.layer.shadowOpacity = isOnState ? 0.2 : 1
            //
            let colorOff = self.signImage.layer.borderColor?.copy(alpha: 0)
            let colorOn = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).cgColor
            self.signImage.layer.borderColor = isOnState ? colorOff : colorOn
        }
    }

    
    lazy var charismaButton: CapsuleButton = {
        let b = CapsuleButton()
        b.heightAnchor.constraint(equalToConstant: 24).isActive = true
        b.widthAnchor.constraint(equalToConstant: 110).isActive = true
        b.title.font = UIFont.setSourceSerifPro(weight: .semiBold, size: 9)
        b.isUserInteractionEnabled = false
        b.activityIndicatorView.startAnimating()
        return b
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setup
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configure(signDates: String?, setImage: UIImage?) {
        charismaButton.title.text = "Charisma \(signDates ?? "")"
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.signImage.image = setImage
        }
        charismaButton.activityIndicatorView.stopAnimating()
    }
    
    
    // MARK: Set up Stack
    private func setupStack() {

        let contentStack = UIStackView(arrangedSubviews: [signImage,charismaButton])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .center
        contentStack.distribution = .fill
        contentStack.spacing = 16
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
}
