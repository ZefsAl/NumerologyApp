//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 21.05.2024.
//

import UIKit

class PythagoreanSquare {
    
    
    // MARK: - make Pythagorean Number
    /// Example:  cell(first 1)  count == 3 return 111 etc
    static func makePythagoreanNumber(number: Int, amountNumber: Int) -> String {
        guard
            number != 0,
            amountNumber != 0
        else { return "0" }
        
        let result: String = {
            var partial = [String]()
            for _ in 1...amountNumber {
                partial.append(String(number))
            }
            return partial.joined()
        }()
        
        return result
    }
    
    static func makeDate(year: String, month: String, day: String) -> Date {
        let strDate = "\(year)-\(month)-\(day)T00:00:00+0000"
        let df = DateFormatter()
        // full format
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let new = df.date(from: strDate)
        if let new = new {
            print("date ✅ Unwrapped")
            return new
        } else {
            print("date 🔴 Not Unwrap")
            return Date()
        }
    }
    
    func convertDateFormat(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        let formatedStrDate = df.string(from: date)
        print(date,"---> ✅",formatedStrDate)
        return formatedStrDate
    }
    
    // MARK: - pythagorean Square
    /// compute numbers frome uset date of birth
    func pythagoreanSquare(dateOfBirth: Date) -> String {
        let currentDateString = convertDateFormat(date: dateOfBirth)
        
        // Purified
        let datePurifiedArray: [Int] = {
            let dateStrNumber = currentDateString.components(separatedBy: ".").joined()
            // remove zero
            let purified = dateStrNumber.replacingOccurrences(of: "0", with: "")
            // array of numbers
            let arr = purified.compactMap { $0.wholeNumberValue }
            return arr
        }()
        
        // MARK: - первое рабочее число
        let firstNumber: Int = {
            // reduce
            let result = datePurifiedArray.reduce(into: 0) { $0 += $1 }
            return result
        }()
        
        // MARK: - второе число
        let secondNumber: Int = {
            var partialResult: Int = firstNumber
            let arr = String(partialResult).compactMap { $0.wholeNumberValue }
            let result = arr.reduce(into: 0) { $0 += $1 }
            partialResult = result
            return partialResult
        }()
        
        // MARK: - третье число
        let thirdNumber: Int = {
            let dayNumber = String(dateOfBirth.get(.day)).replacingOccurrences(of: "0", with: "").compactMap { $0.wholeNumberValue }[0] * 2
            return abs(firstNumber - dayNumber)
        }()
        
        // MARK: - четвертое число
        let fourthNumber: Int = {
            let thirdNumberArray = String(thirdNumber).replacingOccurrences(of: "0", with: "").compactMap { $0.wholeNumberValue }
            let result = thirdNumberArray.reduce(into: 0) { $0 += $1 }
            return result
        }()
        
        // concatenate arr
        let resultArray = [firstNumber,secondNumber,thirdNumber,fourthNumber]+datePurifiedArray
        let stringResult = resultArray.compactMap{String($0)}.joined()
        
        return stringResult
    }
    
}
