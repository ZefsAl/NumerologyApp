//
//  ViewController.swift
//  Numerology
//
//  Created by Serj on 17.07.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = .systemPink
        self.view.backgroundColor = .gray
        configureNavView()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureNavView() {
//        self.title = "two"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.title = "TEST1"
        
    }

}

