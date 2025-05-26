//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 28.08.2024.
//

import UIKit

class TopImage: UIView {
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
    init(frame: CGRect = .zero, tint: UIColor, referenceView: UIView?) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
        
        DS.setCardStyle(to: self, tintColor: tint, cornerRadius: DS.maxCornerRadius)
        self.imageView.layer.cornerRadius = DS.maxCornerRadius
        
        self.addSubview(imageView)
        //
        guard let referenceView = referenceView else { return }
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: DeviceMenager.isSmallDevice ? 228 : 245),
            self.widthAnchor.constraint(equalToConstant: referenceView.bounds.width-36),
            //
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
