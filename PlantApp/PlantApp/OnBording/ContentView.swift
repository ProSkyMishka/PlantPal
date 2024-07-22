//
//  ContentView.swift
//  PlantApp
//
//  Created by Михаил Прозорский on 22.07.2024.
//

import SwiftUI

struct ContentView: View {
    let pages = [
        OnBoardingD(image: "", height: 100, width: 100, title: "Hello! This is a Plant Pal application", description: "Let's get started with the app!"),
        OnBoardingD(image: "", height: 100, width: 100, title: "Let's get acquainred with the feature of the application", description: ""),
        OnBoardingD(image: "info.circle.fill", height: 100, width: 100, title: "Info", description: "Learn more useful information"),
        OnBoardingD(image: "list.bullet.clipboard.fill", height: 100, width: 90, title: "Collection", description: "You will be able to store and replenish your collection of plants"),
        OnBoardingD(image: "drop.fill", height: 100, width: 70, title: "Care", description: "You will be able to take care of plants remotely"),
        OnBoardingD(image: "externaldrive.fill.badge.exclamationmark", height: 100, width: 120, title: "IT IS IMPORTANT!", description: "To use the program, you need to install a smart watering device")
    ]
    
    
    var languageCode: String? { Locale.autoupdatingCurrent.language.languageCode?.identifier }
    var localeCode: String? { Locale.autoupdatingCurrent.identifier }
//    var isRussianLanguage: Bool { languageCode == "ru" }
    var isRussianLanguage: Bool { locale.language.languageCode!.identifier == "ru" }
    @Environment(\.locale) var locale: Locale
    var lang = { Locale.autoupdatingCurrent.language.languageCode?.identifier }
    
    
    @State private var currentPage = 0;
    @Environment (\.dismiss) var dismiss
    @Binding var onboardingDone: Bool;
    var body: some View {
        VStack {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count) { index in
                        OnBordingV(data: pages[index]).tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .background(Theme.backGround)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            Spacer()
            HStack {
                if (currentPage > 0) {
                    Button(action: {currentPage -= 1}, label: {
                        Text("Back")
                            .font(.system(size: 24))
                            .foregroundColor(Theme.buttonColor)
                            .padding(.horizontal, 50)
                    })
                }
                Spacer()
                if (currentPage < pages.count - 1) {
                    Button(action: {currentPage += 1}, label: {
                        Text(LocalizedStringKey("Next"))
                            .font(.system(size: 24))
                            .foregroundColor(Theme.buttonColor)
                            .padding(.horizontal, 50)
                    })
                }
                if (currentPage == pages.count - 1){
                    Button(action: {
                        dismiss()
                        onboardingDone = true
                        UserDefaults.standard.set(true, forKey: "onboardingDone")
                    }){
                        Text(LocalizedStringKey("Start working!"))
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.horizontal, 50)
                            
                    }.background(Theme.textAzure)
                        .cornerRadius(22)
                        .padding(.trailing, 15)
                }
            }
        }.background(Theme.backGround)
    }
}

