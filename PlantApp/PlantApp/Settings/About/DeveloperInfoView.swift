//
//  DeveloperInfoView.swift
//  PlantApp
//
//  Created by ProSkyMishka on 08.07.2024.
//

import SwiftUI

struct DeveloperInfoView: View {
    let num: Int
    let name: String
    let gitLink: String
    let tgLink: String
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(name))
                .font(.system(size: 22))
                .foregroundColor(Theme.textColor)
                .padding(.leading, 15)
            Spacer()
            Link(destination: URL(string: gitLink)!, label: {
                Image("GithubLogo")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(17)
                    
            })
            
            Link(destination: URL(string: tgLink)!, label: {
                Image("TGLogo")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 15)
                    
            })
        }
    }
}
