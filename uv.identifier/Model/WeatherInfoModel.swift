//
//  WeatherInfoModel.swift
//  uv.identifier
//
//  Created by Tim Baum on 19.03.22.
//

import Foundation

struct WeatherInfoModel: Codable {
    let id = UUID()
    var forecast: Forecast
    
    struct Forecast: Codable {
        var forecastday: [Hour]
        
            struct Hour: Codable {
                var hour: [HourWeather]
            }
        }
    }

struct HourWeather: Codable, Equatable, Comparable {
    static func < (lhs: HourWeather, rhs: HourWeather) -> Bool {
        if lhs.uv < rhs.uv {
            return true
        } else {
            return false
        }
    }
    
    func getHour() -> Int {
        var res = self.time.split(separator: " ")[1]
        res = res.split(separator: ":")[0]
        return Int(res) ?? 0
    }
    
    var time: String
    var uv: Float
}
