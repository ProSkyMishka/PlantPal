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
    @State var colorTheme = ColorLight()

    var body: some View {
        
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    SettingsTileView(imageName: "star.fill", text: "Appearance", path: $path, barHidden: $barHidden, index: 0)
                    
                    
                    SettingsTileView(imageName: "app.connected.to.app.below.fill", text: "Connect Device", path: $path, barHidden: $barHidden, index: 1)
                        .disabled(true)

                    
                    SettingsTileView(imageName: "clock.fill", text: "Watering Schedule", path: $path, barHidden: $barHidden, index: 2)
                    
                    
                    SettingsTileView(imageName: "info.circle.fill", text: "About App", path: $path, barHidden: $barHidden, index: 3)
                    
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
                    Text("Connect")
                case 2:
                    WateringScheduleView(barHidden: $barHidden)
                case 3:
                    AppInfoView(barHidden: $barHidden)
                default:
                    Text("AAA")
                }
            }
        }
    }
}


