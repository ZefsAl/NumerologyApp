//
//  ProfileNavButton.swift
//  Numerology
//
//  Created by Serj_M1Pro on 26.08.2024.
//

import UIKit
import SwiftUI

final class ProfileButton: UIButton {
    
    var remoteOpenDelegate: RemoteOpenDelegate? = nil
    
    // MARK: - 🟢 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.setImage(UIImage(named: "Gear_SF"), for: .normal)
        
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        // target
        self.addTarget(Any?.self, action: #selector(profileAct), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func profileAct() {
        self.remoteOpenDelegate?.openFrom?.navigationController?.pushViewController(
            CustomHostController(rootView: SettingsView()),
            animated: true
        )
    }
}


// Создаем кастомный UIHostingController
class CustomHostController<Content: View>: UIHostingController<Content> {
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myPrint("CustomHostController 🌕 viewWillAppear")
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = false
        myPrint("CustomHostController 🌕 viewDidDisappear")
    }
}
