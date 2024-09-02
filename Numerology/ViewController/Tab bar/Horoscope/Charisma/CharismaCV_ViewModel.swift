//

//  Numerology
//
//  Created by Serj_M1Pro on 19.08.2024.
//

import Foundation



class CharismaCVViewModel {
    
    
    init(signsModel: SignsModel) {
        self.setSignModel(signsModel)
    }
    
    var chartsDataSource = [ChartCVCellModel]()
    
    // MARK: - Today
    func setSignModel(_ model: SignsModel) {
//        let model = YourHoroscopeManager.shared.todayHoroscope
        let valArr = model.charts?.replacingOccurrences(of: ".", with: ",").components(separatedBy: ",").compactMap({Int($0)})
        
        self.chartsDataSource = [
            ChartCVCellModel(
                title: "Sign characteristics",
                text: model.signCharacteristics ?? "",
                percentTitle: "\(valArr?[0] ?? 99)",
                progressValue: valArr?[0] ?? 99,
                progressColor: DesignSystem.ProgressBarTitnt.clear
            ),
            ChartCVCellModel(
                title: "Sign element",
                text: model.friendship ?? "",
                percentTitle: "\(valArr?[1] ?? 99 )",
                progressValue: valArr?[1] ?? 99,
                progressColor: DesignSystem.ProgressBarTitnt.cyan
            ),
            ChartCVCellModel(
                title: "Love-Family",
                text: model.intimacy ?? "",
                percentTitle: "\(valArr?[2] ?? 99 )",
                progressValue: valArr?[2] ?? 99,
                progressColor: DesignSystem.ProgressBarTitnt.red
            ),
            ChartCVCellModel(
                title: "Health",
                text: model.family ?? "",
                percentTitle: "\(valArr?[3] ?? 99)",
                progressValue: valArr?[3] ?? 99,
                progressColor: DesignSystem.ProgressBarTitnt.green
            ),
            ChartCVCellModel(
                title: "Careers",
                text: model.work ?? "",
                percentTitle: "\(valArr?[4] ?? 99)",
                progressValue: valArr?[4] ?? 99,
                progressColor: DesignSystem.ProgressBarTitnt.purple
            ),
        ]
    }
    
    
}

