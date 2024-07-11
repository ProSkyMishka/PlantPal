//
//  TabBar.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct TabBar: View {
    @Binding var index: Int
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width / 4) {
            Button(action: {
                index = 0
            }){
                Image(systemName: index == 0 ? "leaf.fill" : "leaf")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .tint(.black)
            
            Button(action: {
                index = 1
            }) {
                Image(systemName: index == 1 ? "plus.app.fill" : "plus.app")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .tint(.black)
            
            Button(action: {
                index = 2
            }) {
                Image(systemName: index == 2 ? "gearshape.fill" : "gearshape")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .tint(.black)
        }
        .padding()
//        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
        
        .background(Theme.tabBar)
        .cornerRadius(30)
        .shadow(radius: 10)
    }
}
