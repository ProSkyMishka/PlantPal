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
            Text("\(num). \(name)")
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

struct DeveloperInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperInfoView(num: 1, name: "Test name", gitLink: "github.com", tgLink: "t.me/test")
    }
}
