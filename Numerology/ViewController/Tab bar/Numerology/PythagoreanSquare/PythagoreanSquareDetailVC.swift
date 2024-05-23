//
//  ViewController.swift
//  Numerology
//
//  Created by Serj on 29.01.2024.
//

import UIKit

class PythagoreanSquareDetailVC: UIViewController {
    
    // MARK: - accordion Stack
    let accordionStack = UIStackView()
    
    // MARK: Scroll View
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    private let headerTitle: SectionHeaderView = {
        let v = SectionHeaderView()
        v.label.text = "About you"
        v.label.textColor = DesignSystem.Numerology.lightTextColor
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return v
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.setBackground(named: "MainBG3")
        AnimatableBG().setBackground(vc: self)
        //
        setUpStack()
    }
    
    func configureHandleDataModels(models: [PythagoreanDetailDataModel]) {

        let models = models.sorted { one, two in
            one.index < two.index
        }
        
        print("check ✅",models.count)
        

        for models in models {
            print("✅🟣 index",models.index)
            print("✅🟣 title",models.title)
            print("✅🟣 subtitle",models.subtitle)
        }
        
        for model in models {
            let accordionView: AccordionView = {
                let v = AccordionView()
                v.showAccordion()
                v.accordionButton.configure(title: model.title)
                v.info.text = model.subtitle
                v.imageView.image = nil
                return v
            }()
            accordionStack.addArrangedSubview(accordionView)
        }
        
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        accordionStack.translatesAutoresizingMaskIntoConstraints = false
        accordionStack.axis = .vertical
        accordionStack.spacing = 8
        
        // cardView + Border
        let cardView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            // Style
            v.backgroundColor = DesignSystem.Numerology.backgroundColor
            // Border
            v.layer.cornerRadius = 16
            v.layer.borderWidth = DesignSystem.borderWidth
            v.layer.borderColor = DesignSystem.Numerology.primaryColor.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowRadius = 16
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowColor = DesignSystem.Numerology.shadowColor.cgColor
            
            
            v.addSubview(accordionStack)
            NSLayoutConstraint.activate([
                accordionStack.topAnchor.constraint(equalTo: v.topAnchor, constant: 16),
                accordionStack.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16),
                accordionStack.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -16),
                accordionStack.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -0),
                accordionStack.widthAnchor.constraint(equalTo: v.widthAnchor, constant: -32),
            ])
            
            return v
        }()
        
        // MARK: content Stack
        let contentStack = UIStackView(arrangedSubviews: [headerTitle,cardView])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.spacing = 12
        
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStack)
        
        let scrollViewMargin = contentScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 32),
            contentStack.leadingAnchor.constraint(equalTo: scrollViewMargin.leadingAnchor, constant: 18),
            contentStack.trailingAnchor.constraint(equalTo: scrollViewMargin.trailingAnchor, constant: -18),
            contentStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -18),
            contentStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -36),
            
            contentScrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

