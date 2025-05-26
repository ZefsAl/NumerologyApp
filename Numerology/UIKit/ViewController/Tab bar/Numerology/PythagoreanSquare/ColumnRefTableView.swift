//
//  ColumnRefTableView.swift
//  Numerology
//
//  Created by Serj_M1Pro on 18.05.2024.
//

import UIKit

struct PythagoreanCellModel {
    var title: String
    var subtitle: String
}

class ColumnRefTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    enum ColumnType {
        case first,second,third
    }
    
    var column: ColumnType = .first
    
    var firstCellModel: PythagoreanCellModel?  {didSet{ self.reloadCellData() }};
    var secondCellModel: PythagoreanCellModel? {didSet{ self.reloadCellData() }};
    var thirdCellModel: PythagoreanCellModel?  {didSet{ self.reloadCellData() }};
    
    private func reloadCellData() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    convenience init(column: ColumnType) {
        self.init()
        self.column = column
        setup()
        register()
        setStyle()
        self.isUserInteractionEnabled = false
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
    }
    private func register() {
        self.register(ColumnRefTableViewCell.self, forCellReuseIdentifier: ColumnRefTableViewCell.reuseID)
    }
    private func setStyle() {
        self.backgroundView?.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColumnRefTableViewCell.reuseID, for: indexPath) as! ColumnRefTableViewCell
        
        switch column {
        case .first:
            if indexPath.row == 0 {
                cell.configure(
                    title: firstCellModel?.title,
                    subtitle: firstCellModel?.subtitle
                )
            }
            if indexPath.row == 1 {
                cell.configure(
                    title: secondCellModel?.title,
                    subtitle: secondCellModel?.subtitle
                )
            }
            if indexPath.row == 2 {
                cell.configure(
                    title: thirdCellModel?.title,
                    subtitle: thirdCellModel?.subtitle
                )
            }
            break
        case .second:
            if indexPath.row == 0 {
                cell.configure(
                    title: firstCellModel?.title,
                    subtitle: firstCellModel?.subtitle
                )
            }
            if indexPath.row == 1 {
                cell.configure(
                    title: secondCellModel?.title,
                    subtitle: secondCellModel?.subtitle
                )
            }
            if indexPath.row == 2 {
                cell.configure(
                    title: thirdCellModel?.title,
                    subtitle: thirdCellModel?.subtitle
                )
            }
            break
        case .third:
            if indexPath.row == 0 {
                cell.configure(
                    title: firstCellModel?.title,
                    subtitle: firstCellModel?.subtitle
                )
            }
            if indexPath.row == 1 {
                cell.configure(
                    title: secondCellModel?.title,
                    subtitle: secondCellModel?.subtitle
                )
            }
            if indexPath.row == 2 {
                cell.configure(
                    title: thirdCellModel?.title,
                    subtitle: thirdCellModel?.subtitle
                )
            }
            break
        }
        
        let color = #colorLiteral(red: 0.7609999776, green: 0.4709999859, blue: 0.9530000091, alpha: 1)
        let width: CGFloat = 1
        let conren: CGFloat = DS.maxCornerRadius
       
        // cell UI
        // костыли
        switch column {
        case .first:
            if indexPath.row == 0 {
                cell.addBorder(toView: cell, toSide: .right, withColor: color, andThickness: width)
                cell.addBorder(toView: cell, toSide: .bottom, withColor: color, andThickness: width)
                cell.customCornerRadius(viewToRound: cell, byRoundingCorners: .topLeft, cornerValue: conren)
                return cell
            }
            if indexPath.row == 1 {
                cell.removeCALayerByName(fromView: cell, name: "BorderCALayerKey") // first delete everything
                cell.addBorder(toView: cell, toSide: .right, withColor: color, andThickness: width)
                cell.customCornerRadius(viewToRound: cell, byRoundingCorners: .allCorners, cornerValue: 0)
            }
            if indexPath.row == 2 {
                cell.addBorder(toView: cell, toSide: .top, withColor: color, andThickness: width)
                cell.addBorder(toView: cell, toSide: .right, withColor: color, andThickness: width)
                cell.customCornerRadius(viewToRound: cell, byRoundingCorners: .bottomLeft, cornerValue: conren)
            }
            break
        case .second:
            if indexPath.row == 0 {
                cell.addBorder(toView: cell, toSide: .bottom, withColor: color, andThickness: width)
            }
            if indexPath.row == 1 {
                cell.removeCALayerByName(fromView: cell, name: "BorderCALayerKey") // first delete everything
                cell.addBorder(toView: cell, toSide: .bottom, withColor: color, andThickness: 0)
            }
            if indexPath.row == 2 {
                cell.addBorder(toView: cell, toSide: .top, withColor: color, andThickness: width)
            }
            break
        case .third:
            if indexPath.row == 0 {
                cell.addBorder(toView: cell, toSide: .left, withColor: color, andThickness: width)
                cell.addBorder(toView: cell, toSide: .bottom, withColor: color, andThickness: width)
                cell.customCornerRadius(viewToRound: cell, byRoundingCorners: .topRight, cornerValue: conren)
            }
            if indexPath.row == 1 {
                cell.removeCALayerByName(fromView: cell, name: "BorderCALayerKey") // first delete everything
                cell.addBorder(toView: cell, toSide: .left, withColor: color, andThickness: width)
//                cell.addBorder(toView: cell, toSide: .bottom, withColor: color, andThickness: 0)
                cell.customCornerRadius(viewToRound: cell, byRoundingCorners: .allCorners, cornerValue: 0)
            }
            if indexPath.row == 2 {
                cell.addBorder(toView: cell, toSide: .top, withColor: color, andThickness: width)
                cell.addBorder(toView: cell, toSide: .left, withColor: color, andThickness: width)
                cell.customCornerRadius(viewToRound: cell, byRoundingCorners: .bottomRight, cornerValue: conren)
            }
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/3
    }
    
}
