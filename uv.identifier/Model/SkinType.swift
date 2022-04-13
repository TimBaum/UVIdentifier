//
//  SkinType.swift
//  uv.identifier
//
//  Created by Tim Baum on 18.03.22.
//

import Foundation

class SkinType {
    var skinTypeNumber: Int
    
    init(skinType: Int) {
        self.skinTypeNumber = skinType
    }
    
    func getBurnTimeInMinutes(uvIndex: Float) -> Float {
        return getMultiplier() * 200.0 / (3.0 * uvIndex)
    }
    
    func getBurnTimeAsString(uvIndex: Float) -> String {
        let minutes = getBurnTimeInMinutes(uvIndex: uvIndex)
        if minutes > 60 {
            var hours = minutes/60
            hours.round(.down)
            return NSString(format: "%.0f", hours) as String + "h"
        }
        else {
            return NSString(format: "%.0f", minutes) as String + "m"
        }
    }
    
    private func getMultiplier() -> Float{
        switch skinTypeNumber {
        case 1:
            return 2.5
        case 2:
            return 3
        case 3:
            return 4
        case 4:
            return 5
        case 5:
            return 8
        case 6:
            return 15
        default:
            return 1
        }
    }
    
}
