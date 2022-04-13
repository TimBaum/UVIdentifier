//
//  SliderView.swift
//  uv.identifier
//
//  Created by Tim Baum on 27.03.22.
//

import SwiftUI

struct SliderView: View {
    
    @ObservedObject var uvManager: UVManager
    
    @State private var speed = 50.0
    @State private var isEditing = false
    
    @Binding var currentTime: Float
        
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
                    .fill(LinearGradient(gradient: Gradient(colors: uvManager.getColorCodes()), startPoint: .leading, endPoint: .trailing))
                    .frame(height: barHeight)
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
                
                UISliderView(value: $currentTime)
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
    
    @Binding var value: Float

    var thumbColor: UIColor = .white

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        
        let slider_image = UIImage(named: "Opacity Slider")
        
        slider.setThumbImage(slider_image, for: UIControl.State
            .normal)
        slider.minimumTrackTintColor = UIColor(white: 1, alpha: 0)
        slider.maximumTrackTintColor = UIColor(white: 1, alpha: 0)
        slider.minimumValue = 0
        slider.maximumValue = 23
                
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }
}
