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
    @StateObject var delegate =  NotificationDelegate()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(languageSettings)
                .environment(\.locale, languageSettings.locale)
                .onAppear {
                    UNUserNotificationCenter.current().delegate = delegate
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error {
                            print(error.localizedDescription)
                        }
                    }
                }
        }
        .modelContainer(for: Plant.self)
    }
}
