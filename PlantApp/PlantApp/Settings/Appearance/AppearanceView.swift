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
    let languages = ["English", "Русский"]
    let languagesPreview = ["Eng", "Рус"]
    let themes = ["Light", "Dark"]
    @State var lang = 0
    @State var theme = 0
    @State var showLangDialog = false
    @State var showThemeDialog = false
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    showLangDialog.toggle()
                }){
                    HStack {
                        Text("Language")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Text(languagesPreview[lang])
                            .foregroundColor(.gray)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .alert("Select Language", isPresented: $showLangDialog) {
                        ForEach(0...(languages.count - 1), id: \.self) {num in
                            Button(action: {
                                lang = num
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
                })  {
                    HStack {
                        Text("Appearance")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Text(themes[theme])
                            .foregroundColor(.gray)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .alert("Select App Theme", isPresented: $showThemeDialog) {
                        ForEach(0...(themes.count - 1), id: \.self) {num in
                            Button(action: {
                                theme = num
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
