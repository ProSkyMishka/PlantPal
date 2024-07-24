//
//  NewDeviceView.swift
//  PlantApp
//
//  Created by ProSkyMishka on 12.07.2024.
//

import SwiftUI
import SwiftData

struct NewDeviceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext: ModelContext
    @State var ssid: String = ""
    @State var password: String = ""
    
    var body: some View {
        ScrollView {
            Text("Connect the device for\n   automatic watering.")
                .font(.system(size: 30))
                .foregroundColor(Theme.textBrown)
                .padding(.vertical, 20)
            Text("The device and the phone should be\n connected to the same wifi network")
                .font(.system(size: 17))
                .foregroundColor(Theme.textColor)
            VStack {
                HStack {
                    Text("Wi-Fi SSID")
                        .padding(.horizontal, 20)
                        .foregroundColor(Theme.textGreen)
                    TextField("Value", text: $ssid)
                        .foregroundColor(Theme.textColor)
                }
                Divider()                        .padding(.horizontal, 15)
            }
            .padding(.vertical, 20)
            VStack {
                HStack {
                    Text("Password")
                        .padding(.horizontal, 20)
                        .foregroundColor(Theme.textBrown)
                    TextField("Value", text: $password)
                        .foregroundColor(Theme.textColor)
                }
                Divider()
                    .padding(.horizontal, 15)
            }
            .padding(.bottom, 20)
            Button(action: {
                if !(password.isEmpty || ssid.isEmpty) {
                    ConnectDeviceService.shared.connect(ssid: ssid, password: password, context: modelContext)
                    dismiss()
                }
            }, label: {
                Text("Connect")
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 100)
            })
            .background(Theme.buttonColor)
            .cornerRadius(10)
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        .background(Theme.backGround)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Text("Connect Device")
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
