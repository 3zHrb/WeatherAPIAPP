//
//  SearchCityVC.swift
//  WeatherAPIAPP
//
//  Created by Abdulaziz Alharbi on 07/11/1441 AH.
//  Copyright © 1441 Abdulaziz Alharbi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var appDelegate = UIApplication.shared.delegate as! AppDelegate
var context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

class SearchCityVC: UIViewController, UITextFieldDelegate{
    
//    static var theSelf: SearchCityVC{
//        return self
//    }
    
    weak var delegate: WeatherTableViewController!
    
    var searchTextField: UITextField!
    var getWeatherButton: UIButton!
    
    override func viewDidLoad() {
        // what does super.viewDidLoad() include, and what will happen if we don't include it
        super.viewDidLoad()
        
        self.view.backgroundColor = .darkGray
        
        self.navigationItem.title = "Search for City"
       
//        var frame = CGRect(x: 20, y: 200, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.05)
            
        searchTextField = UITextField()
        searchTextField.layer.borderColor = CGColor(srgbRed: 246, green: 31, blue: 35, alpha: 1)
        searchTextField.layer.borderWidth = 0.2
        searchTextField.layer.cornerRadius = 5
        searchTextField.placeholder = "     Enter City Name   "
        searchTextField.textAlignment = .center
        searchTextField.frame.size.width = CGFloat(self.view.frame.width / 2)
        //searchTextField.layer.borderWidth = 0.1
        //searchTextField.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        
        getWeatherButton = UIButton()
        let image = UIImage(named: "Rectangle.png")
        getWeatherButton.setBackgroundImage(image, for: .normal)
        getWeatherButton.setTitle("Get Weather", for: .normal)
        getWeatherButton.setTitleColor(.white, for: .normal)
        getWeatherButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        getWeatherButton.addTarget(self, action: #selector(getButtonPressed), for: .touchUpInside)
        getWeatherButton.layer.shadowColor = .init(srgbRed: 0, green: 0, blue: 0 , alpha: 1)
        getWeatherButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        getWeatherButton.layer.shadowOpacity = 0.5
        getWeatherButton.layer.shadowRadius = 10
        
        
        self.view.addSubview(searchTextField)
        self.view.addSubview(getWeatherButton)
        // see how to make padding for the textfield placeholder
        // see also how to make a padding for the entered text
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.searchTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        self.searchTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        self.getWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        self.getWeatherButton.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 30).isActive = true
        self.getWeatherButton.centerXAnchor.constraint(equalToSystemSpacingAfter: self.view.centerXAnchor, multiplier: 0).isActive = true
        
//        getWeatherButton.trailingAnchor.constraint(equalTo: self.getWeatherButton.titleLabel!.trailingAnchor, constant: 20).isActive = true
//        getWeatherButton.leadingAnchor.constraint(equalTo: self.getWeatherButton.titleLabel!.leadingAnchor, constant: 20).isActive = true
        
         searchTextField.delegate = self
       
        
    }
    
     func alertSetUp(reason: String){
        
        var alert = UIAlertController(title: "Error", message: reason, preferredStyle: .alert)
        var action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func getButtonPressed(){
        
        if searchTextField.text == ""{
            self.alertSetUp(reason: "The Field is Empty")
        }else{
            
            self.getWeatherButton.isEnabled = false
            
            // later change it to result<>
            
            Webservice.getData(cityName: self.searchTextField.text!) { (weatherData, error) in
                     
                         if error != nil {
                             self.alertSetUp(reason: "Error Occured")
                         }
                if let weatherData = weatherData {
                    
                    
//                    self.delegate.arrayOfCities.append(weatherData.name)
                    
                    let toCelsius = (weatherData.main.temp - 273.15)
                    
//                    var degreeToString = String(format: "%.0f", toCelsius)
                    
//                    self.delegate.arrayOfDegrees.append(toCelsius)
                    
                
                    do{
                    try context.save()
                    }catch{
                        print("error occured")
                    }
                    
                        DispatchQueue.main.async {
                            var dataToInsert = DataBase(context: context)
                            dataToInsert.cityDegree = toCelsius
                            dataToInsert.cityName = self.searchTextField.text!

                            self.delegate.arrayOfDegrees.append(toCelsius)
                            
                            appDelegate.saveContext()
                            
                            self.searchTextField.text = ""
                                        
                            self.delegate.tableView.reloadData()
                             self.getWeatherButton.isEnabled = true
                            self.navigationController?.popViewController(animated: true)
                                    }
                        
                }else {
                    DispatchQueue.main.async {
                        self.alertSetUp(reason: "Uncorrect City Name")
                        self.getWeatherButton.isEnabled = true
                    }
                                          
                }

                // why?
                  
    }
            }
                    }
    
    
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.searchTextField.resignFirstResponder()
        
        return true
    }
    
    
    
}


