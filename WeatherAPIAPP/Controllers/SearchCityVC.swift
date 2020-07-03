//
//  SearchCityVC.swift
//  WeatherAPIAPP
//
//  Created by Abdulaziz Alharbi on 07/11/1441 AH.
//  Copyright © 1441 Abdulaziz Alharbi. All rights reserved.
//

import Foundation
import UIKit

class SearchCityVC: UIViewController, UITextFieldDelegate{
    
//    static var theSelf: SearchCityVC{
//        return self
//    }
    
    weak var delegate: WeatherTableViewController!
    
    var searchTextField: UITextField!
    var getWeatherButton: UIButton!
    var cityNameTest: UILabel!
    var degreeTest: UILabel!
    
    override func viewDidLoad() {
        // what does super.viewDidLoad() include, and what will happen if we don't include it
        super.viewDidLoad()
        
        self.view.backgroundColor = .darkGray
       
//        var frame = CGRect(x: 20, y: 200, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.05)
            
        searchTextField = UITextField()
        searchTextField.placeholder = "   Enter City Name  "
        searchTextField.layer.cornerRadius = 5
        searchTextField.layer.borderWidth = 0.1
        searchTextField.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        
        getWeatherButton = UIButton()
        var image = UIImage(named: "Untitled.png")
        getWeatherButton.setBackgroundImage(image, for: .normal)
        getWeatherButton.setTitle("Get Weather", for: .normal)
        getWeatherButton.setTitleColor(.white, for: .normal)
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
        self.getWeatherButton.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 10).isActive = true
        self.getWeatherButton.centerXAnchor.constraint(equalToSystemSpacingAfter: self.view.centerXAnchor, multiplier: 0).isActive = true
        
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
 
            Webservice.getData(cityName: self.searchTextField.text!) { (weatherData, error) in
                         print("We just called Webservive().getData")
                         if error != nil {
                             self.alertSetUp(reason: "Error Occured")
                            return nil
                         }
                
                if let weatherData = weatherData {
                    print("We got the Data")
                    print(weatherData.name)
                }
                
                
                DispatchQueue.main.async {
                    self.searchTextField.text = ""
                    self.getWeatherButton.isEnabled = false
                }
                        
            // Webservice() will not work
return nil
        }
        
       
        }
        
        self.getWeatherButton.isEnabled = true
        self.delegate.tableView.reloadData()
      self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.searchTextField.resignFirstResponder()
        
        return true
    }
    
    
    
}


