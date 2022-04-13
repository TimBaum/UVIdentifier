////
////  APICaller.swift
////  uv.identifier
////
////  Created by Tim Baum on 25.03.22.
////
//
//import Foundation
//
//class APICaller: ObservableObject {
//    
//    func getWeatherInfo() -> [HourWeather] {
//        
//        var uv_times: [HourWeather] = []
//        
//        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=fc0a9dc7caa047a4983162449221803&q=Granada&days=1&aqi=no&alerts=no")
//        
//        let urlRequest = URLRequest(url: url!)
//        
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//            
//            let response = response as! HTTPURLResponse
//            
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                    DispatchQueue.main.async {
//                        do {
//                            let decodedWeatherInfo = try JSONDecoder().decode(WeatherInfoModel.self, from: data)
//                            uv_times = decodedWeatherInfo.forecast.forecastday[0].hour
//                        } catch let error {
//                            print("Error decoding ", error)
//                    }
//                }
//            }
//        }
//        dataTask.resume()
//    }
//}
