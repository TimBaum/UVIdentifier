//
//  SkinType.swift
//  uv.identifier
//
//  Created by Tim Baum on 18.03.22.
//

import Foundation

/**
 This class represents the skintype of a person. It is based on Fitzgerald.
 */
class SkinType {
    //Can range from 1 to 6
    var skinTypeNumber: Int
    
    init(skinType: Int) {
        precondition(skinType >= 1 && skinType <= 6, "Skin Type doesn't exist")
        self.skinTypeNumber = skinType
    }
    
    /**
     Return the time to get a sunburn
     */
    func getBurnTimeInMinutes(uvIndex: Float) -> Float {
        return getMultiplier() * 200.0 / (3.0 * uvIndex)
    }
    
    /**
     Returns the time to burn in a readable string
     */
    func getBurnTimeAsString(uvIndex: Float) -> String {
        if uvIndex == 1.0 {
            return "∞"
        }
        let minutes = getBurnTimeInMinutes(uvIndex: uvIndex)
        if minutes > 60 {
            let hours = minutes/60
            return NSString(format: "%.1f", hours) as String + "h"
        }
        else {
            return NSString(format: "%.0f", minutes) as String + "m"
        }
    }
    
    /**
     Return the multiplier for each skintype
     */
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
