//
//  NewDeviceView.swift
//  PlantApp
//
//  Created by Lucy Rez on 12.07.2024.
//

import SwiftUI

struct NewDeviceView: View {
    @Binding var barHidden: Bool
    @State var ssid: String = "";
    @State var password: String = "";
    
    var body: some View {
        ScrollView {
            Text("Connect the device for\n   automatic watering.")
                .font(.system(size: 30))
                .padding(.vertical, 20)
            Text("The device and the phone should be\n connected to the same wifi network")
                .font(.system(size: 18))
                .foregroundColor(Color.gray)
            VStack {
                HStack {
                    Text("Wi-Fi SSID")
                        .padding(.horizontal, 20)
                    TextField("Value", text: $ssid)
                }
                Divider()                        .padding(.horizontal, 15)
            }
            .padding(.vertical, 20)
            VStack {
                HStack {
                    Text("Password")
                        .padding(.horizontal, 20)
                    TextField("Value", text: $password)
                }
                Divider()
                    .padding(.horizontal, 15)
            }
            .padding(.bottom, 20)
            Button(action: {}, label: {
                Text("Connect")
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 100)
            })
            .background(Color.blue)
            .cornerRadius(10)
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        .background(Theme.backGround)
        .navigationTitle("Connect device")
        .navigationBarTitleDisplayMode(.inline)
    }
}
