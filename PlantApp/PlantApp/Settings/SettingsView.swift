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
                    SettingsTileView(imageName: "person.crop.circle", text: "Profile", path: $path, barHidden: $barHidden, index: 5)

                    SettingsTileView(imageName: "yandex", text: "Yandex devices", path: $path, barHidden: $barHidden, index: 6)
                    
                    SettingsTileView(imageName: "star.fill", text: "Appearance", path: $path, barHidden: $barHidden, index: 0)
                    
                    SettingsTileView(imageName: "app.connected.to.app.below.fill", text: "Device Settings", path: $path, barHidden: $barHidden, index: 1)
                    
                    
                    SettingsTileView(imageName: "clock.fill", text: "Watering Schedule", path: $path, barHidden: $barHidden, index: 2)
                    
                    
                    SettingsTileView(imageName: "microbe.fill", text: "Find out if your plant is sick", path: $path, barHidden: $barHidden, index: 4)
                    
                    
                    SettingsTileView(imageName: "info.circle.fill", text: "About App", path: $path, barHidden: $barHidden, index: 3)

                    
                    Spacer()
                    
//                    Link(destination: URL(string: "https://www.youtube.com/watch?v=TrulJjLqBqM")!, label: {
//                        Text ("     ")
//                            .padding()
//                    })
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
                    SettingsDeviceListView(barHidden: $barHidden)
                case 2:
                    WateringScheduleView(barHidden: $barHidden)
                case 3:
                    AppInfoView(barHidden: $barHidden)
                case 4:
                    SickPlantView(barHidden: $barHidden)
                case 5:
                    Profile(barHidden: $barHidden, isLogged: .constant(false))
                case 6:
                    DevicesView(barHidden: $barHidden)
                default:
                    Text("AAA")
                }
            }
        }
    }
}


