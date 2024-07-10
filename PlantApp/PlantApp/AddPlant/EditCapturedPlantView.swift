//
//  EditCapturedPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 10.07.2024.
//

import SwiftUI

struct EditCapturedPlantView: View {
    @Binding var capturedPlant: PlantBaseModel

    var body: some View {
        VStack {
            Text(" ")
                .font(.title3)
            TextField("Plant name", text: $capturedPlant.name)
                .bold()
                .font(.title2)
                .foregroundColor(.white)
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
            
            Text(" ")
                .font(.title3)
            TextField("Plant type", text: $capturedPlant.description)
                .bold()
                .font(.title2)
                .foregroundColor(.white)
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
            
            Spacer()
            Button(action: {
            // coreData
                
            }) {
                Text("Save")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Редактировать растение")
    }
}
