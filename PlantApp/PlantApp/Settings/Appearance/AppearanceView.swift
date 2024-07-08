//
//  AppearanceView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct AppearanceView: View {
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {}) {
                    HStack {
                        Text("Language")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Text("Eng")
                            .foregroundColor(.gray)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 10)
                
                Divider()
                
                Button(action: {}) {
                    HStack {
                        Text("Appearance")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Text("Light")
                            .foregroundColor(.gray)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 10)
                
                Divider()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Text("Appearance")
                    .font(.title2)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                    
                    Text("Back")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
                    .onTapGesture {
                    barHidden.toggle()
                    dismiss()
                }
            }
        })
        .padding()
        .edgesIgnoringSafeArea(.bottom)
    }
}
