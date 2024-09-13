//
//  NumerologyImagesManager.swift
//  Numerology
//
//  Created by Serj_M1Pro on 28.08.2024.
//

import UIKit


class NumerologyImagesManager {
    
    static let shared: NumerologyImagesManager = NumerologyImagesManager()
    
    var numerologyImages: [String:UIImage?]? {
        didSet {
            NotificationCenter.default.post(name: .numerologyImagesDataUpdated, object: nil)
//            print("🟣1 numerologyImagesDataUpdated - Notification yourHrscpImages =", numerologyImages?.count as Any)
        }
    }
    
    var angelNumbersImages: [String:UIImage?]? {
        didSet {
            NotificationCenter.default.post(name: .angelNumbersImagesDataUpdated, object: nil)
//            print("🟣2 angelNumbersImagesDataUpdated - Notification angelNumbersImages =", angelNumbersImages?.count as Any)
        }
    }
    
    
    func requestData() {
        // Numerology Images
        DispatchQueue.main.async {
            TechnicalManager.shared.getTechnicalImages(withKey: TechnicalTableKeys.numerologyImages) { dict in
                self.numerologyImages = dict
            }
        }
        // Angel Numbers Images
        DispatchQueue.main.async {
            TechnicalManager.shared.getTechnicalImages(withKey: TechnicalTableKeys.angelNumbersImages) { dict in
                self.angelNumbersImages = dict
            }
        }
    }
    
    func setTopImage(_ topImage: TopImage, key: NumerologyImagesKeys) {
        if let images = self.numerologyImages,
           let image = images[key.rawValue] {
            // Set top Image
            topImage.fadeTransition()
            topImage.image = image
        }
    }
    
    func setAngelsTopImage(_ topImage: TopImage, key: String) {
        if let images = self.angelNumbersImages,
           let image = images[key] {
            // Set top Image
             topImage.fadeTransition(0.1) 
            topImage.image = image
        }
    }

    
}
