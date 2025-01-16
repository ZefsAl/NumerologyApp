//
//  ChartCVCellModel.swift
//  Numerology
//
//  Created by Serj_M1Pro on 19.08.2024.
//

import Foundation
import UIKit

struct ChartCVCellModel {
    let title: String
    let text: String
    let text2: String?
    let percentTitle: String
    let progressValue: Int
    let progressColor: UIColor
    
    init(title: String, text: String, text2: String? = nil, percentTitle: String, progressValue: Int, progressColor: UIColor) {
        self.title = title
        self.text = text
        self.text2 = text2
        self.percentTitle = percentTitle
        self.progressValue = progressValue
        self.progressColor = progressColor
    }
}
