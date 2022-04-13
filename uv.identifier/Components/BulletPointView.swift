//
//  BulletPointView.swift
//  uv.identifier
//
//  Created by Tim Baum on 27.03.22.
//

import SwiftUI

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
