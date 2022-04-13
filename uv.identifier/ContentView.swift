//
//  ContentView.swift
//  uv.identifier
//
//  Created by Tim Baum on 17.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @ObservedObject var uvManager = UVManager()
    let languageManager = LanguageManagager()
    
    @State var currentLanguage = "🇺🇸"
    @State var currentSkinType = "👋🏻 - Skin Type 1"
    {
        didSet {
            print(2)
            uvManager.setSkinType(newSkinType: skinTypes.firstIndex(of: currentSkinType)! + 1)
        }
    }
    @State var currentNotification = "always"

    
    @State var currentTime: Float = 18.0
    
    let skinTypes = ["👋🏻 - Skin Type 1", "👋🏻 - Skin Type 2", "👋🏼 - Skin Type 3", "👋🏽 - Skin Type 4", "👋🏾 - Skin Type 5", "👋🏿 - Skin Type 6"]
    let notifications = ["always"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Blue1"), Color("Blue2")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                VStack {
                    Text("📍 " + (locationManager.city ?? "-") + "," + currentSkinType)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(locationManager.country ?? "-")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding()
                .background(RoundedRectangle(
                    cornerRadius: 10
                )
                .fill(Color("LightBackground")))
                .padding(.top)

                
                DividerWhite()
                
                HStack {
                    QuadraticTileView(title: "Time until sunburn", content: uvManager.getTimeToBurnOfTime(time: Int(currentTime)), color: uvManager.getColorCode(currentTime: currentTime))
                    QuadraticTileView(title: "UV-Index", content: NSString(format: "%.0f", uvManager.getUVIndexOfTime(time: Int(currentTime))) as String, color: uvManager.getColorCode(currentTime: currentTime))
                }
                
                BulletPointView()
                SliderView(uvManager: uvManager, currentTime: $currentTime)
                
                Text(String(currentTime))
                
                DividerWhite()
                
                HStack {
                    settingsTile(icon: "🇺🇸", options: languageManager.languages, selection: $currentLanguage)
                    Spacer()
                    settingsTile(icon: "👋", options: skinTypes, selection: $currentSkinType)
                    Spacer()
                    settingsTile(icon: "🛎", options: notifications, selection: $currentNotification)
                }
                .padding(.leading)
                .padding(.trailing)
                Spacer()
            }
        }
        .onAppear {
            locationManager.checkIfLocationServicesIsEnabled()
            let date = Date()
            let calendar = Calendar.current
            
            currentTime = Float(calendar.component(.hour, from: date))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DividerWhite: View {
    var body: some View {
        Divider()
        .opacity(0)
        .frame(height: 1.0)
        .background(Color("LightBackground"))
        .padding()
    }
}

struct settingsTile: View {
    let icon: String
    let options: [String]
    
    @Binding var selection: String
    
    var body: some View {
    
        VStack{
            Picker(icon, selection: $selection){
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .background(RoundedRectangle(
                cornerRadius: 10
                )
            .fill(Color("LightBackground")))
        }
    }
}
