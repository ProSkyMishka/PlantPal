//
//  DeviceTileView.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//

import SwiftUI

struct DeviceTileView: View {
    @Bindable var device: Device
    @Bindable var plant: Plant
    
    var body: some View {
        HStack {
            
            Text(device.ssid)
                .bold()
                .font(.system(size: 22))
                .foregroundColor(Theme.textBlue)
            
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
            
            if (plant.device == device) {
                Button {
                    plant.device = nil
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                }
            } else {
                Button {
                    plant.device = device
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Theme.textGreen)
                }
            }
        }
        .background(Theme.backGround)
    }
}


