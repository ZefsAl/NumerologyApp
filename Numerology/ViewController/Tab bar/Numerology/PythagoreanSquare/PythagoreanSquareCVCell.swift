//

//  Numerology
//
//  Created by Serj_M1Pro on 22.05.2024.
//

import UIKit

class PythagoreanSquareCVCell: UICollectionViewCell {
 
    let cardCollectionID = "cardCollectionID"
    
    let content = PythagoreanSquareView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setup
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set up Stack
    private func setupStack() {
        self.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            content.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            content.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            content.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
}
