//

//  Numerology
//
//  Created by Serj_M1Pro on 21.08.2024.
//

import UIKit

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    private var capsuleShape: Bool = false
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    convenience init(capsuleShape: Bool) {
        self.init()
        self.capsuleShape = capsuleShape
    }
    
    override func layoutSubviews() {
        guard capsuleShape else { return }
        self.layer.cornerRadius = self.bounds.height/2
    }
    
}
