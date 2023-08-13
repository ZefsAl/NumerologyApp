//
//  CalculateNumbers.swift
//  Numerology
//
//  Created by Serj on 28.07.2023.
//

import Foundation
import UIKit

class CalculateNumbers {
    
    // MARK: Numerology Month
    func getNumerologyMonth(monthInt: Int) -> Int {
        
            var monthArr: [String] = {
                let df = DateFormatter()
                let month = df.standaloneMonthSymbols
                var arr: [String] = month ?? ["error"]
                return arr
            }()
        
            let enteredMonthStr = monthArr[monthInt-1]
        
            // Find the number of month
            let monthsNumerology: [Int: [String]] = {
               let c = [
                1  : ["January","October"],
                2  : ["February","November"],
                3  : ["March","December"],
                4  : ["April"],
                5  : ["May"],
                6  : ["June"],
                7  : ["July"],
                8  : ["August"],
                9  : ["September"],
               ]
                 return c
            }()
        
        
            var receivedKey: Int = 0
        
            // receive key
            for (key, value) in monthsNumerology {
                if value.contains(enteredMonthStr) {
                    receivedKey = key
                }
            }
        
        return receivedKey
    }
 
    // MARK: Soul // 1
    func calculateNumberOfSoul(date: Date?) -> Int {
        
        let calendar = Calendar.current
        
        guard let date = date else { return 1 }
        
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let day = components.day ?? 0
    
        var arrDayNum = [Int]()
        
        let stringDay = String(day)

        // String -> Int append
        for char in stringDay {
            if let num = char.wholeNumberValue {
                arrDayNum.append(num)
            }
        }

        let sumArr = arrDayNum.reduce(0) { partialResult, num in
            partialResult + num
        }
        print("Soul = \(sumArr)")
        
        if sumArr == 10 {
            return 1
        } else if sumArr == 0 {
            return 1
        } else {
            return sumArr
        }
    }
    
    // MARK: Destiny // 2
    func calculateNumberOfDestiny(date: Date?) -> Int {
        
        guard let date = date else { return 1 }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let day = components.day ?? 0
        let month = components.month ?? 0
        let year = components.year ?? 0
        
        var arrNumbers = [Int]()
        
        let stringDay = String(day)
        let stringMonth = String(month)
        let stringYear = String(year)
        
        for char in stringDay {
            if let num = char.wholeNumberValue {
                arrNumbers.append(num)
            }
        }
        
        for char in stringMonth {
            if let num = char.wholeNumberValue {
                arrNumbers.append(num)
            }
        }
        
        for char in stringYear {
            if let num = char.wholeNumberValue {
                arrNumbers.append(num)
            }
        }

        let sumArr = arrNumbers.reduce(0) { partialResult, num in
            partialResult + num
        }
            
        // Sum to String --- Arr sum numbers
        let strSumArr = String(sumArr)
        var numbersArrSum = [Int]() 
                
        for char in strSumArr {
            if let num = char.wholeNumberValue {
                numbersArrSum.append(num)
            }
        }
        
        let sumArrNumbers = numbersArrSum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        // Sum Result
        let strSumArrNum = String(sumArrNumbers)
        var numbersSumArr2 = [Int]()
        for char in strSumArrNum {
            if let num = char.wholeNumberValue {
                numbersSumArr2.append(num)
            }
        }
        let sumOfSum = numbersSumArr2.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        print("Destiny = \(sumOfSum)")
        
        if sumOfSum == 10 {
            return 1
        } else if sumOfSum == 0 {
            return 1
        } else {
            return sumOfSum
        }
    }
    
    
    // MARK: Name // 3
    func calculateNumberOfName(name: String, surname: String) -> Int {
        
        let numerologyAlphabet: [Int : String] = [
            1 : "AJS",
            2 : "BKT",
            3 : "CLU",
            4 : "DMV",
            5 : "ENW",
            6 : "FOX",
            7 : "GPY",
            8 : "HQZ",
            9 : "IR",
        ]
        
        var alphNumArr = [Int]()
        
        // Name
        for nameChar in name.uppercased() {
            for (key, alphValue) in numerologyAlphabet {
                
                if alphValue.contains(where: { alphChar in alphChar == nameChar }) {
                    alphNumArr.insert(key, at: 0)
    //                print(key)
                }
            }
        }
        
        // Surname
        for surnameChar in surname.uppercased() {
            for (key, alphValue) in numerologyAlphabet {
                
                if alphValue.contains(where: { alphChar in alphChar == surnameChar }) {
                    alphNumArr.insert(key, at: 0)
                    //                print(key)
                }
            }
        }
        
        
        let arrSum = alphNumArr.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        let strArrSum = String(arrSum)
        
        var numArrSum = [Int]()
        
        for char in strArrSum {
            if let num = char.wholeNumberValue {
                numArrSum.append(num)
            }
        }
        
        let sumArrSum = numArrSum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        let sumArrSumStr = String(sumArrSum)
        var arrNumSum = [Int]()
        
        for char in sumArrSumStr {
            if let num = char.wholeNumberValue {
                arrNumSum.append(num)
            }
        }
        
        let sumOfSum = arrNumSum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        print("Numerology name = \(sumOfSum)")
        
    //     End
        if sumOfSum == 10 {
            return 1
        } else if sumOfSum == 0 {
            return 1
        } else {
            return sumOfSum
        }
    }
    
    
    // MARK: Money // 4
    func calculateNumberOfMoney(name: String, date: Date?) -> Int {
        
        let numerologyAlphabet: [Int : String] = [
            1 : "AJS",
            2 : "BKT",
            3 : "CLU",
            4 : "DMV",
            5 : "ENW",
            6 : "FOX",
            7 : "GPY",
            8 : "HQZ",
            9 : "IR",
        ]
        
        var arrNumbers = [Int]()
        
        // Name
        for nameChar in name.uppercased() {
            for (key, alphValue) in numerologyAlphabet {
                if alphValue.contains(where: { alphChar in alphChar == nameChar }) {
                    arrNumbers.insert(key, at: 0)
    //                print(key)
                }
            }
        }
        
        guard let date = date else { return 1 }

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let day = components.day ?? 0
        
        let stringDay = String(day)
        
        for char in stringDay {
            if let num = char.wholeNumberValue {
                arrNumbers.append(num)
            }
        }
        
        let sumArr = arrNumbers.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        let strSumArr = String(sumArr)
        var numArrSum = [Int]()
                
        for char in strSumArr {
            if let num = char.wholeNumberValue {
                numArrSum.append(num)
            }
        }
        
        let sumOfSum = numArrSum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        print("Money = \(sumOfSum)")
        
    //     End
        if sumOfSum == 10 {
            return 1
        } else if sumOfSum == 0 {
            return 1
        } else {
            return sumOfSum
        }
    }
    
    
    // MARK: Power Code // 5
    func calculatePowerCode(codeName: Int, codeDestiny: Int) -> Int {
        
        let sumCode = codeName + codeDestiny
        
        let sumCodeStr = String(sumCode)
        
        var arrNumSum = [Int]()
        
        for char in sumCodeStr {
            if let num = char.wholeNumberValue {
                arrNumSum.append(num)
            }
        }
        
        let sumOfSum = arrNumSum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        print("Power Code = \(sumOfSum)")
    //     End
        if sumOfSum == 10 {
            return 1
        } else if sumOfSum == 0 {
            return 1
        } else {
            return sumOfSum
        }
    }
    
    // MARK: Personal Year 2.3
    func personalYear(userDate: Date?, enteredDate: Date?) -> Int {

        // UserDate(MONTH,DAY)
        guard let userDate = userDate else { return 1 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: userDate)
        let userMonth = components.month ?? 0
        let userDay = components.day ?? 0

    //    EnteredDate(YEAR)
        guard let enteredDate = enteredDate else { return 1 }
        let componentsYear = calendar.dateComponents([.year], from: enteredDate)
        let enterYear = componentsYear.year ?? 0

    //    UserDate(MONTH,DAY) + EnteredDate(YEAR) = Personal Year

        var arrNumbers = [Int]()

        let userMonthStr = String(userMonth)
        let userDayStr = String(userDay)
        let enterYearStr = String(enterYear)

        for char in userMonthStr {
            if let num = char.wholeNumberValue {
                arrNumbers.append(num)
            }
        }

        for char in userDayStr {
            if let num = char.wholeNumberValue {
                arrNumbers.append(num)
            }
        }

        for char in enterYearStr {
            if let num = char.wholeNumberValue {
                arrNumbers.append(num)
            }
        }

        let sumArrNumbers = arrNumbers.reduce(0) { partialResult, val in
            partialResult + val
        }
    //    print(arrNumbers)
    //    print(sumArrNumbers)
        // sumArrNumbers ✅

        let strSumArrNumbers = String(sumArrNumbers)
        var arrSumArrNumbers = [Int]()

        for char in strSumArrNumbers {
            if let num = char.wholeNumberValue {
                arrSumArrNumbers.append(num)
            }
        }

        let sumOfSum = arrSumArrNumbers.reduce(0) { partialResult, val in
            partialResult + val
        }
        // sumOfSum +- ✅

        print("Personal Year = \(sumOfSum)")


        if sumOfSum == 10 {
            return 1
        } else if sumOfSum == 0 {
            return 1
        } else {
            return sumOfSum
        }
    }
    
    // MARK: Personal Month 2.2
    func personalMonth(personalYear: Int, enteredDate: Date?) -> Int {
        
        // Get enteredDate (month)
        guard let enteredDate = enteredDate else { return 1 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: enteredDate)
        let enteredMonth = components.month ?? 0

        var monthArr: [String] = {
            let df = DateFormatter()
        //    df.dateFormat = "MMMM"
            let month = df.standaloneMonthSymbols
            var arr: [String] = month ?? ["error"]
            return arr
        }()
        
        let enteredMonthStr = monthArr[enteredMonth-1]
        
        // Find the number of month
        let monthsNumerology: [Int: [String]] = {
           let c = [
            1  : ["January","October"],
            2  : ["February","November"],
            3  : ["March","December"],
            4  : ["April"],
            5  : ["May"],
            6  : ["June"],
            7  : ["July"],
            8  : ["August"],
            9  : ["September"],
           ]
             return c
        }()

        
        var receivedKey: Int = 0

        // receive key
        for (key, value) in monthsNumerology {
            if value.contains(enteredMonthStr) {
                receivedKey = key
            }
        }
        
        
        let sumVal = personalYear + receivedKey

        let strSumVal = String(sumVal)
        var arrNumSum = [Int]()
        
        for char in strSumVal {
            if let num = char.wholeNumberValue {
                arrNumSum.append(num)
            }
        }
        
        let sumOfSum = arrNumSum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        print("Personal Month = \(sumOfSum)")
        
        if sumOfSum == 10 {
            return 1
        } else if sumOfSum == 0 {
            return 1
        } else {
            return sumOfSum
        }
    }
    
    
    
    // MARK: Personal Day 2.1
    func personalDay(userDate: Date?, enteredDate: Date?) -> Int {

        // UserDate(MONTH,DAY)
        guard let userDate = userDate else { return 1 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: userDate)
        let userMonth = components.month ?? 0
        let userDay = components.day ?? 0

    //    EnteredDate(DAY,MONTH,YEAR)
        guard let enteredDate = enteredDate else { return 1 }
        
            let enterComponents = calendar.dateComponents([.year, .month, .day], from: enteredDate)
            let enterDay = enterComponents.day ?? 0
            let enterMonth = enterComponents.month ?? 0
            let enterYear = enterComponents.year ?? 0

    //    UserDate(MONTH,DAY) + EnteredDate(DAY,MONTH,YEAR) = Personal Day
        var arrNumbers = [Int]()
        // To Str
        let userMonthStr = String(getNumerologyMonth(monthInt: userMonth))
        let userDayStr = String(userDay)
        // To Str
        let enterDayStr = String(enterDay)
        let enterMonthStr = String(getNumerologyMonth(monthInt: enterMonth))
        let enterYearStr = String(enterYear)

        let arrStrNumVal = [
            userMonthStr,
            userDayStr,
            enterDayStr,
            enterMonthStr,
            enterYearStr,
        ]
        
        for item in arrStrNumVal {
            for char in item {
                if let num = char.wholeNumberValue {
                    arrNumbers.append(num)
                }
            }
        }

        let sumArrNumbers = arrNumbers.reduce(0) { partialResult, num in
            partialResult + num
        }

        // To Str
        let strSumArrNum = String(sumArrNumbers)
        var numArrNum = [Int]()
        
        for char in strSumArrNum {
            if let num = char.wholeNumberValue {
                numArrNum.append(num)
            }
        }
        
        let sumNumArrNum = numArrNum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        // To Str
        let sumOfSumNum = String(sumNumArrNum)
        var arrSumOfSumNum = [Int]()
        for char in sumOfSumNum {
            if let num = char.wholeNumberValue {
                arrSumOfSumNum.append(num)
            }
        }
        let sumOfSum = arrSumOfSumNum.reduce(0) { partialResult, num in
            partialResult + num
        }
        
        
        print("Personal Day = \(sumOfSum)")
        
        if sumOfSum == 10 {
            return 1
        } else if sumOfSum == 0 {
            return 1
        } else {
            return sumOfSum
        }
    }
    
    
    // MARK: life Stages // 2.4
    func lifeStages(destiny: Int, userDate: Date) -> LifeStagesCalculatedModel {
        
        // Lifespan 🟩
        let firstStage = 36 - destiny
        let secondStage = firstStage + 9
        let thirdStage = secondStage + 9
        let fourthStage = thirdStage
        
        
        // Individual Numbers
//        guard let date = userDate else { return }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: userDate)
        let day = components.day ?? 0
        let month = components.month ?? 0
        let year = components.year ?? 0
        
        let stringDay = String(day)
        let stringMonth = String(month)
        let stringYear = String(year)
        
        //    First Individual Number == Day + Month
        let strNumbersDM = "\(stringDay)\(stringMonth)"
        
        let firstArrNum = strNumbersDM.map { char in
            char.wholeNumberValue
        }
        
        let sumFirstArrNum = firstArrNum.reduce(0) { partialResult, num in
            partialResult + (num ?? 0)
        }
        
        // To Str
        let strSumFirstArrNum = String(sumFirstArrNum)
        
        let firstSumArrSum = strSumFirstArrNum.map { char in
            char.wholeNumberValue
        }
        // First Individual Number
        let firstIndividualNumber: Int = {
            let val = firstSumArrSum.reduce(0) { partialResult, num in
                partialResult + (num ?? 0)
            }
            
            if val == 10 {
                return 1
            } else if val == 0 {
                return 1
            } else {
                return val
            }
        }()
        print("First number = \(firstIndividualNumber)")
        
        
        // Second Individual Number == DAY + YEAR
        let strNumbersDY = "\(stringDay)\(stringYear)"
        
        let secondArrNum = strNumbersDY.map { char in
            char.wholeNumberValue
        }
        
        let sumSecondArrNum = secondArrNum.reduce(0) { partialResult, num in
            partialResult + (num ?? 0)
        }
        // To Str
        let strSumSecondArrNum = String(sumSecondArrNum)
        
        let secondSumArrSum = strSumSecondArrNum.map { char in
            char.wholeNumberValue
        }
        
        let sumSecondArr2 = secondSumArrSum.reduce(0) { partialResult, num in
            partialResult + (num ?? 0)
        }
        // To Str
        let strSumSecondArr2 = String(sumSecondArr2)
        
        let secondArrOfSum2 = strSumSecondArr2.map { char in
            char.wholeNumberValue
        }
        
        let secondIndividualNumber: Int = {
            let val = secondArrOfSum2.reduce(0) { partialResult, num in
                partialResult + (num ?? 0)
            }
            
            if val == 10 {
                return 1
            } else if val == 0 {
                return 1
            } else {
                return val
            }
        }()
        
        print("Second number = \(secondIndividualNumber)")
        
        // Third Individual Number == First number + Second number
        let numSumNum = firstIndividualNumber + secondIndividualNumber
        
        let thirdIndividualNumber: Int = {
            
            let sum = firstIndividualNumber + secondIndividualNumber
            let strSum = String(sum).map { char in
                char.wholeNumberValue
            }
            
            let val = strSum.reduce(0) { partialResult, num in
                partialResult + (num ?? 0)
            }
            
            if val == 10 {
                return 1
            } else if val == 0 {
                return 1
            } else {
                return val
            }
        }()
        print("Third number = \(thirdIndividualNumber)")
        
        // Fourth Individual Number == MONTH + YEAR
        let strNumbersMY = "\(stringMonth)\(stringYear)"
        
        let fourthArrNum = strNumbersMY.map { char in
            char.wholeNumberValue
        }
        let sumFourthArrNum = fourthArrNum.reduce(0) { partialResult, num in
            partialResult + (num ?? 0)
        }
        
        let arrSumFourthArrNum = String(sumFourthArrNum).map { char in
            char.wholeNumberValue
        }
        
        
        let fourthIndividualNumber: Int = {
            let val = arrSumFourthArrNum.reduce(0) { partialResult, num in
                partialResult + (num ?? 0)
            }

            if val == 10 {
                return 1
            } else if val == 0 {
                return 1
            } else {
                return val
            }
        }()
        
        print("Fourth number = \(fourthIndividualNumber)")
        
        
        
        
//        let receivedCollection: [Int : [Int : Int]] = [
//            1 : [firstStage : firstIndividualNumber],
//            2 : [secondStage : secondIndividualNumber],
//            3 : [thirdStage : thirdIndividualNumber],
//            4 : [fourthStage : fourthIndividualNumber],
//        ]
        
        
        let model = LifeStagesCalculatedModel(
            firstStage: firstStage,
            firstIndividualNumber: firstIndividualNumber,
            secondStage: secondStage,
            secondIndividualNumber: secondIndividualNumber,
            thirdStage: thirdStage,
            thirdIndividualNumber: thirdIndividualNumber,
            fourthStage: fourthStage,
            fourthIndividualNumber: fourthIndividualNumber
        )
        
        return model
    }
    
    
}
