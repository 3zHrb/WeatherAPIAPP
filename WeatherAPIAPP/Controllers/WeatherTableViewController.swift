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
    var DicOfWeather = [String:String]()
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToWeatherSearchVC))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(goToSettingsTableVC))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //self.tableView.reloadData()
    }
    
    @objc func goToWeatherSearchVC(){
        
        var SearchObj = SearchCityVC()
        SearchObj.delegate = self
        self.navigationController?.pushViewController(SearchObj, animated: true)
        
    }
    
    @objc func goToSettingsTableVC(){
        self.navigationController?.present(SettingsTableViewController(), animated: true, completion: nil)    //self.navigationController?.pushViewController(SettingsTableViewController(), animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // will need to be changed
        return DicOfWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // new things need to be added
        var cell = TableViewCell()
        //cell.cityNameLabel.text = arrayOfClimates[indexPath.row]
        return cell
        
    }
    
}
