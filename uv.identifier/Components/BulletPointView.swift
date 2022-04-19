//
//  BulletPointView.swift
//  uv.identifier
//
//  Created by Tim Baum on 27.03.22.
//

import SwiftUI

/**
 View that represents bullet points with helpful information
 */
struct BulletPointView: View {
    
    var currentTime: Float
    var burnMinutes: Float
    
    let highUV = ["Stay inside", "Seek shadow", "Use sun lotion"]
    let mediumUV = ["Cover your skin", "Wear sunglasses", "Use sun lotion"]
    let lowUV = ["Drink water", "Cover your skin", "Seek shadow"]
    
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading) {
                ForEach(selectUVString(), id: \.self) { statement in
                    Text("• " + statement)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
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
        .fill(Color("DarkBackground"))
        .shadow(radius: 5))
        .padding()
    }
    
    /**
     Select information to display based on time until sunburn
     */
    func selectUVString() -> [String] {
        let minutes = burnMinutes
        if minutes < 60 {
            return highUV
        }
        else if minutes < 120 {
            return mediumUV
        }
        else {
            return lowUV
        }
    }
}
