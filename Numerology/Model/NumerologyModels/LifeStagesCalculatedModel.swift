//
//  LifeStagesCalculatedModel.swift
//  Numerology
//
//  Created by Serj on 12.08.2023.
//

import Foundation


class LifeStagesCalculatedModel {
    
    let firstStage: Int
    let firstIndividualNumber: Int
    
    let secondStage: Int
    let secondIndividualNumber: Int
    
    let thirdStage: Int
    let thirdIndividualNumber: Int
    
    let fourthStage: Int
    let fourthIndividualNumber: Int
    
    init(
        firstStage: Int,
        firstIndividualNumber: Int,
        secondStage: Int,
        secondIndividualNumber: Int,
        thirdStage: Int,
        thirdIndividualNumber: Int,
        fourthStage: Int,
        fourthIndividualNumber: Int
    ) {
        self.firstStage = firstStage
        self.firstIndividualNumber = firstIndividualNumber
        self.secondStage = secondStage
        self.secondIndividualNumber = secondIndividualNumber
        self.thirdStage = thirdStage
        self.thirdIndividualNumber = thirdIndividualNumber
        self.fourthStage = fourthStage
        self.fourthIndividualNumber = fourthIndividualNumber
    }
}
