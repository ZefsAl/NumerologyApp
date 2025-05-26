//

//  Numerology
//
//  Created by Serj_M1Pro on 12.08.2024.
//

import Foundation
import UIKit

class HoroscopeCellViewModel {
    
    var chartsDataSource = [ChartCVCellModel]()
    
    // MARK: - Today
    func setTodayData() {
        let model = YourHoroscopeManager.shared.todayHoroscope
        let valArr = model?.charts?.replacingOccurrences(of: ".", with: ",").components(separatedBy: ",").compactMap({Int($0)})
        
        self.chartsDataSource = [
            ChartCVCellModel(
                title: "Social",
                text: model?.social ?? "",
                percentTitle: "\(valArr?[0] ?? 99)",
                progressValue: valArr?[0] ?? 99,
                progressColor: DS.ProgressBarTitnt.yellow
            ),
            ChartCVCellModel(
                title: "Business",
                text: model?.business ?? "",
                percentTitle: "\(valArr?[1] ?? 99 )",
                progressValue: valArr?[1] ?? 99,
                progressColor: DS.ProgressBarTitnt.purple
            ),
            ChartCVCellModel(
                title: "Friendship",
                text: model?.friendship ?? "",
                percentTitle: "\(valArr?[2] ?? 99 )",
                progressValue: valArr?[2] ?? 99,
                progressColor: DS.ProgressBarTitnt.cyan
            ),
            ChartCVCellModel(
                title: "Love",
                text: model?.love ?? "",
                percentTitle: "\(valArr?[3] ?? 99)",
                progressValue: valArr?[3] ?? 99,
                progressColor: DS.ProgressBarTitnt.pink
            ),
            ChartCVCellModel(
                title: "Health",
                text: model?.health ?? "",
                percentTitle: "\(valArr?[4] ?? 99)",
                progressValue: valArr?[4] ?? 99,
                progressColor: DS.ProgressBarTitnt.green
            ),
            ChartCVCellModel(
                title: "Intimacy",
                text: model?.sex ?? "",
                percentTitle: "\(valArr?[5] ?? 99)",
                progressValue: valArr?[5] ?? 99,
                progressColor: DS.ProgressBarTitnt.red
            ),
        ]

    }
    
    // MARK: - Tomorrow
    func setTomorrowData() {
        let model = YourHoroscopeManager.shared.tomorrowHoroscope
        let valArr = model?.charts?.replacingOccurrences(of: ".", with: ",").components(separatedBy: ",").compactMap({Int($0)})
        
        self.chartsDataSource = [
            ChartCVCellModel(
                title: "Social",
                text: model?.social ?? "",
                percentTitle: "\(valArr?[0] ?? 99)",
                progressValue: valArr?[0] ?? 99,
                progressColor: DS.ProgressBarTitnt.yellow
            ),
            ChartCVCellModel(
                title: "Business",
                text: model?.business ?? "" ,
                percentTitle: "\(valArr?[1] ?? 99 )",
                progressValue: valArr?[1] ?? 99,
                progressColor: DS.ProgressBarTitnt.purple
            ),
            ChartCVCellModel(
                title: "Friendship",
                text: model?.friendship ?? ""   ,
                percentTitle: "\(valArr?[2] ?? 99 )",
                progressValue: valArr?[2] ?? 99,
                progressColor: DS.ProgressBarTitnt.cyan
            ),
            ChartCVCellModel(
                title: "Love",
                text: model?.love ?? ""     ,
                percentTitle: "\(valArr?[3] ?? 99)",
                progressValue: valArr?[3] ?? 99,
                progressColor: DS.ProgressBarTitnt.pink
            ),
            ChartCVCellModel(
                title: "Health",
                text: model?.health ?? ""       ,
                percentTitle: "\(valArr?[4] ?? 99)",
                progressValue: valArr?[4] ?? 99,
                progressColor: DS.ProgressBarTitnt.green
            ),
            ChartCVCellModel(
                title: "Intimacy",
                text: model?.sex ?? ""       ,
                percentTitle: "\(valArr?[5] ?? 99)",
                progressValue: valArr?[5] ?? 99,
                progressColor: DS.ProgressBarTitnt.red
            ),
        ]

    }
    
    // MARK: - Week
    func setWeekData() {
        
        let model = YourHoroscopeManager.shared.weekHoroscope
        let valArr = model?.charts?.components(separatedBy: ",").compactMap({Int($0)})
        let text2 = model?.info
        
        self.chartsDataSource = [
            ChartCVCellModel(
                title: "Love",
                text: model?.love ?? "",
                text2: text2,
                percentTitle: "\(valArr?[0] ?? 99)",
                progressValue: valArr?[0] ?? 99,
                progressColor: DS.ProgressBarTitnt.pink
            ),
            ChartCVCellModel(
                title: "Business",
                text: model?.business ?? "",
                text2: text2,
                percentTitle: "\(valArr?[1] ?? 99 )",
                progressValue: valArr?[1] ?? 99,
                progressColor: DS.ProgressBarTitnt.purple
            ),
            ChartCVCellModel(
                title: "Health",
                text: model?.health ?? "",
                text2: text2,
                percentTitle: "\(valArr?[2] ?? 99 )",
                progressValue: valArr?[2] ?? 99,
                progressColor: DS.ProgressBarTitnt.green
            ),
            ChartCVCellModel(
                title: "Intimacy",
                text: model?.sex ?? "",
                text2: text2,
                percentTitle: "\(valArr?[3] ?? 99)",
                progressValue: valArr?[3] ?? 99,
                progressColor: DS.ProgressBarTitnt.red
            ),
        ]
    }
    
    // MARK: - Month
    func setMonthData() {
        
        let model = YourHoroscopeManager.shared.monthHoroscope
        let valArr = model?.charts?.components(separatedBy: ",").compactMap({Int($0)})
        let text = model?.monthInfo
        let text2 = model?.mainTrends
        
        self.chartsDataSource = [
            ChartCVCellModel(
                title: "Social",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[0] ?? 99)",
                progressValue: valArr?[0] ?? 99,
                progressColor: DS.ProgressBarTitnt.yellow
            ),
            ChartCVCellModel(
                title: "Business",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[1] ?? 99 )",
                progressValue: valArr?[1] ?? 99,
                progressColor: DS.ProgressBarTitnt.purple
            ),
            ChartCVCellModel(
                title: "Friendship",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[2] ?? 99 )",
                progressValue: valArr?[2] ?? 99,
                progressColor: DS.ProgressBarTitnt.cyan
            ),
            ChartCVCellModel(
                title: "Love",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[3] ?? 99)",
                progressValue: valArr?[3] ?? 99,
                progressColor: DS.ProgressBarTitnt.pink
            ),
            ChartCVCellModel(
                title: "Health",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[4] ?? 99)",
                progressValue: valArr?[4] ?? 99,
                progressColor: DS.ProgressBarTitnt.green
            ),
            ChartCVCellModel(
                title: "Intimacy",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[5] ?? 99)",
                progressValue: valArr?[5] ?? 99,
                progressColor: DS.ProgressBarTitnt.red
            ),
        ]
    }
    
    // MARK: - Year
    func setYearData() {
        
        let model = YourHoroscopeManager.shared.year2024Horoscope
        let valArr = model?.charts?.components(separatedBy: ",").compactMap({Int($0)})
        let text = model?.yourHoroscope
        let text2 = model?.mainTrends
        
        self.chartsDataSource = [
            ChartCVCellModel(
                title: "Social",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[0] ?? 99)",
                progressValue: valArr?[0] ?? 99,
                progressColor: DS.ProgressBarTitnt.yellow
            ),
            ChartCVCellModel(
                title: "Business",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[1] ?? 99 )",
                progressValue: valArr?[1] ?? 99,
                progressColor: DS.ProgressBarTitnt.purple
            ),
            ChartCVCellModel(
                title: "Friendship",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[2] ?? 99 )",
                progressValue: valArr?[2] ?? 99,
                progressColor: DS.ProgressBarTitnt.cyan
            ),
            ChartCVCellModel(
                title: "Love",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[3] ?? 99)",
                progressValue: valArr?[3] ?? 99,
                progressColor: DS.ProgressBarTitnt.pink
            ),
            ChartCVCellModel(
                title: "Health",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[4] ?? 99)",
                progressValue: valArr?[4] ?? 99,
                progressColor: DS.ProgressBarTitnt.green
            ),
            ChartCVCellModel(
                title: "Intimacy",
                text: text ?? "",
                text2: text2,
                percentTitle: "\(valArr?[5] ?? 99)",
                progressValue: valArr?[5] ?? 99,
                progressColor: DS.ProgressBarTitnt.red
            ),
        ]
    }
    
    
    
}
