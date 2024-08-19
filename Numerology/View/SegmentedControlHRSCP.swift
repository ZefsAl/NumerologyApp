//
//  HRSCP_SegmentedControl.swift
//  Numerology
//
//  Created by Serj_M1Pro on 09.08.2024.
//

import UIKit


protocol SegmentedControlCustomDelegate {
    func currentSegment(index: Int)
}

class SegmentedControlHRSCP: UISegmentedControl {
    
    var customDelegate: SegmentedControlCustomDelegate? = nil
    
    private let segmentInset: CGFloat = 5
    
    override init(items: [Any]?) {
        super.init(items: items)
        // Style
        self.selectedSegmentIndex = 0
        self.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1).withAlphaComponent(0.15)
        let font = UIFont(weight: .semiBold, size: 11)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        fixBackgroundSegmentControl(self)
        
        // Fill Data
        guard let items = items?.enumerated() else { return }
        for (key,item) in items {
            guard let item = item as? String else { return }
            self.setTitle(item, forSegmentAt: key)
        }
        // Target
        self.addTarget(Any.self, action: #selector(segmentAct), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func segmentAct(_ sender: UISegmentedControl) {
        self.customDelegate?.currentSegment(index: sender.selectedSegmentIndex)
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 11
        
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            let color = #colorLiteral(red: 0.5333333333, green: 0.5254901961, blue: 1, alpha: 1)
            foregroundImageView.image = UIImage(color: color)
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")    //this removes the weird scaling animation!
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = 10
        }
    }
    
    func fixBackgroundSegmentControl( _ segmentControl: UISegmentedControl){
        if #available(iOS 13.0, *) {
            //just to be sure it is full loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(segmentControl.numberOfSegments-1)  {
                    let backgroundSegmentView = segmentControl.subviews[i]
                    //it is not enogh changing the background color. It has some kind of shadow layer
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
}
