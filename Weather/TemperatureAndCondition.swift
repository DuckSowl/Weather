//
//  ViewController.swift
//  Weather
//
//  Created by Anton Tolstov on 20.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

typealias TemperatureAndCondition = (Double,String)

protocol TemperatureApiDelegate: AnyObject {
    func get(data: TemperatureAndCondition)
}

class TemperatureAPI: UIViewController, CLLocationManagerDelegate  {
    
    var locationManager: CLLocationManager!
    
    weak var delegate: TemperatureApiDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                guard let placeMark = placemarks?.first else { return }
                if let city = placeMark.subAdministrativeArea {
                    
                    struct Main: Codable {
                        var temp:Double
                    }
                    
                    struct Weather: Codable {
                        var main:String
                    }
                    
                    AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=4f7f408233e828a2eaf95de8f6ca6090&units=metric").responseJSON {
                        response in
                        
                        let json = JSON(response.value!)
                        let main = json["main"]
                        
                        do {
                            let data = try main.rawData()
                            let info = try! JSONDecoder().decode(Main.self, from: data)
                            let weather = json["weather"]
                            let arrayWeather = weather.array
                            let jsonWeather = arrayWeather?.first!
                            let dataSecond = try jsonWeather?.rawData()
                            let infoWeather = try! JSONDecoder().decode(Weather.self, from: dataSecond!)
                            self.delegate?.get(data: (info.temp, infoWeather.main))
                        }
                        catch { print("Error")}
                    }
                }
        })
    }
}

