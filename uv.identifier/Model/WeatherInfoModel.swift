//
//  WeatherInfoModel.swift
//  uv.identifier
//
//  Created by Tim Baum on 19.03.22.
//

import Foundation

/**
 Based on the JSON that is returned from the server. 
 */
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
    
    var time: String
    var uv: Float
    
    //Needed to find the max
    static func < (lhs: HourWeather, rhs: HourWeather) -> Bool {
        if lhs.uv < rhs.uv {
            return true
        } else {
            return false
        }
    }
    
    /**
     Get the hour from a given date String
     */
    func getHour() -> Int {
        var res = self.time.split(separator: " ")[1]
        res = res.split(separator: ":")[0]
        return Int(res) ?? 0
    }
}
