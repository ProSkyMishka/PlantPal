//
//  PlantInfoField.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct PlantInfoField: View {
    var textTitle: String
    @Binding var text: String
    @State var notIsEdit: Bool = true
    @FocusState var focused: Bool
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    Text(LocalizedStringKey(textTitle))
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 15)
                    Button(action: {
                        notIsEdit = false
                        focused = true
                    }){
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.green)
                    }
                }
                ZStack {
                    TextField(text, text: $text, axis: .vertical)
                        .padding(.leading, 15)
                        .disabled(notIsEdit)
                        .onSubmit {
                            notIsEdit = true
                        }
                        .lineLimit(3)
                        .focused($focused)
                    
                }
            }
            Spacer()        }
    }
}

