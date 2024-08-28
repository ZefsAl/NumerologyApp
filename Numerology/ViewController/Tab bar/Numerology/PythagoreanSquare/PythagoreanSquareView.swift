//
//  PythagoreanSquareView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.05.2024.
//

import UIKit

struct PythagoreanDetailDataModel {
    var index: Int
    var info: String
    var title: String
    var subtitle: String
}

final class PythagoreanSquareView: UIView {
    
    var pythagoreanDetailDataModels = [PythagoreanDetailDataModel]()
    
    let columnRefTableView1 = ColumnRefTableView(column: .first)
    let columnRefTableView2 = ColumnRefTableView(column: .second)
    let columnRefTableView3 = ColumnRefTableView(column: .third)
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupUI()
        self.requestData()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requestData() {
        let dateOfBirth = UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
        
        guard let dateOfBirth = dateOfBirth else {
            print("🔴 error dateOfBirth PythagoreanSquareView");
            return
        }
           
        // Table Request + Configure Cell, make Models
        let numbers = PythagoreanSquare().pythagoreanSquare(dateOfBirth: dateOfBirth)
        
        for val in 1...9 {
            let characterVal = Character(String(val))
            //
            let count = numbers.filter{$0 == characterVal}.count
            //
            let spacer = " "
            DispatchQueue.main.async {
                NumerologyManager.shared.getPythagoreanSquare(cellNumber: val) { fetchedModel in
                    
                    switch val {
                    case 1:
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Character"
                        )
                        
                        self.columnRefTableView1.firstCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 1, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    case 2:
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Energy"
                        )
                        
                        self.columnRefTableView1.secondCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 2, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    case 3:
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Accuracy"
                        )
                        
                        self.columnRefTableView1.thirdCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 3, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    case 4:
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Health"
                        )
                        
                        self.columnRefTableView2.firstCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 4, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        break
                    case 5:
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Logics"
                        )
                        
                        self.columnRefTableView2.secondCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 5, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    case 6:
                        
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Work"
                        )
                        
                        self.columnRefTableView2.thirdCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 6, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    case 7:
                        
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Luck"
                        )
                        
                        self.columnRefTableView3.firstCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 7, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    case 8:
                        
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Duty"
                        )
                        
                        self.columnRefTableView3.secondCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 8, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    case 9:
                        
                        let cellModel = PythagoreanCellModel(
                            title: PythagoreanSquare.makePythagoreanNumber(number: val, amountNumber: count),
                            subtitle: "Mind"
                        )
                        
                        self.columnRefTableView3.thirdCellModel = cellModel
                        
                        self.pythagoreanDetailDataModels.append(PythagoreanDetailDataModel(
                            index: 9, 
                            info: fetchedModel.info,
                            title: cellModel.subtitle + spacer + cellModel.title,
                            subtitle: ConvertPythagoreanNumbers.intToConstName(count: count, model: fetchedModel))
                        )
                        
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    // MARK: - setup UI
    private func setupUI() {
        
        let tableStack = UIStackView(arrangedSubviews: [
            columnRefTableView1,
            columnRefTableView2,
            columnRefTableView3,
        ])
        tableStack.translatesAutoresizingMaskIntoConstraints = false
        tableStack.axis = .horizontal
        tableStack.spacing = 0
        tableStack.alignment = .fill
        tableStack.distribution = .fillEqually
        // Border
        let color = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        tableStack.layer.cornerRadius = DesignSystem.maxCornerRadius
        tableStack.layer.borderWidth = 1
        tableStack.layer.borderColor = color.cgColor
        tableStack.layer.shadowOpacity = 1
        tableStack.layer.shadowRadius = 16
        tableStack.layer.shadowOffset = CGSize(width: 0, height: 4)
        tableStack.layer.shadowColor = color.withAlphaComponent(0.5).cgColor
        // add
        self.addSubview(tableStack)
        NSLayoutConstraint.activate([
            tableStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            tableStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
            tableStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
