//
//  ContentView.swift
//  uv.identifier
//
//  Created by Tim Baum on 17.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Blue1"), Color("Blue2")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                VStack {
                    Text((locationManager.city ?? "-") + ",")
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
                .padding(.top, 5)
                
                
                HStack {
                    QuadraticView(title: "Time to burn", content: "15m")
                    QuadraticView(title: "UV-Index", content: "7")
                }
                //Text section
                BulletPointView()
                SliderView()
                
                Spacer()
            }
        }
        .onAppear {
            locationManager.checkIfLocationServicesIsEnabled()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct QuadraticView: View {
    
    let title: String
    let content: String
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    print("Edit button was tapped")
                } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                    .font(.title2)
                }
            }
            Spacer()
            HStack {
                Spacer()
                Text(content)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(width: 160, height: 160)
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(Color("DarkBackground"))
            .aspectRatio(1.0, contentMode: .fit)
        )
        .padding()
    }
}

struct BulletPointView: View {
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading) {
                Text("• Stay inside")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("• Wear sunglasses")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("• Use suncream")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            Spacer()
            Button {
                print("Button")
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
        .padding()
        .background(RoundedRectangle(
            cornerRadius: 10
        )
        .fill(Color("DarkBackground")))
        .padding()
    }
}

struct SliderView: View {
    
    @State private var speed = 50.0
    @State private var isEditing = false
    
    private let barHeight = 28.0

    
    var body: some View {
        
        VStack{
            HStack(alignment: .top){
                Text("Time:")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer()
                Button {
                    print("Button")
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 18)
                    .frame(height: barHeight)
                    .foregroundColor(.green)
                //Dividers
                HStack{
                    Divider()
                        .padding(.leading, 75)
                        .frame(height: barHeight)
                    Spacer()
                    Divider()
                        .frame(height: barHeight)
                    Spacer()
                    Divider()
                        .frame(height: barHeight)
                    Spacer()
                    Divider()
                        .padding(.trailing, 75)
                        .frame(height: barHeight)
                }
                /**
                 Circle()
                     .stroke(Color.white, lineWidth: 3)
                     .frame(height:29)
                     .foregroundColor(.white)
                     .shadow(radius: 3)
                 */
                
                UISliderView(value: 24)
                
            }
            
            HStack(alignment: .top, spacing: 45){
                Text("0")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    
                
                Text("6")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("12")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Text("18")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("24")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        }
        .padding()
        .background(RoundedRectangle(
            cornerRadius: 10
        )
        .fill(Color("DarkBackground")))
        .padding()
        
    }
}

struct UISliderView: UIViewRepresentable {
    @State var value: Float

    var thumbColor: UIColor = .white

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        
        let slider_image = UIImage(named: "Opacity Slider")
        
        slider.setThumbImage(slider_image, for: UIControl.State
            .normal)
        slider.minimumTrackTintColor = UIColor(white: 1, alpha: 0)
        slider.maximumTrackTintColor = UIColor(white: 1, alpha: 0)
        slider.minimumValue = 0
        slider.maximumValue = 24
        
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }
}
