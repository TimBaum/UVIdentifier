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

struct HourWeather: Codable, Equatable {
    var time: String
    var uv: Float
}
