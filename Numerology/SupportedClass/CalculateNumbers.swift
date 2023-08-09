//
//  CalculateNumbers.swift
//  Numerology
//
//  Created by Serj on 28.07.2023.
//

import Foundation
import UIKit

class CalculateNumbers {
 
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
        
        // Sum to String
        let strSumArr = String(sumArr)
        var numbersArrSum = [Int]()
                
        for char in strSumArr {
            if let num = char.wholeNumberValue {
                numbersArrSum.append(num)
            }
        }
        
        let sumOfSum = numbersArrSum.reduce(0) { partialResult, num in
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
    
    
    
}
