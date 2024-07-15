//
//  SettingsView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var barHidden: Bool
    @Binding var path: NavigationPath
    @Binding var index: Int

    var body: some View {
        
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    SettingsTileView(imageName: "star.fill", text: "Appearance", path: $path, barHidden: $barHidden, index: 0)
                    
                    
                    SettingsTileView(imageName: "clock.fill", text: "Watering Schedule", path: $path, barHidden: $barHidden, index: 1)
                    
                    
                    SettingsTileView(imageName: "info.circle.fill", text: "About App", path: $path, barHidden: $barHidden, index: 2)
                    
                    
                    SettingsTileView(imageName: "microbe.fill", text: "Find out if your plant is sick", path: $path, barHidden: $barHidden, index: 3)
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://www.youtube.com/watch?v=TrulJjLqBqM")!, label: {
                        Text ("     ")
                            .padding()
                    })
                }
            }
            .padding([.top, .bottom], 10)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Settings")
                        .font(.title2)
                        .foregroundColor(Theme.textGreen)
                }
            })
            .background(Theme.backGround)
            .navigationDestination(for: Int.self) {path in

                switch (path) {
                case 0:
                    AppearanceView(barHidden: $barHidden)
                case 1:
                    WateringScheduleView(barHidden: $barHidden)
                case 2:
                    AppInfoView(barHidden: $barHidden)
                case 3:
                    SickPlantView(barHidden: $barHidden, index: $index)
                default:
                    Text("AAA")
                }
            }
        }
    }
}


