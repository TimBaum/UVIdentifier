//
//  UVManager.swift
//  uv.identifier
//
//  Created by Tim Baum on 18.03.22.
//

import Foundation
import SwiftUI
import UIKit

@objcMembers class UVManager: ObservableObject {
    
    @State var skinType: SkinType
    @Published var colorCodes: [Color] = []
    @Published var uv_times: [HourWeather] = [] {
        didSet {
            self.colorCodes = getColorCodes()
        }
    }
    
    init() {
        self.skinType = SkinType(skinType: 4)
        self.getWeatherInfo()
    }
    
    func setSkinType(newSkinType: Int) -> Void {
        print(2)
        self.skinType = SkinType(skinType: newSkinType)
        self.colorCodes = getColorCodes()
    }
    
    func getUVIndexOfTime(time: Int) -> Float {
        if self.uv_times != [] {
            return self.uv_times[time].uv
        }
        else {
            return 0.0
        }
    }
    
    func getTimeToBurnOfTime(time: Int) -> String {
        return skinType.getBurnTimeAsString(uvIndex: self.getUVIndexOfTime(time: time))

    }
    
    func getUVIndex() -> Float {
        if self.uv_times != [] {
            return self.uv_times[0].uv
        }
        else {
            return 0.0
        }
    }
    
    func getTimeToBurn() -> String {
        return skinType.getBurnTimeAsString(uvIndex: self.getUVIndex())
    }
    
    func getColorCode(currentTime: Float) -> Color {
        if self.uv_times != [] {
            switch skinType.getBurnTimeInMinutes(uvIndex: uv_times[Int(currentTime)].uv) {
            case 180...Float.greatestFiniteMagnitude:
                return .green
            case 120.0...180.0:
                return .yellow
            case 60.0...120.0:
                return .orange
            case 0.0...60.0:
                return .red
            default:
                return .red
            }
        } else {
            return .white
        }
    }
    
    func getColorCodes() -> [Color] {
        var result: [Color] = []
        if self.uv_times != [] {
            for uv in self.uv_times {
                switch skinType.getBurnTimeInMinutes(uvIndex: uv.uv) {
                case 180...Float.greatestFiniteMagnitude:
                    result.append(.green)
                case 120.0...180.0:
                    result.append(.yellow)
                case 60.0...120.0:
                    result.append(.orange)
                case 0.0...60.0:
                    result.append(.red)
                default:
                    result.append(.red)
                }
            }
        }
        else {
            result = [.red]
        }
        
        return result
    }
    
    func getWeatherInfo() -> Void {
        
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=fc0a9dc7caa047a4983162449221803&q=Granada&days=1&aqi=no&alerts=no")
        
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
                            self.uv_times = decodedWeatherInfo.forecast.forecastday[0].hour
                            
                        } catch let error {
                            print("Error decoding ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}

