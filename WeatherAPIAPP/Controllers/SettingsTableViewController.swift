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
    
     var user = UserDefaults.standard
    
    static var convertor: TempsUnit = .celsius {
        
        willSet{
             convertor = newValue
        }
        didSet{
            if convertor == oldValue {
                return
            }else{
                temUnitDidchanged(unit: convertor)
            }
        }
        
    }
    
 
    
    override func viewDidAppear(_ animated: Bool) {
        if user.string(forKey: "savedUnit") == nil {
                 user.set("celsius", forKey: "savedUnit")
             }else {
            var i = 0
                 var myCells = tableView.visibleCells as! [TableViewCell]
                 var theCell = myCells.map { cell in
                     if cell.cityNameLabel.text == user.string(forKey: "savedUnit"){
                        tableView.cellForRow(at: [0, i])?.accessoryType = .checkmark
                    }
                    
                    i = i + 1
                 }
    
                 }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        user.set(SettingsTableViewController.convertor.rawValue, forKey: "savedUnit")
    }
    
    
    static func temUnitDidchanged(unit: TempsUnit){

        switch unit {

        case .celsius:
            
            delegate.arrayOfDegrees = delegate.arrayOfDegrees.map({ (degree) -> Double in
                return (Double((degree)) - 32) * 0.555
            })
            delegate.tableView.reloadData()
            break
        case .fahrenheit:
            delegate.arrayOfDegrees = delegate.arrayOfDegrees.map({ (degree) -> Double in
                    

                return (Double(degree) * 1.8) + 32
                 })
            delegate.tableView.reloadData()
            break
        }

    }
    
    override func viewDidLoad() {
    
        arrayOfTempsUnit = [TempsUnit]()
        
        arrayOfTempsUnit = TempsUnit.allCases
        
        self.tableView.rowHeight = 100
        
        self.navigationItem.title = "Units"
        
       
        
        
//        self.tableView.translatesAutoresizingMaskIntoConstraints = false
//        self.tableView.bottomAnchor.constraint(equalTo: self.cell.bottomAnchor, constant: 0).isActive = true
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTempsUnit.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = TableViewCell()
        cell.cityDegreeLabel.isHidden = true
        
//        self.tableView.translatesAutoresizingMaskIntoConstraints = false
//            self.tableView.bottomAnchor.constraint(equalTo: self.cell.bottomAnchor, constant: 0).isActive = true

        cell.cityNameLabel.text = arrayOfTempsUnit[indexPath.row].rawValue
        cell.cityDegreeLabel.isHidden = true
        
        var selectedCell = user.string(forKey: "savedUnit")
        
        if cell.cityNameLabel.text == selectedCell{
        
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
           
        
        }
     
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.visibleCells.map { cell in
            cell.accessoryType = .none
        }
        
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
