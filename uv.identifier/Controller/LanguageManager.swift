//
//  LanguageManager.swift
//  uv.identifier
//
//  Created by Tim Baum on 11.04.22.
//

import Foundation

class LanguageManagager {
    let languages = ["πΊπΈ", "πͺπΈ", "π©πͺ"]
    @Published var currentLanguage = "πΊπΈ"
    
    func setCurrentLanguage(selection: String) -> Void {
        currentLanguage = selection
    }
    
}
