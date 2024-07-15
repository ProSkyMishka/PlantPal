//
//  EditCapturedPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 10.07.2024.
//

import SwiftUI
import SwiftData

struct EditCapturedPlantView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    
    @Binding var index: Int
    @Binding var isPresented: Bool
    @State var capturedPlant: ResultPlant
    let numbers = Array(0...100)
    @Binding var image: UIImage?
    @State private var min = 0
    @State private var max = 0
    @State private var selectedNumber = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Edit plant")
                    .foregroundStyle(Theme.textGreen)
                    .font(.system(size: 28))
                    .padding(.vertical, 15)
                    .bold()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                }
                
                VStack(spacing: 20) {
                    TextField("Название растения", text: $capturedPlant.name)
                    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(Theme.textColor)
                        .background(Theme.search)
                        .cornerRadius(10)
                        .padding(.horizontal, 15)
                    
                    
                    
                    TextField("Описание растения", text: $capturedPlant.description)
                    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(Theme.textColor)
                        .background(Theme.search)
                        .cornerRadius(10)
                        .padding(.horizontal, 15)
                    
                    HStack {
                        Image(systemName: "humidity")
                            .foregroundColor(Theme.buttonColor)
                        Picker("Минимум", selection: $min) {
                            ForEach(numbers, id: \.self) { number in
                                Text("\(number)").tag(number)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal)
                        Text("-")
                            .foregroundColor(Theme.buttonColor)
                        Picker("Максимум", selection: $max) {
                            ForEach(numbers, id: \.self) { number in
                                Text("\(number)").tag(number)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal)
                    }
                    
                    HStack {
                        Image(systemName: "thermometer.transmission")
                            .resizable()
                            .foregroundColor(Theme.buttonColor)
                            .frame(width: 30, height: 30)
                        
                        Picker("Выберите число", selection: $selectedNumber) {
                            ForEach(numbers, id: \.self) { number in
                                Text("\(number)°C").tag(number)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal)
                    
                }
                
                Spacer()
                
                Button(action: {
                    let plant = Plant(serverId: capturedPlant.id,
                                      desc: capturedPlant.description,
                                      humidity: capturedPlant.humidity,
                                      temp: capturedPlant.temp,
                                      MLID: capturedPlant.MLID,
                                      imageURL: capturedPlant.imageURL,
                                      seconds: capturedPlant.seconds,
                                      name: capturedPlant.name)
                    plant.image = image?.jpegData(compressionQuality: 1.0)
                    modelContext.insert(plant)
                    
                    isPresented = false
                    index = 0
                }) {
                    
                    Text("Сохранить")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Theme.buttonColor)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                //.padding()
            }
            .padding(.all, 15)
            .background(Theme.backGround)
            .navigationTitle("Редактировать растение")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}
