//
//  UVManager.swift
//  uv.identifier
//
//  Created by Tim Baum on 18.03.22.
//

import Foundation
import SwiftUI
import UIKit

/**
 This class manages the information about the uv index and the time that it takes to burn.
 It publishes it changes and can be observed. It also holds the color codes.
 */
class UVManager: ObservableObject {
    
    var skinType: SkinType
    var cityname: String? = nil
    @Published var colorCodes: [Color] = []
    @Published var uvTimes: [HourWeather] = [] {
        didSet {
            self.colorCodes = getAllColorCodes()
        }
    }
    
    init(skinType: Int) {
        self.skinType = SkinType(skinType: skinType)
        self.getWeatherInfo()
    }
    
    /**
    Set the skintype
     */
    func setSkinType(newSkinType: Int) -> Void {
        self.skinType = SkinType(skinType: newSkinType)
        self.colorCodes = getAllColorCodes()
    }
    
    /**
     Return the uv index of a certain time or 0 if its empty
     */
    func getUVIndexOfTime(time: Int) -> Float {
        if self.uvTimes != [] {
            return self.uvTimes[time].uv
        }
        else {
            return 0.0
        }
    }
    
    /**
    Calculate the time it takes to get a sunburn by calling the function in skinType with a specific time as String
     */
    func getTimeToBurnOfTime(time: Int) -> String {
        return skinType.getBurnTimeAsString(uvIndex: self.getUVIndexOfTime(time: time))
    }
    
    /**
     Set the location and update the uv information based on it
     */
    func setLocation(cityname: String) -> Void {
        self.cityname = cityname
        self.getWeatherInfo()
    }
    
    /**
    Get the burn time as a string for a specific time
     */
    func getBurnTimeInMinutes(currentTime: Float) -> Float {
        if uvTimes == [] {
            return 0.0
        }
        return skinType.getBurnTimeInMinutes(uvIndex: uvTimes[Int(currentTime)].uv)
    }
    
    /**
    Get the color code of a specific time
     */
    func getColorCodeByTime(currentTime: Float) -> Color {
        if self.uvTimes != [] {
            return getColorCode(minutesToBurn: skinType.getBurnTimeInMinutes(uvIndex: uvTimes[Int(currentTime)].uv))
        } else {
            return .white
        }
    }
    
    /**
     Get the color codes of the whole array of uv times
     */
    func getAllColorCodes() -> [Color] {
        if self.uvTimes == [] {
            return [.red]
        }
        var result: [Color] = []
        for uv in self.uvTimes {
            result.append(getColorCode(minutesToBurn: skinType.getBurnTimeInMinutes(uvIndex: uv.uv)))
        }
        return result
    }
    
    /**
     Return the color codes depending on the time to burn
     */
    private func getColorCode(minutesToBurn: Float) -> Color {
        switch minutesToBurn {
        case 160...Float.greatestFiniteMagnitude:
            return .green
        case 120.0...160.0:
            return .yellow
        case 60.0...120.0:
            return .orange
        case 30.0...60.0:
            return .red
        case 0.0...30.0:
            return Color("Darkred")
        default:
            return .red
        }
    }
    
    /**
    Call UV Information from the API
     */
    private func getWeatherInfo() -> Void {
        if (cityname == nil) {
            return
        }
        else {
            let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=fc0a9dc7caa047a4983162449221803&q=" + cityname! + "&days=1&aqi=no&alerts=no")
            
            let urlRequest = URLRequest(url: url!)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                
                let response = response as! HTTPURLResponse
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        do {
                            let decodedWeatherInfo = try JSONDecoder().decode(WeatherInfoModel.self, from: data)
                            self.uvTimes = decodedWeatherInfo.forecast.forecastday[0].hour                            
                        } catch let error {
                            print("Error decoding ", error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
}
