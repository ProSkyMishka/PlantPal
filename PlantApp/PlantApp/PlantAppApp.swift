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
    // initialise this from UserDefaults if you like
    var locale = Locale(identifier: NSLocale.current.language.languageCode?.identifier ?? "en")
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
