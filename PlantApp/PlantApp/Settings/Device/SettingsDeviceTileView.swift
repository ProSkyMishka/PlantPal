//
//  SettingsDeviceTileView.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//


import SwiftUI
import SwiftData

struct SettingsDeviceTileView: View {
    @Bindable var device: Device
    @Environment(\.modelContext) var modelContext: ModelContext
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(device.deviceId)
                    .bold()
                    .font(.system(size: 22))
                    .foregroundColor(Theme.textBlue)
                
                Text("Watering plants: \(device.plants.count)")
                    .font(.system(size: 16))
                    .foregroundColor(Theme.textBlue)
            }
            
            Spacer()
            
            Menu {
                if (!device.plants.isEmpty) {
                    ForEach(device.plants) {p in
                        Text(p.name)
                    }
                }
                else {
                    Text("There are no plants watering this device")
                }
            } label: {
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Theme.textAzure)
            }
            
//            if device.id !=
            Image(systemName: "trash.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(device.deviceId == "default" ? .gray : .red)
                .onTapGesture {
                    if device.deviceId != "default" {
                        modelContext.delete(device)
                    }
                }
            
        }
        .background(Theme.backGround)
    }
}

