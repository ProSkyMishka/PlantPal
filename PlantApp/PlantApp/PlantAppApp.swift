//
//  PlantAppApp.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI
import SwiftData

@Observable
class LanguageSetting {
    
    init() {
        var lang = UserDefaults.standard.value(forKey: "Language")
        if (lang == nil) {
            lang = NSLocale.current.language.languageCode?.identifier ?? "en"
        }
        
        locale = Locale(identifier: lang as! String)
    }
    
    var locale: Locale
}

@main
struct PlantAppApp: App {
    @State var languageSettings = LanguageSetting()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(languageSettings)
                .environment(\.locale, languageSettings.locale)
        }
        .modelContainer(for: Plant.self)
    }
}
