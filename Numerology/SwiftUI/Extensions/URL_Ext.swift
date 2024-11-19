//
//  File.swift
//  Numerology
//
//  Created by Serj_M1Pro on 30.10.2024.
//

import Foundation

extension URL: Identifiable {
    public var id: String {
        self.absoluteString
    }
}
