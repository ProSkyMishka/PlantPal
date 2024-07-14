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
    @Environment(LanguageSetting.self) var languageSettings
    let languages = ["English", "Русский"]
    let languagesIdentifiers = ["en", "ru"]
    let themes = [LocalizedStringKey("Light"), LocalizedStringKey("Dark")]
    @State var lang = 0
    @State var showLangDialog = false
    @State var showThemeDialog = false
    @State var theme = Theme.theme
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    showLangDialog.toggle()
                    
                }){
                    HStack {
                        Text("Language")
                            .foregroundColor(Theme.textBrown)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Text("lang")
                            .foregroundColor(Theme.description)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Theme.description)
                    }
                    .alert("Select Language", isPresented: $showLangDialog) {
                        ForEach(0...(languages.count - 1), id: \.self) {num in
                            Button(action: {
                                lang = num
                                languageSettings.locale = Locale(identifier: languagesIdentifiers[lang])
                                UserDefaults.standard.setValue(languagesIdentifiers[lang], forKey: "Language")
                            }, label: {
                                Text(languages[num])
                            })
                        }
                    }
                }
                .padding(.vertical, 10)
                
                Divider()
                
                Button(action: {
                    showThemeDialog.toggle()
                    theme += 1
                    theme %= 2
                    print(theme)
                    UserDefaults.standard.setValue(theme, forKey: "theme")
                })  {
                    HStack{
                        Text("Appearance")
                            .foregroundColor(Theme.textBrown)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Text(themes[Theme.theme])
                            .foregroundColor(Theme.description)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Theme.description)
                    }
                    .alert("Select App Theme", isPresented: $showThemeDialog) {
                        ForEach(0...(themes.count - 1), id: \.self) {num in
                            Button(action: {
                                Theme.changeTheme(colorTheme: num)
                            }, label: {
                                Text(themes[num])
                            })
                        }
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
