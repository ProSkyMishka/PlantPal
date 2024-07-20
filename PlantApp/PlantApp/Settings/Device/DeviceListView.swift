//
//  DeviceListView.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//

import SwiftUI
import SwiftData

struct DeviceListView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @Query() var devices: [Device]
    @Bindable var plant: Plant
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            List(devices) {device in
                DeviceTileView(device: device, plant: plant)
                    .listRowBackground(Theme.backGround)
            }
            .scrollContentBackground(.hidden)
            .background(Theme.backGround)
            
            NavigationLink {
                NewDeviceView()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Theme.buttonColor)
            }
            .padding()
        }
        .toolbarBackground(Theme.backGround, for: .automatic)
        .scrollContentBackground(.hidden)
        .background(Theme.backGround)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Text("Change Device")
                    .foregroundColor(Theme.textGreen)
                    .font(.title2)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Theme.icon)
                    Text("Back")
                        .font(.system(size: 20))
                        .foregroundColor(Theme.icon)
                }
                .onTapGesture {
                    dismiss()
                }
            }
        })
    }
}
