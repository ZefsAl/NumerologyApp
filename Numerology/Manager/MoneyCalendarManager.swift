//

//  Numerology
//
//  Created by Serj_M1Pro on 14.07.2024.
//

import Foundation



final class MoneyCalendarManager {
    
    static let shared: MoneyCalendarManager = MoneyCalendarManager()
    
    var monthCalendarModel: MonthCalendarModel? = nil {
        didSet {
            guard let model = monthCalendarModel else { return }
            self.positive = model.goodDays.components(separatedBy: ",").compactMap { Int($0) }
            self.negative = model.badDays.components(separatedBy: ",").compactMap { Int($0) }
        }
    }
    
    lazy var positive = [Int]()
    lazy var negative = [Int]()
}
