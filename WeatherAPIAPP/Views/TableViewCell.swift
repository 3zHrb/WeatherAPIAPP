//
//  TableViewCell.swift
//  WeatherAPIAPP
//
//  Created by Abdulaziz Alharbi on 09/11/1441 AH.
//  Copyright © 1441 Abdulaziz Alharbi. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell{
    
    var cityNameLabel: UILabel!
    var cityDegreeLabel: UILabel!
    
    
    // self.contentView might be wrong!
    
    init(){

        super.init(style: .default, reuseIdentifier: nil)
//        cityNameLabel = UILabel(frame: CGRect(x: self.contentView.frame.width / 10, y: self.contentView.frame.height / 2, width: self.contentView.frame.width * 0.25, height: self.contentView.frame.height * 0.35))
        cityNameLabel = UILabel()
        cityNameLabel.text = "City Name"
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        //self.cityNameLabel.textAlignment = .center
//        cityDegreeLabel = UILabel(frame: CGRect(x: self.contentView.frame.width - 10, y: self.contentView.frame.height / 2, width: self.contentView.frame.width * 0.25 , height: self.contentView.frame.height * 0.35))
        cityDegreeLabel = UILabel()
        cityDegreeLabel.text = "Degree"
        cityDegreeLabel.font = UIFont.boldSystemFont(ofSize: 25)
       // self.cityDegreeLabel.textAlignment = .justified
        
        
        self.contentView.addSubview(cityNameLabel)
        self.contentView.addSubview(cityDegreeLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        
        cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
                
        cityDegreeLabel.translatesAutoresizingMaskIntoConstraints = false
//        cityDegreeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40 ).isActive = true
        cityDegreeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        var constrainsCityName = NSLayoutConstraint(item: cityNameLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        var constrainsDegree = NSLayoutConstraint(item: cityDegreeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([constrainsCityName, constrainsDegree])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
