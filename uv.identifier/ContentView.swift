//
//  ContentView.swift
//  uv.identifier
//
//  Created by Tim Baum on 17.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @ObservedObject var uvManager = UVManager(skinType: 1)
    let languageManager = LanguageManagager()
    
    //@State var currentLanguage = "🇺🇸"
    @AppStorage("currentSkinType") var currentSkinType = "👋🏻 - Skin Type 1"
    @AppStorage("currentNotification") var currentNotification = "🛎 - Off"
    
    let notificationManager = NotificationManager(activatedNotification: 0)
    
    @State var currentTime: Float
    
    let skinTypes = ["👋🏻 - Skin Type 1", "👋🏻 - Skin Type 2", "👋🏼 - Skin Type 3", "👋🏽 - Skin Type 4", "👋🏾 - Skin Type 5", "👋🏿 - Skin Type 6"]
    
    init() {
        //Current time
        let date = Date()
        let calendar = Calendar.current
        currentTime = Float(calendar.component(.hour, from: date))
        //Set skin type based on last status or skintype 1
        uvManager.setSkinType(newSkinType: skinTypes.firstIndex(of: UserDefaults.standard.string(forKey: "currentSkinType") ?? "👋🏻 - Skin Type 1")! + 1)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Blue2"), Color("Blue1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            
            ScrollView{
                
                VStack {
                    VStack {
                        Text("📍 " + (locationManager.city ?? "-") + ",")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text(locationManager.country ?? "-")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(RoundedRectangle(
                        cornerRadius: 10
                    )
                        .fill(Color("LightBackground"))
                        .shadow(radius: 5))
                    .padding(.top)
                    
                    
                    
                    DividerWhite()
                    
                    HStack {
                        QuadraticTileView(title: "Time to sunburn", content: uvManager.getTimeToBurnOfTime(time: Int(currentTime)), color: uvManager.getColorCodeByTime(currentTime: currentTime))
                        
                        QuadraticTileView(title: "UV-Index", content: NSString(format: "%.0f", uvManager.getUVIndexOfTime(time: Int(currentTime))) as String, color: uvManager.getColorCodeByTime(currentTime: currentTime))
                    }
                    
                    BulletPointView(currentTime: currentTime, burnMinutes: uvManager.getBurnTimeInMinutes(currentTime: currentTime))
                    SliderView(uvManager: uvManager, currentTime: $currentTime)
                    
                    DividerWhite()
                    
                    Spacer()
                    
                    HStack {
                        //                    settingsTile(icon: "🇺🇸", options: languageManager.languages, selection: $currentLanguage)
                        //                    Spacer()
                        settingsTile(icon: "👋", options: skinTypes, selection: $currentSkinType)
                        settingsTile(icon: "🛎", options: notificationManager.notificationDescriptions, selection: $currentNotification)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            //Check for location services
            locationManager.checkIfLocationServicesIsEnabled()
        }
        .onChange(of: currentSkinType) { value in
            //Update skin type on change
            uvManager.setSkinType(newSkinType: skinTypes.firstIndex(of: value)! + 1)
        }
        .onChange(of: locationManager.city) { value in
            //Update location on change of the city
            uvManager.setLocation(cityname: value!)
        }
        .onChange(of: currentNotification) { value in
            //Update notification settings on change of prefered notification
            notificationManager.enableNotifications(newNotification: notificationManager.notificationDescriptions.firstIndex(of: value)!, uvManager: uvManager)
        }
        .onChange(of: uvManager.uv_times) {_ in
            //Update notifications when the available information about the uv index changes
            notificationManager.enableNotifications(newNotification: notificationManager.notificationDescriptions.firstIndex(of: currentNotification)!, uvManager: uvManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/**
 Divider style
 */
struct DividerWhite: View {
    var body: some View {
        Divider()
            .opacity(0)
            .frame(height: 1.0)
            .background(Color("LightBackground"))
            .padding()
    }
}

/**
 Settings tile
 */
struct settingsTile: View {
    let icon: String
    let options: [String]
    
    @Binding var selection: String
    
    var body: some View {
        
        VStack{
            Menu {
                Picker(icon, selection: $selection){
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .labelsHidden()
                .pickerStyle(InlinePickerStyle())
            } label: {
                Text(selection)
                    .foregroundColor(.black)
                    .font(.body)
                    .padding()
            }
            .background(RoundedRectangle(
                cornerRadius: 10
            )
                .fill(Color("LightBackground"))
                .shadow(radius: 5)
            )
        }
    }
}
