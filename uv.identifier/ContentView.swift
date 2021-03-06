//
//  ContentView.swift
//  uv.identifier
//
//  Created by Tim Baum on 17.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var uvManager = UVManager(skinType: 1)
    let languageManager = LanguageManagager()
    
    //@State var currentLanguage = "πΊπΈ"
    @AppStorage("currentSkinType") var currentSkinType = "ππ» - Skin Type 1"
    @AppStorage("currentNotification") var currentNotification = "π - Off"
    
    let notificationManager = NotificationManager(activatedNotification: 0)
    
    @State var currentTime: Float
    
    let skinTypes = ["ππ» - Skin Type 1", "ππ» - Skin Type 2", "ππΌ - Skin Type 3", "ππ½ - Skin Type 4", "ππΎ - Skin Type 5", "ππΏ - Skin Type 6"]
    
    init() {
        //Current time
        let date = Date()
        let calendar = Calendar.current
        currentTime = Float(calendar.component(.hour, from: date))
        //Set skin type based on last status or skintype 1
        uvManager.setSkinType(newSkinType: skinTypes.firstIndex(of: UserDefaults.standard.string(forKey: "currentSkinType") ?? "ππ» - Skin Type 1")! + 1)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Blue2"), Color("Blue1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            
            ScrollView{
                
                VStack {
                    VStack {
                        Text("π " + (locationManager.city ?? "-") + ",")
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
                    
                    BulletPointView(burnMinutes: uvManager.getBurnTimeInMinutes(currentTime: currentTime))
                    SliderView(uvManager: uvManager, currentTime: $currentTime)
                    
                    DividerWhite()
                    
                    Spacer()
                    
                    HStack {
                        //  settingsTile(icon: "πΊπΈ", options: languageManager.languages, selection: $currentLanguage)
                        //  Spacer()
                        settingsTile(icon: "π", options: skinTypes, selection: $currentSkinType)
                        settingsTile(icon: "π", options: notificationManager.notificationDescriptions, selection: $currentNotification)
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
        .onChange(of: uvManager.uvTimes) {_ in
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
 Divider styling
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
