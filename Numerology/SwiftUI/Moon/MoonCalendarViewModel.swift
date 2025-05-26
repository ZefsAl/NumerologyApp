//

//  Numerology
//
//  Created by Serj_M1Pro on 11.05.2024.
//

import Foundation
import EKAstrologyCalc
import CoreLocation


final class MoonCalendarViewModel: ObservableObject {
    func getAfternoonMoonDay() -> Int {
            let info = moonPhaseManager.getInfo(date: Date())
             let result = info.moonModels.max { $0.age < $1.age }?.age // fixed!
            print("🌕🌚 Afternoon is day is",result as Any)
            print("Current Date",Date())
            return result ?? 1
        }
    
    // Displaying information
    @Published var moonPhaseImage: String = "emptyImage"
    //
    @Published var previousMoonPhaseImage: String = "" // for switch animation
    // Moon
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
    @Published var nextSetTime: String? = ""
    @Published var nextSet: String? = ""
    //
    @Published var currentCalendarDate: Date? = Date()
    // First Accordion
    @Published var firstAccordionTitle: String = "Trends"
    @Published var firstInfo: String = ""
    // Second Accordion
    @Published var secondAccordionTitle: String = ""
    @Published var secondInfo: String = ""
    // Chips
    @Published var currentChips: String = "Meaning"
    
    @Published var moonModels: [EKMoonModel] = []
    private var moonPhaseModels: [MoonPhaseModel] = []
    var currentModel: MoonPhaseModel? = nil
    
    
    let chipsDataModels: [ChipsModel] = [
        ChipsModel(title: "Meaning", iconName: "book.fill", HEX: "BAFD5A"),
        ChipsModel(title: "Home", iconName: "house.fill", HEX: "FFEE3B"),
        ChipsModel(title: "Love", iconName: "heart.fill", HEX: "FF3B9A"),
        ChipsModel(title: "Health", iconName: "cross.fill", HEX: "3BFF70"),
        ChipsModel(title: "Money", iconName: "banknote.fill", HEX: "4CAF50"),
        ChipsModel(title: "Relationships", iconName: "person.line.dotted.person.fill", HEX: "FF8C3B"),
        ChipsModel(title: "Haircut", iconName: "scissors", HEX: "FFD700"),
        ChipsModel(title: "Marriage", iconName: "figure.2.and.child.holdinghands", HEX: "A56EFF"),
        ChipsModel(title: "Birthday", iconName: "calendar", HEX: "FF69B4"),
        ChipsModel(title: "Advice", iconName: "lightbulb.fill", HEX: "FFE74C"),
        ChipsModel(title: "Warnings", iconName: "exclamationmark.triangle.fill", HEX: "FF4C4C"),
        ChipsModel(title: "Dreams", iconName: "sparkles", HEX: "B36BFF"),
        ChipsModel(title: "Travel", iconName: "airplane", HEX: "00A3E0"),
    ]
    
    // MARK: - init
    init() {
        let serialQueue = DispatchQueue(label: "serialQueue")
        let group = DispatchGroup()
        // 1
        serialQueue.async{
            group.enter()
            self.getAllMoonPhases() { bool in
                if bool { group.leave() }
            }
        }
        // 2
        serialQueue.async {
            group.wait()
            group.enter()
            DispatchQueue.main.async {
                self.setMoonPhaseData()
            }
            group.leave()
        }
    }
    
    // MARK: - get All Moon Phases
    private func getAllMoonPhases(handler: @escaping (Bool) -> Void) {
        MoonPhasesManager.shared.getAllMoonPhases { array in
            self.moonPhaseModels = array
            handler(true)
        }
    }
    // MARK: - get Moon Phase Model
    private func getMoonPhaseModel(_ currentMoonDay: Int?) async -> MoonPhaseModel {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                
                guard !self.moonPhaseModels.isEmpty,
                      let currentMoonDay = currentMoonDay
                else { return }
                
                let model = self.moonPhaseModels.filter { model in
                    model.moonDay == currentMoonDay
                }.first
                
                guard let model else { return }
                
                continuation.resume(returning: model)
            }
        }
    }
    
    // MARK: - moon Phase Manager
    lazy var moonPhaseManager: EKAstrologyCalc = EKAstrologyCalc(
        location: CLLocation(latitude: 43.000000, longitude: -75.000000)
    )
    
    // MARK: - set Moon Phase Data
    func setMoonPhaseData() {
        
        guard let currentSelectedDate = self.currentCalendarDate else { return }
        
        let date = Date.makeDate(
            year: String(currentSelectedDate.get(.year)),
            month: String(currentSelectedDate.get(.month)),
            day: String(currentSelectedDate.get(.day))
        )
        
        let info = moonPhaseManager.getInfo(date: date)
        
        self.moonModels = info.moonModels
        
        let firstModel = info.moonModels.first
        let lastModel = info.moonModels.last
        
        // moon Day
        Task {
            let currentMoonDay = info.moonModels.last?.age
            let model = await self.getMoonPhaseModel(currentMoonDay)
            self.currentModel = model
            await MainActor.run {
                self.firstInfo = model.todayInfo
                self.switchChips(model: model)
            }
        }
        
        // First Model
        guard
            let firstModel = firstModel,
            let moonRise = firstModel.begin,
            let moonSet = firstModel.finish
        else { return }
        
        // Moon image
        self.moonPhaseImage = info.phase.rawValue
        
        // 1.
        self.moonRise = "\(moonRise.get(.month)) / \(moonRise.get(.day))"
        self.moonRiseTime = makeTimeString(date: moonRise, AMPM: false).replacingOccurrences(of: " ", with: "")
        // 2.
        self.moonSet = "\(moonSet.get(.month)) / \(moonSet.get(.day))"
        self.moonSetTime = makeTimeString(date: moonSet, AMPM: false).replacingOccurrences(of: " ", with: "")
        
        // Sign
        self.moonSign = firstModel.sign.rawValue.capitalized
        
        self.moonSignImage = firstModel.sign.rawValue.lowercased().replacingOccurrences(of: " ", with: "")
        
        self.phase = info.phase.rawValue.camelCaseToWords()
        
        switch info.trajectory {
        case .ascendent:
            self.trajectoryImage = "Arrow.Up"
            self.trajectory = "Ascendent"
        case .descendent:
            self.trajectoryImage = "Arrow.Down"
            self.trajectory = "Descendent"
        }
        
        // Last Model
        if let lastModel,
           let nextSetDate = lastModel.finish {
            self.nextSet = "\(nextSetDate.get(.month)) / \(nextSetDate.get(.day))"
            self.nextSetTime = makeTimeString(date: nextSetDate, AMPM: false).replacingOccurrences(of: " ", with: "")
        }
    }
    
    // MARK: - switch Chips
    func switchChips(model: MoonPhaseModel) {
        
        self.secondAccordionTitle = self.currentChips
        
        switch self.currentChips.lowercased().replacingOccurrences(of: " ", with: "") {
            case "meaning":
            self.secondInfo = model.meaning ?? ""
            case "love":
            self.secondInfo = model.love ?? ""
            case "home":
            self.secondInfo = model.home ?? ""
            case "health":
            self.secondInfo = model.health ?? ""
            case "money":
            self.secondInfo = model.money ?? ""
            case "relationships":
            self.secondInfo = model.relationships ?? ""
            case "haircut":
            self.secondInfo = model.haircut ?? ""
            case "marriage":
            self.secondInfo = model.marriage ?? ""
            case "birthday":
            self.secondInfo = model.birthday ?? ""
            case "advice":
            self.secondInfo = model.advice ?? ""
            case "warnings":
            self.secondInfo = model.warnings ?? ""
            case "dreams":
            self.secondInfo = model.dreams ?? ""
            case "moonphase":
            self.secondInfo = model.moonPhase ?? ""
        default:
            break
        }
    }
    
    
    // MARK: - TEST
    func calculateMoon() {
        guard let currentSelectedDate = self.currentCalendarDate else { return }
        let date = Date.makeDate(
            year: String(currentSelectedDate.get(.year)),
            month: String(currentSelectedDate.get(.month)),
            day: String(currentSelectedDate.get(.day))
        )
        
        print("⚠️ currentSelectedDate?", date)
        
        let info = moonPhaseManager.getInfo(date: date)
        
        print("Current localtion: -", info.location.coordinate)
        
        print("Moon days at", "current date: -", info.date)
        info.moonModels.forEach {
            print("🔵===========🔵")
            print("Moon Age: -", $0.age)
            if let begin = $0.begin, let finish = $0.finish {
                let format = "yyyy-MM-dd'T'HH:mm:ssZ"
                print("Moon rise: -", setDateFormat(date: begin, format: format))
                print("Moon set: -", setDateFormat(date: finish, format: format))
            }
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
        makeDate(strDate: "2024-01-18 18:06:46 +0000")
    }()!
    
    
    private func makeDate(strDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure a specific locale for consistent formatting
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: strDate)
    }
}


