//
//  DeveloperInfoView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
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
            
            Link(destination: URL(string: gitLink)!, label: {
                Image("GithubLogo")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
            
            Link(destination: URL(string: tgLink)!, label: {
                Image("TGLogo")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
        }
    }
}
