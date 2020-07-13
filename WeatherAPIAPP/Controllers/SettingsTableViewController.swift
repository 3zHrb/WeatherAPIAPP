//
//  SettingsTableViewController.swift
//  WeatherAPIAPP
//
//  Created by Abdulaziz Alharbi on 09/11/1441 AH.
//  Copyright © 1441 Abdulaziz Alharbi. All rights reserved.
//

import Foundation
import UIKit

enum TempsUnit: String, CaseIterable{
    case fahrenheit
    case celsius
}

class SettingsTableViewController: UITableViewController {
    
    var cell: TableViewCell!
//    var arrayOfTempsUnit: [TempsUnit.AllCases]!
    var arrayOfTempsUnit: [TempsUnit]!
    
    static var delegate: WeatherTableViewController!
    
    
    
    static var convertor: TempsUnit = .celsius {
        
        willSet{
             convertor = newValue
        }
        didSet{
            if convertor == oldValue {
                return
            }else{
//                temUnitDidchanged(unit: convertor)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    
//    static func temUnitDidchanged(unit: TempsUnit){
//
//        switch unit {
//
//        case .celsius:
//            delegate.arrayOfDegrees = delegate.arrayOfDegrees.map({ (degree) -> Double in
//                return (Double((degree)) - 32) * 0.555
//            })
//            delegate.tableView.reloadData()
//            break
//        case .fahrenheit:
//            delegate.arrayOfDegrees = delegate.arrayOfDegrees.map({ (degree) -> Double in
//                     print("switch from celsius to fahrenheit ")
//
//                return (Double(degree) * 1.8) + 32
//                 })
//            delegate.tableView.reloadData()
//            break
//        }
//
//    }
    
    override func viewDidLoad() {
    
        arrayOfTempsUnit = [TempsUnit]()
        
        arrayOfTempsUnit = TempsUnit.allCases
        
        self.tableView.rowHeight = 100
        
        self.navigationItem.title = "Units"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTempsUnit.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = TableViewCell()
//        cell.cityDegreeLabel.isHidden = true
        
//        self.tableView.translatesAutoresizingMaskIntoConstraints = false
//            self.tableView.bottomAnchor.constraint(equalTo: self.cell.bottomAnchor, constant: 0).isActive = true
        
        
      
        
        cell.cityNameLabel.text = arrayOfTempsUnit[indexPath.row].rawValue
        cell.cityDegreeLabel.isHidden = true
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCell = tableView.cellForRow(at: indexPath) as? TableViewCell
        
        var UnitChanged = selectedCell?.cityNameLabel.text
        
        SettingsTableViewController.convertor = TempsUnit(rawValue: UnitChanged!)!
//        print("degree cganged to \(SettingsTableViewController.convertor) ")
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
