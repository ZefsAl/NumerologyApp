//

//  Numerology
//
//  Created by Serj_M1Pro on 11.05.2024.
//

import Foundation
import EKAstrologyCalc
import CoreLocation


final class MoonCalendarManager: ObservableObject {
    
//    @Published var
    
//    moonPhase
//    
    // Displaying information
    
    @Published var moonPhaseImage: String = ""
    
    @Published var moonAge: String = ""
    @Published var moonSign: String = ""
    @Published var moonSignImage: String = ""
    //
    @Published var phase: String = ""
    @Published var trajectory: String = ""
    @Published var trajectoryImage: String = ""
    //Rise
    @Published var moonRise: String = ""
    @Published var moonRiseTime: String = ""
    // Set
    @Published var moonSet: String = ""
    @Published var moonSetTime: String = ""
    // Next
    @Published var previousAge: String? = ""
    @Published var previousRiseTime: String? = ""
    @Published var previousRise: String? = ""
    
    

    
    
    //
    @Published var currentSelectedDate: Date? = Date()
//    var moonModels: [EKMoonModel] = []
    
    

    let location = CLLocation(latitude: 43.000000, longitude: -75.000000) // NY
    lazy var moonPhaseManager: EKAstrologyCalc = EKAstrologyCalc(location: location)
    
    func getAfternoonMoonDay() -> Int {
        let info = moonPhaseManager.getInfo(date: Date())
         let result = info.moonModels.max { $0.age < $1.age }?.age // fixed!
        print("🌕🌚 Afternoon is day is",result as Any)
        print("Current Date",Date())
        return result ?? 1
    }
    
    
    func getMinModel() {
        guard let date = self.currentSelectedDate else { return }
        
        let info = moonPhaseManager.getInfo(date: date)
        //
        let minModel = info.moonModels.min { $0.age < $1.age }
        let maxModel = info.moonModels.max { $0.age < $1.age }
        guard let maxModel = maxModel else { return }
        
        guard
        let moonRise = maxModel.begin,
        let moonSet = maxModel.finish
        else { return }
        
//        self.setMoonPhaseImage(phase: info.phase)
        self.moonPhaseImage = info.phase.rawValue
        // max Model
        self.moonAge = String(maxModel.age)
        // date
        self.moonRise = "\(moonRise.get(.month)) / \(moonRise.get(.day))"
        self.moonRiseTime = makeTimeString(date: moonRise, AMPM: false).replacingOccurrences(of: " ", with: "")
        
        self.moonSet = "\(moonSet.get(.month)) / \(moonSet.get(.day))"
        self.moonSetTime = makeTimeString(date: moonSet, AMPM: false).replacingOccurrences(of: " ", with: "")
        
        // Sign
        self.moonSign = maxModel.sign.rawValue.capitalized
        self.moonSignImage = maxModel.sign.rawValue.lowercased().replacingOccurrences(of: " ", with: "")
        //
        self.phase = info.phase.rawValue.camelCaseToWords()
        
        switch info.trajectory {
        case .ascendent:
            self.trajectoryImage = "Arrow.Up"
            self.trajectory = "Ascendent"
        case .descendent:
            self.trajectoryImage = "Arrow.Down"
            self.trajectory = "Descendent"
        }

        // min Model
        if let minModel,
           let previousRise = minModel.begin {
            self.previousAge = String(minModel.age)
            self.previousRise = "\(previousRise.get(.month)) / \(previousRise.get(.day))"
            self.previousRiseTime = makeTimeString(date: previousRise, AMPM: false).replacingOccurrences(of: " ", with: "")
        }
    }
    

    func calculateMoon() {
        guard let date = self.currentSelectedDate else { return }

        moonPhaseManager = EKAstrologyCalc(location: location)

        let info = moonPhaseManager.getInfo(date: date)
        

        print("Current localtion: -", info.location.coordinate)

        print("Moon days at", "current date: -", info.date)
        info.moonModels.forEach {
            print("🔵===========🔵")
            print("Moon Age: -", $0.age)
            print("Moon rise: -", $0.begin)
            print("Moon set: -", $0.finish)
            print("Moon sign: -", $0.sign)
        }
        print("+++++++++++")
        print("Moon phase: -", info.phase)
        print("Moon trajectory: -", info.trajectory)
        print("⚠️ Moon date: -", info.date)
        print("⚠️ moon Models: -", info.moonModels)
        
        print("⚠️⚠️⚠️ mock Date", mockDate)
    }
    
    
    lazy var mockDate: Date = {
        makeDate(strDate: "2024-11-19 18:06:46 +0000")
    }()!
    
    
    func makeDate(strDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure a specific locale for consistent formatting
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: strDate)
    }
    
    func makeStringDay(strDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: strDate)?.day
    }
}


