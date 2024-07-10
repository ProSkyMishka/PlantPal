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
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    @State var textInRepeat = "Never"
   // @State var replay: RepeatWatering
    
    
    var body: some View {
            ScrollView{
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
                        DatePicker("", selection: $plant.nextWatering).padding(.trailing, 10)
                    }
                }
                HStack{
                    Text("Repeat")
                        .font(.system(size: 20))
                        .padding(.leading, 15)
                    
                    Spacer()

                    HStack{
                        
                        Menu(){
                            Button("Every month", action: {textInRepeat = "Every month"})
                            Button("Every week", action: {textInRepeat = "Every week"})
                            Button("Every day", action: {textInRepeat = "Every day"})
                            Button("Never", action: {textInRepeat = "Never"})
                            
                            // TODO: функция для обновления значения plant.replay
                        }label:{
                            Label(LocalizedStringKey(textInRepeat), systemImage: "timer")
                                .padding(.trailing, 10)
                            }
                    }
                }
                Spacer()
            }
            .onAppear {
                barHidden = true
            }
            .navigationBarBackButtonHidden()
            .toolbar(content: {
                ToolbarItem(placement: .automatic) {
                    Text("\(plant.name) Info")
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
            
        }
}
