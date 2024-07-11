//
//  EditCapturedPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 10.07.2024.
//

import SwiftUI

struct EditCapturedPlantView: View {
    @Binding var index: Int
    @Binding var isPresented: Bool
    @Binding var capturedPlant: PlantBaseModel
    @State var colorTheme = ColorLight()
    let numbers = Array(0...100)
    @Binding var image: UIImage?
    @State private var min = 0
    @State private var max = 0
    @State private var selectedNumber = 0

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                    Text(" ")
                        .font(.title3)
                    TextField("Plant name", text: $capturedPlant.name)
                    
                    VStack {
                        HStack{
                            Button(action: {
                                
                            }) {
                                Image(uiImage: image!)
                                    .resizable()
                                    .frame(width: 180, height: 250)
                            }
                            HStack{
                                
                                Picker("Выберите число", selection: $min) {
                                    ForEach(numbers, id: \.self) { number in
                                        Text("\(number)").tag(number)
                                        
                                    }
                                    
                                }
                                ZStack{
                                    Text("-")
                                        .font(.title3)
                                }
                                Picker("Выберите число", selection: $max) {
                                    ForEach(numbers, id: \.self) { number in
                                        Text("\(number)").tag(number)
                                        
                                    }
                                    
                                }
                                ZStack{
                                    Text("°C")
                                        .font(.title3)
                                }
                            }
                        }
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
                        
                        Text(" ")
                        
                        VStack {
                            HStack{
                                Image(systemName: "thermometer.transmission")
                                    .resizable()
                                    .padding()
                                    .frame(width: 75, height: 75)
                                
                                Picker("", selection: $selectedNumber) {
                                    ForEach(numbers, id: \.self) { number in
                                        Text("\(number)").tag(number)
                                        
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                }
                Spacer()
                Text(" ")
                Button(action: {
                    isPresented = false
                    index = 0
                    // coreData сохранение
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
            .padding()
        }    }
}
