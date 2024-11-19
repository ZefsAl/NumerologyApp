//
//  Extension_String.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.11.2024.
//

import Foundation

extension String {
    func camelCaseToWords() -> String {
        return unicodeScalars.dropFirst().reduce(String(prefix(1))) {
            return CharacterSet.uppercaseLetters.contains($1)
            ? $0.capitalized + " " + String($1).lowercased()
                : $0 + String($1)
        }
    }
}
