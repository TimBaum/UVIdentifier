//
//  LanguageManager.swift
//  uv.identifier
//
//  Created by Tim Baum on 11.04.22.
//

import Foundation

class LanguageManagager {
    let languages = ["🇺🇸", "🇪🇸", "🇩🇪"]
    @Published var currentLanguage = "🇺🇸"
    
    func setCurrentLanguage(selection: String) -> Void {
        currentLanguage = selection
    }
    
}
