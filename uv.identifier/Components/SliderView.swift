//
//  SliderView.swift
//  uv.identifier
//
//  Created by Tim Baum on 27.03.22.
//

import SwiftUI

/**
 Represents the slider. Slider does only display the UV intensity over the day and doesnt actually implement any functionality
 */
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
                    .fill(LinearGradient(gradient: Gradient(colors: uvManager.getAllColorCodes()), startPoint: .leading, endPoint: .trailing))
                    .frame(height: barHeight)
                    .shadow(radius: 5)
                //Dividers
                HStack{
                    Divider()
                        .opacity(0)
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                        .opacity(0)
                }
                .frame(height: barHeight)
                
                UISliderView(value: $currentTime)
            }
            
            HStack {
                Text("00")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Spacer()
                    .foregroundColor(.white)
                
                Text("12")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Spacer()

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
            .fill(Color("DarkBackground"))
            .shadow(radius: 5))
        .padding(.horizontal)
        
    }
}

/**
 Customisable slider 
 */
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

struct SliderViewPreview: PreviewProvider {
    static var previews: some View {
        SliderView(uvManager: UVManager(skinType: 2), currentTime: .constant(10.0))
    }
}
