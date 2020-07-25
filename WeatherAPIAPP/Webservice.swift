//
//  Webservice.swift
//  WeatherAPIAPP
//
//  Created by Abdulaziz Alharbi on 08/11/1441 AH.
//  Copyright © 1441 Abdulaziz Alharbi. All rights reserved.
//

import Foundation
import UIKit

class Webservice{
    
    static var delegate: SearchCityVC?
    
    static func getData(cityName: String, resultback: @escaping (WeatherModel?, Error?) -> ()){
    
        var trimmer = cityName.replacingOccurrences(of: " ", with: "+")
        
        
       
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(trimmer)&appid=eac487641a5f879d83763eae5ced0905")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            

            if let error = error {
//                SearchCityVC().alertSetUp(reason: "Error Occured")
                print("Error is: \(error)")
                resultback(nil, error)
            }
            
            if let data = data {
            
                
                let jsonData = try? JSONDecoder().decode(WeatherModel.self, from: data)
         
                resultback(jsonData, nil)
              
               
                }
            }.resume()
        
    }
    
}
