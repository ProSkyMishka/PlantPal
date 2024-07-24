//
//  AppInfoView.swift
//  PlantApp
//
//  Created by ProSkyMishka on 08.07.2024.
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
    
    let bosses = [["Aleksandrov Dmitry", "https://t.me/@dmalex_brf", "https://github.com/brfbrf"],
        ["Rezunik Lyudmila", "https://t.me/lucy_r", "https://github.com/LucyRez"], ["Prozorskiy Mikhail", "https://t.me/michail_prozorskiy", "https://github.com/ProSkyMishka"]]
    
    @State var showInfo: Bool = false
    @State var showDevelopers: Bool = false
    @State var showBosses: Bool = false
    @State var showPartners: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Text(showInfo ? "The PlantPal application allows you to create a virtual greenhouse of indoor plants, tracking their condition and remote watering. It was developed as part of the All-Russian competition of scientific and technological projects “Great Challenges” at the Sirius training center in 2024.\nProject partners: National Research University Higher School of Economics, Faculty of Computer Science (FCS) and the research and educational laboratory of cloud and mobile technologies of the Faculty of Software Engineering of FCS." : "The PlantPal application allows you to create a virtual greenhouse of indoor plants, tracking their condition and...")
                            .font(.system(size: 20))
                            .lineSpacing(15)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 30)
                            .foregroundColor(Theme.textColor)
                            .onTapGesture {
                                showInfo.toggle()
                            }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Developers:")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(Theme.textBrown)
                            .padding(.trailing)
                        
                        Image(systemName: showDevelopers ? "arrow.up" : "arrow.down")
                            .resizable()
                            .frame(width: 10, height: 15)
                            .foregroundColor(Theme.textBrown)
                        
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        showDevelopers.toggle()
                    }
                    
                    if showDevelopers {
                        ForEach(0...(developers.count - 1), id: \.self) {num in
                            DeveloperInfoView(num: num + 1, name: developers[num][0], gitLink: developers[num][2], tgLink:  developers[num][1])
                        }
                    }
                    
                    HStack {
                        Text("Bosses:")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(Theme.textBrown)
                            .padding(.trailing)
                        
                        Image(systemName: showBosses ? "arrow.up" : "arrow.down")
                            .resizable()
                            .frame(width: 10, height: 15)
                            .foregroundColor(Theme.textBrown)
                        
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        showBosses.toggle()
                    }
                    
                    if showBosses {
                        ForEach(0...(bosses.count - 1), id: \.self) {num in
                            DeveloperInfoView(num: num + 1, name: bosses[num][0], gitLink: bosses[num][2], tgLink:  bosses[num][1])
                        }
                    }
                    
                    HStack {
                        Text("Partner:")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(Theme.textBrown)
                            .padding(.trailing)
                        
                        Image(systemName: showPartners ? "arrow.up" : "arrow.down")
                            .resizable()
                            .frame(width: 10, height: 15)
                            .foregroundColor(Theme.textBrown)
                        
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        showPartners.toggle()
                    }
                    
                    if showPartners {
                        VStack(spacing: 15) {
                            Image("CSFLogo")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 50, height: 80)
                            
                            Image("CMTLabLogo")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 50, height: 80)
                                .background(.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                    }
                }
            }
            
            HStack {
                Text("Made in")
                    .font(.system(size: 18))
                    .bold()
                    .foregroundColor(Theme.textBrown)
                
                Link(destination: URL(string: "https://sochisirius.ru")!, label: {
                    Text("Sirius")
                        .font(.system(size: 18))
                        .underline()
                        .foregroundColor(Theme.textAzure)
                })
            }
            
            Text("2024")
                .font(.system(size: 18))
                .bold()
                .foregroundColor(Theme.textBrown)
                .padding(.bottom)
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
        .frame(width: UIScreen.main.bounds.width)
        .padding()
        .edgesIgnoringSafeArea([.bottom, .horizontal])
        .background(Theme.backGround)
        
    }
}
