//
//  InformationForPlant.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct InformationForPlant: View {
    @State var plant: PlantBaseModel
    @State var notIsEdit = true
    @State var isPresented = false
    
    @State var isEditOpen = false
    
    var body: some View {
        VStack {
            //                    ZStack{
            //                        HStack{
            //                            Text(plant.name)
            //                                .font(.system(size: 22, weight: .medium))
            //                        }
            //                    }
            Image(plant.url)
                .resizable()
                .frame(width: 180, height: 180)
                .cornerRadius(8)
            
            PlantInfoField(textTitle: "Name", text: $plant.name, notIsEdit: notIsEdit)
            PlantInfoField(textTitle: "Description", text: $plant.description, notIsEdit: notIsEdit)
            PlantInfoField(textTitle: "Recommended Temperature", text: $plant.temperatureRange, notIsEdit: notIsEdit)
            PlantInfoField(textTitle: "Recommended Humidity", text: $plant.humidity, notIsEdit: notIsEdit)
            
            
            ZStack{
                HStack{
                    VStack{
                        Text("Last watered")
                            .font(.system(size: 20, weight: .bold))
                        
                        if plant.lastWatered != nil {
                            Text(DateTimeFormatter.shared.toString(date: plant.lastWatered!))
                                .font(.system(size: 20))
                        } else {
                            Text("None")
                                .font(.system(size: 20))
                        }}.padding(.leading, 20)
                    Spacer()
                    Button(action:{
                        plant.lastWatered = Date.now
                        
                        // TODO: Call server with new date
                        
                    }){
                        HStack{
                            Image(systemName: "drop.fill")
                                .foregroundColor(.white)
                            Text("Water")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical,8)
                        .background(.blue)
                        .cornerRadius(18)
                    }.padding(.all, 10)
                }
            }
            ZStack{
                HStack{
                    Text("Next watering")
                        .font(.system(size: 20))
                        .padding(.all, 15)
                    Spacer()
                    DatePicker("", selection: $plant.nextWatering)
                }
            }
            ZStack{
                HStack{
                    Text("Repeat")
                        .font(.system(size: 20))
                    Spacer()
                }.padding(.leading, 15)
                HStack{
                    Spacer()
                    Text("\(plant.replay.rawValue) \(Image(systemName:"timer"))")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 30)
                        .onTapGesture {isPresented = true}
                        .popover(isPresented: $isPresented) {
                            Button("Every day"){
                                plant.replay = .everyDay
                            }.padding(.vertical, 0.5)
                            Button("Every week"){
                                plant.replay = .everyWeek
                            }.padding(.vertical, 0.5)
                            Button("Every month"){
                                plant.replay = .everyMonth
                            }.padding(.vertical, 0.5)
                            Button("Never"){
                                plant.replay = .none
                            }.padding(.vertical, 0.5)
                                .presentationCompactAdaptation(.popover)
                        }
                }
            }
            Spacer()
        }
    }
}
