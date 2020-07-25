//
//  WeatherModel.swift
//  WeatherAPIAPP
//
//  Created by Abdulaziz Alharbi on 09/11/1441 AH.
//  Copyright © 1441 Abdulaziz Alharbi. All rights reserved.
//

import Foundation

struct main: Codable{
    var temp : Double
}

struct WeatherModel: Codable{
    
//    var main: main
    var main: main
    var name: String
    
}
