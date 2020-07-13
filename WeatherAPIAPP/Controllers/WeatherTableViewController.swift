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
    
    var arrayOfItems = [DataBase]()
    var arrayOfDegrees = [Double]()
    
//    var arrayOfCities = [String]()
//    var arrayOfDegrees = [Double]()
    
    
    override func viewDidLoad() {
      
      
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToWeatherSearchVC))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Unit Conversion", style: .done, target: self, action: #selector(goToSettingsTableVC))
        
        
        self.tableView.rowHeight = 100
        
        self.navigationItem.title = "Citites Weather"
        
//        if !arrayOfItems.isEmpty{
//            print("Array is not Empty")
//            self.navigationItem.leftBarButtonItem?.isEnabled = true
//
//            }else {
//            print("array is empty")
//            print("Now we are inisde the viewDidlOad before the iteration")
        
        do{
            
            if let check = try? context.fetch(DataBase.fetchRequest()){
                
                arrayOfItems = try! context.fetch(DataBase.fetchRequest())
                
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                
                for i in arrayOfItems{
                    arrayOfDegrees.append(i.cityDegree)
                }
                
            }else {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
            }
            
            
        }catch{
            print("Error could not fetch in viewDidload")
        }
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
        
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        do{
            arrayOfItems = try! context.fetch(DataBase.fetchRequest())
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }catch{
            print("error occued while fetch the data")
        }
        
//        if arrayOfItems == nil {
//            self.navigationItem.leftBarButtonItem?.isEnabled = false
//        }else {
//            self.navigationItem.leftBarButtonItem?.isEnabled = true
//
//
//        }
        
        self.tableView.reloadData()

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
        return arrayOfItems == nil ? 0 : arrayOfItems.count
    }
    
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // new things need to be added
        var cell = TableViewCell()
        cell.cityNameLabel.text = arrayOfItems[indexPath.row].cityName
        
        //var convertor = degreeConvertor(Unit: )
        cell.cityDegreeLabel.text = String(format: "%.0f", arrayOfDegrees[indexPath.row]) + "°"
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            var atRow = arrayOfItems[indexPath.row]

            context.delete(atRow)
            
            appDelegate.saveContext()
            arrayOfItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

//            context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
        }
    }
    
}
