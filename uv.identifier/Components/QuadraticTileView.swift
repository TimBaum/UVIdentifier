//
//  QuadraticTileView.swift
//  uv.identifier
//
//  Created by Tim Baum on 27.03.22.
//

import SwiftUI

/**
 Quadratic tile, that displays information
 */
struct QuadraticTileView: View {
    
    let title: String
    var content: String
    var color: Color = .white
    
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
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .shadow(radius: 5)
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
            .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}

