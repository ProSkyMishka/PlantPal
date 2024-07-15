//
//  SettingsDeviceListView.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//

import SwiftUI
import SwiftData

struct SettingsDeviceListView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @Query() var devices: [Device]
    @Binding var barHidden: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            List(devices) {device in
                SettingsDeviceTileView(device: device)
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
                Text("Device Settings")
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
                    barHidden.toggle()
                    dismiss()
                }
            }
        })
    }
}
