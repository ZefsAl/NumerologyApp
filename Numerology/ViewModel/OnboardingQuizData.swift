//
//  OnboardingQuizData.swift
//  Numerology
//
//  Created by Serj on 24.10.2023.
//

import Foundation




struct OnboardingQuizModel {
    let questionTitle: String
    var answer: [String]
}

struct OnboardingQuizData {
    
    var quiz1: OnboardingQuizModel = OnboardingQuizModel(
        questionTitle: "Question1",
        answer: [
        "Answer1",
        "Answer2",
        "Answer3",
    ])
    
    var quiz2: OnboardingQuizModel = OnboardingQuizModel(
        questionTitle: "Question2",
        answer: [
        "Answer1",
        "Answer2",
        "Answer3",
    ])

    init() {
        
    }
}


