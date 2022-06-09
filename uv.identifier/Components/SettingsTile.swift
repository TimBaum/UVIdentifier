//
//  SettingsTile.swift
//  uv.identifier
//
//  Created by Tim Baum on 05.06.22.
//

import SwiftUI

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
