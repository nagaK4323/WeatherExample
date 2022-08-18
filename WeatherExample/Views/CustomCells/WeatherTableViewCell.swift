//
//  WeatherTableViewCell.swift
//  WeatherExample
//
//  Created by Naga sashidhar kummara on 8/18/22.
//

import Foundation
import UIKit

class WeatherTableViewCell: UITableViewCell {

@IBOutlet weak var lbl:UILabel!
@IBOutlet weak var lblOFlocation:UILabel!
@IBOutlet weak var lblOfWeather:UILabel!
@IBOutlet weak var imgOfWeatherIcon:UIImageView!

var userLocation :UserLocation?
func configureCell(userLocation :UserLocation?){
    if let userLocation = userLocation,
       let icons = userLocation.current?.weather_icons,
    let locationDetails = userLocation.location,
    let weatherDetails = userLocation.current{
        self.lbl.text = userLocation.location?.name
        self.imgOfWeatherIcon.imageFromUrl(urlString: icons[0])
        self.lblOFlocation.text = "\(locationDetails.region ?? ""),\(locationDetails.country ?? ""),\(locationDetails.localtime ?? "")"
        
        self.lblOfWeather.text = "\(weatherDetails.weather_descriptions?[0] ?? ""),\(weatherDetails.observation_time ?? "")"
        
    }
    
}
}
