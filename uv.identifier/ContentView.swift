//
//  ContentView.swift
//  uv.identifier
//
//  Created by Tim Baum on 17.03.22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Blue1"), Color("Blue2")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                VStack {
                    Text("Granada")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("España")
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
                HStack{
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
                }
                .padding()
                .background(RoundedRectangle(
                    cornerRadius: 10
                )
                .fill(Color("DarkBackground")))
                .padding()
                
                Spacer()
            }
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
        .frame(width: 150, height: 150)
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
