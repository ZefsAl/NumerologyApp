//
//  ViewControllerTest.swift
//  Numerology
//
//  Created by Serj_M1Pro on 01.05.2024.
//

import UIKit

class ViewControllerTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        setTestRequest()
    }
    
    
    
    func setTestRequest() {
        guard let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirthKey") as? Date else { return }
        let number = CalculateNumbers().calculateNumberOfSoul(date: dateOfBirth)
        
        // Numbers Of Soul
//        NumerologyManager.shared.getNumbersOfSoul(number: number) { model, img in
//            print("🔴",model.aboutSoul)
//            print("🔴",model.infoSoul)
//        }
        //
        
    }

}
