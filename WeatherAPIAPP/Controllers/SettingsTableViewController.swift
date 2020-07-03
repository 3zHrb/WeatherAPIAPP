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

    
    override func viewDidLoad() {
    
        arrayOfTempsUnit = [TempsUnit]()
        
        arrayOfTempsUnit = TempsUnit.allCases
        
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
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
