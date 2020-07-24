//
//  ViewController.swift
//  Weather
//
//  Created by Anton Tolstov on 20.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController,CLLocationManagerDelegate  {

    var locationManager: CLLocationManager!
    
    var temperature: Double = 0 {
        didSet {
            print("Temeprature is \(temperature)")
        }
    }
    
    var condition: String = "" {
        didSet {
            print("Condition is \(condition)")
        }
    }
    
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
{

    let location = locations.last! as CLLocation
    /* тут значения широты и долготы */
    let lat = location.coordinate.latitude
    let long = location.coordinate.longitude
    
    print ("latitude = \(lat)")
    print("longtitude = \(long)")
    
    let geoCoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(location, completionHandler:
        {
            placemarks, error -> Void in
            guard let placeMark = placemarks?.first else { return }
            if let city = placeMark.subAdministrativeArea {
                
                var generalData : Main
                generalData = Main(humidity:0.0,temp_max:0.0,temp:0.0,pressure:0.0,feels_like:0.0,temp_min:0.0)
                
                struct Main: Codable {
                  var humidity:Double
                  var temp_max:Double
                  var temp:Double
                  var pressure:Double
                  var feels_like:Double
                  var temp_min:Double
                }
                
                struct Weather: Codable {
                  var icon:String
                  var main:String
                  var id:Double
                  var description:String
                }
                
                print("The city is \(city)")
                AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=4f7f408233e828a2eaf95de8f6ca6090&units=metric").responseJSON {
                response in
                    
                    let json = JSON(response.value!)
                    let main = json["main"]
                    
                    do {
                        let data = try main.rawData()
                        let info = try! JSONDecoder().decode(Main.self, from: data)
                        generalData = info
                        self.temperature = generalData.temp
                        //print("Temperature in \(city) is \(generalData.temp)")
                    }
                    catch { print("Error")}
                    
                    let weather = json["weather"]
                    
                    do {
                        let arrayWeather = weather.array
                        let jsonWeather = arrayWeather?.first!
                        let data = try jsonWeather?.rawData()
                        let infoWeather = try! JSONDecoder().decode(Weather.self, from: data!)
                        self.condition = infoWeather.description
                        //print("Description is \(infoWeather.description)")
                    }
                    catch { print("Error")}
                }
            }
            
            /*   if let country = placeMark.country {
                print("The country is \(country)")
            } */
            
    })
   
}
}

