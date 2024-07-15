//
//  GreenTextField.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//

import SwiftUI

struct GreenTextField: View {
    var textTitle: String
    @Binding var text: String
    @FocusState var focused: Bool
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .background(Theme.search)
                
                TextField(textTitle, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(Theme.textColor)
                    .background(Theme.search)
                
            }
            .padding(.all, 15)
            .background(Theme.search)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}

