//
//  SettingsTileView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct SettingsTileView: View {
    let imageName: String
    let text: String
    @Binding var path: NavigationPath
    @Binding var barHidden: Bool
    let index: Int
    
    var body: some View {
        
        VStack {
            Button(action: {
                barHidden.toggle()
                path.append(index)
            }) {
                HStack {
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Theme.icon)
                    
                    Text(LocalizedStringKey(text))
                        .foregroundColor(Theme.textBrown)
                        .font(.system(size: 20))
                    
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(Theme.textBrown)
                }
            }
            .padding(.all, 10)
            
            Divider()
        }
    }
}
