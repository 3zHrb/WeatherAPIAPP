//
//  WeatherTableViewController.swift
//  WeatherAPIAPP
//
//  Created by Abdulaziz Alharbi on 09/11/1441 AH.
//  Copyright © 1441 Abdulaziz Alharbi. All rights reserved.
//

import Foundation
import UIKit

class WeatherTableViewController: UITableViewController{
    
    
    var cell: TableViewCell!
    var arrayOfCities = [String]()
    var arrayOfDegrees = [Int]()
    
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToWeatherSearchVC))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(goToSettingsTableVC))
        
        self.tableView.rowHeight = 100
        
        self.navigationItem.title = "Citites Weather"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if arrayOfDegrees.isEmpty {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }else {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }

    }
        

    @objc func goToWeatherSearchVC(){
        
        let SearchObj = SearchCityVC()
        SearchObj.delegate = self
        self.navigationController?.pushViewController(SearchObj, animated: true)
        
    }
    
    @objc func goToSettingsTableVC(){
        
        let settingObject = SettingsTableViewController()
        
      SettingsTableViewController.delegate = self
        
        self.navigationController?.pushViewController(settingObject, animated: true)   //self.navigationController?.pushViewController(SettingsTableViewController(), animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // will need to be changed
        return arrayOfCities.count
    }
    
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // new things need to be added
        var cell = TableViewCell()
        //cell.cityNameLabel.text = arrayOfClimates[indexPath.row]
        cell.cityNameLabel.text = arrayOfCities[indexPath.row]
        //var convertor = degreeConvertor(Unit: )
        cell.cityDegreeLabel.text = String(arrayOfDegrees[indexPath.row]) + "°"
        return cell
        
    }
    
}
