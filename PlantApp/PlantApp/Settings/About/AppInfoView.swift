//
//  AppInfoView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct AppInfoView: View {
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    
    let developers = [["Bazin Aleksey", "https://t.me/mathusha2023", "https://github.com/mathusha2023"],
                      ["Naypert Roman", "https://t.me/Artecka", "https://github.com/RomaNaybert"],
    ["Kondratieva Margarita", "https://t.me/Atira_gram", "https://github.com/qrstMARITAqrst"],
                      ["Loskutov Alexsandr", "https://t.me/re3perbtw", "https://github.com/re3perR"],
    ["Vasilievsky Arthur", "https://t.me/contact/1720364209:CMYP2cnrZmGLaPiP", "https://github.com/mauer2008"]]
    
    let bosses = [["Rezunik Lyudmila", "https://t.me/lucy_r", "https://github.com/LucyRez"], ["Prozorskiy Mikhail", "https://t.me/michail_prozorskiy", "https://github.com/ProSkyMishka"]]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("      This application was created as part of the All-Russian competition of scientific and technological projects \"Great Challenges\". The project partner is the National Research University Higher School of Economics. The application allows you to maintain a collection of your own plants and water them remotely.")
                    .font(.system(size: 20))
                    .lineSpacing(15)
                    .padding(.bottom, 30)
                    .foregroundColor(Theme.textColor)
                
                Text("Developers:")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(Theme.textBrown)
                
                ForEach(0...(developers.count - 1), id: \.self) {num in
                    DeveloperInfoView(num: num + 1, name: developers[num][0], gitLink: developers[num][2], tgLink:  developers[num][1])
                }
                
                Text("Bosses:")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.top)
                    .foregroundColor(Theme.textBrown)
                
                ForEach(0...(bosses.count - 1), id: \.self) {num in
                    DeveloperInfoView(num: num + 1, name: bosses[num][0], gitLink: bosses[num][2], tgLink:  bosses[num][1])
                }
                
                Text("Partner:")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.top)
                    .foregroundColor(Theme.textBrown)
                
                Image("SiriusLogo")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                    .padding(.bottom)
                    .foregroundColor(Theme.textBrown)
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Text("App Info")
                    .font(.title2)
                    .foregroundColor(Theme.textGreen)
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
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        .background(Theme.backGround)

    }
}
